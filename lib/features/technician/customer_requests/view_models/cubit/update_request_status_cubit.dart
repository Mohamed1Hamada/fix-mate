import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/notifications/fcm_notification.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'update_request_status_state.dart';

class UpdateRequestStatusCubit extends Cubit<UpdateRequestStatusState> {
  UpdateRequestStatusCubit({required this.technicianRequestModel}) : super(UpdateRequestStatusInitial());
  final TechnicianRequestModel technicianRequestModel;
  // variables
  final supabase = getIt<SupabaseClient>();
  RequestStatus? status;
  // update request status
  updateStatus({required RequestStatus status}) {
    this.status = status;
    emit(UpdateSelectedStatus());
  }

  Future<void> updateRequestStatus() async {
    try {
      emit(UpdateRequestStatusLoading());
      await supabase
          .from('requests')
          .update({'status': status!.name}).eq('id', technicianRequestModel.id);
      for (final token in technicianRequestModel.customer!.tokens ?? []) {
      log(token);
      await getIt<NotificationsHelper>().sendNotification(
        title: status!.name,
        body: technicianRequestModel.title,
        token: token,
      );
    }

      emit(UpdateRequestStatusSuccess());
    } catch (e) {
      emit(UpdateRequestStatusError(message: e.toString()));
    }
  }
}
