import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/circle_icon_button.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/features/customer/ai_chat/view_models/cubit/maintenance_ai_chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AIChatInput extends StatefulWidget {
  final VoidCallback onScrollToBottom;
  const AIChatInput({
    super.key,
    required this.onScrollToBottom,
  });

  @override
  State<AIChatInput> createState() => _AIChatInputState();
}

class _AIChatInputState extends State<AIChatInput>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  late AnimationController _sendAnimationController;
  late Animation<double> _sendScaleAnimation;

  @override
  void initState() {
    super.initState();
    _sendAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _sendScaleAnimation = Tween<double>(begin: 1, end: 0.88).animate(
      CurvedAnimation(
        parent: _sendAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _sendAnimationController.dispose();
    super.dispose();
  }

  Future<void> _sendAIMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _selectedImage == null) return;

    _sendAnimationController
        .forward()
        .then((_) => _sendAnimationController.reverse());
    context
        .read<MaintenanceAiChatCubit>()
        .sendAIMessage(message: text, image: _selectedImage);
    _controller.clear();
    setState(() {
      _selectedImage = null;
    });
    widget.onScrollToBottom();
  }

  Future<void> _pickImage(ImageSource source) async {
    Navigator.pop(context);
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  void _showImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _BottomSheetItem(
              icon: Icons.photo_library,
              title: 'from_gallery'.tr(),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            _BottomSheetItem(
              icon: Icons.camera_alt,
              title: 'from_camera'.tr(),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            const SizedBox(height: 8),
            _BottomSheetItem(
              icon: Icons.close,
              title: 'cancel'.tr(),
              onTap: () => Navigator.pop(context),
              isCancel: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900] : Colors.white;
    final fillColor = isDark ? Colors.grey[800] : Colors.grey[100];

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_selectedImage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        _selectedImage!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'image_selected'.tr(),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.close, size: 20, color: Colors.red),
                      onPressed: _clearImage,
                      padding: EdgeInsets.zero,
                      constraints:
                          const BoxConstraints(minWidth: 24, minHeight: 24),
                    ),
                  ],
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleIconButton(
                  icon: Icons.photo,
                  iconColor: Colors.blue,
                  onPressed: _showImagePicker,
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: fillColor,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      maxLines: 1,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendAIMessage(),
                      decoration: InputDecoration(
                        hintText: _selectedImage != null
                            ? 'add_description'.tr()
                            : 'type_message'.tr(),
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        filled: true,
                        fillColor: fillColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color:
                                AppColors.kPrimaryColor.withValues(alpha: 0.5),
                            width: 1,
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            color: AppColors.kPrimaryColor,
                            size: 20,
                          ),
                        ),
                        suffixIcon: _controller.text.trim().isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () => _controller.clear(),
                              )
                            : null,
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ScaleTransition(
                  scale: _sendScaleAnimation,
                  child: CircleIconButton(
                    icon: Icons.send,
                    iconColor: Colors.white,
                    onPressed: _sendAIMessage,
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper widget for bottom sheet items
class _BottomSheetItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isCancel;

  const _BottomSheetItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isCancel = false,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isCancel ? Colors.red : AppColors.kPrimaryColor;
    final bgColor = isCancel
        ? Colors.red.withValues(alpha: 0.1)
        : AppColors.kPrimaryColor.withValues(alpha: 0.1);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isCancel ? Colors.red : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
