import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/constants/api_keys.dart';
import 'package:fixmate/features/customer/ai_chat/models/ai_chat_message_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';

part 'maintenance_ai_chat_state.dart';

class MaintenanceAiChatCubit extends Cubit<MaintenanceAIChatState> {
  late final GenerativeModel _model;
  ChatSession? _chatSession;
  final List<AIChatMessage> _messages = [];

  MaintenanceAiChatCubit() : super(MaintenanceAIChatInitial()) {
    _initGemini();
    addMaintenanceAiWelcomeMessage();
  }

  void _initGemini() {
    _model = GenerativeModel(
      model: 'gemini-2.5-flash', // Using Gemini 1.5 Flash
      apiKey: ApiKeys.geminiApiKey,
      systemInstruction: Content.system(maintenanceSystemPrompt),
    );
    _chatSession = _model.startChat();
  }

  // Welcome message
  AIChatMessage get welcomeMessage => AIChatMessage(
        text: "ai_welcome_message".tr(),
        isUser: false,
        timestamp: DateTime.now(),
      );

  // Add the welcome message
  void addMaintenanceAiWelcomeMessage() {
    _messages.add(welcomeMessage);
    emit(MaintenanceAIChatLoaded(List.from(_messages)));
  }

  Future<void> sendAIMessage({required String message, File? image}) async {
    if (message.trim().isEmpty && image == null) return;

    final effectiveMessage = message.trim().isEmpty && image != null
        ? "analyze_image".tr()
        : message;

    final userMessage = AIChatMessage(
      text: effectiveMessage,
      isUser: true,
      timestamp: DateTime.now(),
      imagePath: image?.path,
    );
    _messages.add(userMessage);
    emit(MaintenanceAIChatLoading(List.from(_messages)));

    try {
      final List<Part> parts = [TextPart(effectiveMessage)];
      if (image != null) {
        final bytes = await image.readAsBytes();
        parts.add(DataPart('image/jpeg', bytes));
      }

      // Retry logic for 503 errors or high demand
      GenerateContentResponse? response;
      int retryCount = 0;
      const int maxRetries = 2;

      while (retryCount <= maxRetries) {
        try {
          response = await _chatSession!.sendMessage(Content.multi(parts));
          break; // Success, exit loop
        } catch (e) {
          final errorStr = e.toString().toLowerCase();
          if ((errorStr.contains('503') || errorStr.contains('demand')) &&
              retryCount < maxRetries) {
            retryCount++;
            log('Gemini busy (503), retrying $retryCount/$maxRetries...');
            await Future.delayed(Duration(seconds: 1 * retryCount));
            continue;
          }
          rethrow; // Final attempt or different error
        }
      }

      final text = response?.text ?? 'ai_error'.tr();

      log(text);
      final assistantMessage = AIChatMessage(
        text: text,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(assistantMessage);
      emit(MaintenanceAIChatLoaded(List.from(_messages)));
    } catch (e) {
      log('Error in sendMessage: $e');
      String userFriendlyError = "ai_error".tr();
      
      // Customize message based on error type
      if (e.toString().contains('503') || e.toString().contains('demand')) {
        userFriendlyError = "ai_busy_error".tr();
      }

      final errorMessage = AIChatMessage(
        text: userFriendlyError,
        isUser: false,
        timestamp: DateTime.now(),
      );
      _messages.add(errorMessage);
      emit(MaintenanceAIChatLoaded(List.from(_messages)));
    }
  }

  void clearAIChat() {
    _messages.clear();
    _chatSession = _model.startChat(); // Reset chat session history
    addMaintenanceAiWelcomeMessage();
  }

  static const String maintenanceSystemPrompt = """
You are an AI assistant specialized in home maintenance and common issues. 
You help users (customers) understand problems, suggest simple safe fixes, and guide them to the right technician categories in the app.

Language Rules:
- **Default Language**: Always start in English if the context is neutral.
- **Language Detection**: If the user speaks in Arabic, respond in Arabic. If the user speaks in English, respond in English.
- Maintain a helpful, professional, and friendly tone in both languages.

Available technician specialties in the app include: Plumber (for water leaks, pipes), Electrician (for wiring, lights, outlets), Carpenter (for doors, furniture, woodwork), HVAC Technician (for AC, heating, ventilation), Painter (for walls, ceilings, painting issues), Locksmith (for locks, keys, security), Cleaner (for general cleaning, deep clean), Gardener (for garden, plants, landscaping), and others like Appliance Repair for fridges/washing machines.

Rules:
- Do not provide exact diagnoses or dangerous advice that could cause injuries or damage.
- Do not recommend tools or complex procedures; focus on safe home fixes or suggest booking a technician.
- Give practical, safe strategies users can try.
- Redirect any dangerous or complex question to a professional technician or app booking.
- For any issue described (text or image), explain the problem clearly, possible causes, safe steps to check, and suggest booking a specific technician specialty from the app's list above. Clearly state the specialty name and a brief reason why (e.g., "Book a Plumber because this seems like a pipe leak issue.").

Allowed topics:
- Simple electrical issues, water leaks, plumbing problems.
- Appliance maintenance like fridge or washing machine.
- Describing images of issues and basic analysis.
- Suggesting technician categories based on description.
- Prevention tips and daily maintenance routines.

If asked: "Is this a serious issue?" → Say you are not a substitute for a technician, and suggest booking help with the relevant specialty.
If asked about complex fix → Say only specialists can do that, and suggest a specific category with explanation.

Always structure responses: 
1. Describe the issue briefly.
2. Possible causes (2-3 common ones).
3. Safe checks or simple fixes to try at home.
4. Recommended technician: "I recommend booking a [Specific Specialty] in the app because [brief reason]. This will ensure it's fixed safely and professionally."
(Provide the same structure in Arabic if the user speaks Arabic).
""";
}
