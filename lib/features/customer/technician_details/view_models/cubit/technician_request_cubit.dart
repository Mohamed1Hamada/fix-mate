import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/helper/location/location_cache.dart';
import 'package:fixmate/core/helper/pick_image.dart';
import 'package:fixmate/core/network/supabase/database/add_data.dart';
import 'package:fixmate/core/network/supabase/storage/upload_file.dart';
import 'package:fixmate/core/notifications/fcm_notification.dart';
import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
part 'technician_request_state.dart';

class TechnicianRequestCubit extends Cubit<TechnicianRequestState> {
  TechnicianRequestCubit({required this.technician})
      : super(TechnicianRequestInitial()){
        log(technician.toJson().toString());
      }
  final TechnicianModel technician;
// --> variables
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

// --> functions
  // --> pick date and time
  pickRequestDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      if (!context.mounted) return;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (time != null) {
        selectedDate = date;
        selectedTime = time;
        emit(TechnicianRequestInitial());
      }
    }
  }

  // --> pick image
  pickRequestImage() async {
    try {
      emit(PickImageLoading());
      await pickImage(source: ImageSource.camera).then((value) {
        if (value != null) {
          image = value;
          emit(PickImageSuccess());
        }
        emit(TechnicianRequestInitial());
      });
    } catch (e) {
      emit(PickImageFailed(error: e.toString()));
    }
  }
  // --> pick location

  // --> add request
  addTechnicianRequest() async {
    if (formKey.currentState!.validate()) {
      if (image == null) {
        emit(ImageNotSelected());
        return;
      }
      if (selectedDate == null || selectedTime == null) {
        // You can add a specific state or alert here for unselected date/time if needed.
        // For now, I will default to current date time if not selected, or return error. Let's force them to select.
        emit(AddTechnicianRequestFailed(error: "Please select date and time"));
        return;
      }
      try {
        emit(AddTechnicianRequestLoading());
        
        final requestDateTime = DateTime(
          selectedDate!.year,
          selectedDate!.month,
          selectedDate!.day,
          selectedTime!.hour,
          selectedTime!.minute,
        );

        addData(
          tableName: "requests",
          data: {
            'customer_id': getIt<CacheHelper>().getUserModel()!.id,
            'technician_id': technician.id,
            'title': titleController.text,
            'description': descriptionController.text,
            'request_date': requestDateTime.toIso8601String(),
            'image_url': await uploadFileToSupabaseStorage(
                file: image!, pucketName: "requests"),
            'created_at': DateTime.now().toIso8601String(),
            'customer_latitude': LocationCache().lat,
            'customer_longtude': LocationCache().lng,
          },
        );
        for (final token in technician.tokens ?? []) {
          log(token);
          await getIt<NotificationsHelper>().sendNotification(
            title: "New request from ${getIt<CacheHelper>().getUserModel()!.fullName}",
            body: titleController.text,
            token: token,
          );
        }

        emit(AddTechnicianRequestSuccess());
      } catch (e) {
        emit(AddTechnicianRequestFailed(error: e.toString()));
      }
    }
  }
}
