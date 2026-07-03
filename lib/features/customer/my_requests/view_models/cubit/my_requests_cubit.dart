import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'my_requests_state.dart';

class MyRequestsCubit extends Cubit<MyRequestsState> {
  MyRequestsCubit() : super(GetMyRequestsLoading()) {
    getMyRequests();
  }

  final SupabaseClient supabase = getIt<SupabaseClient>();

  List<TechnicianRequestModel> allRequests = [];
  late Map<RequestStatus, List<TechnicianRequestModel>> requestsByStatus;

  Future<void> getMyRequests() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      log(userId);
      final response = await supabase.from('requests').select('''
      id,
      customer_id,
      technician_id,
      title,
      description,
      request_date,
      image_url,
      status,
      created_at,
      completed_at,
      customer_latitude,
      customer_longtude,
      technicians (
        id,
        specialty_id,
        latitude,
        longitude,
        rating,
        is_available,
        users (
          id,
          username,
          full_name,
          email,
          phone_number,
          image,
          role,
          complete_profile,
          created_at
        ),
        technician_specialties (
          id,
          name,
          image
        )
      )
    ''').eq('customer_id', userId); // أو أي فلتر عايزه
      log(response.toString());
      allRequests = response
          .map<TechnicianRequestModel>(
              (e) => TechnicianRequestModel.fromJson(e))
          .toList();
      log(allRequests.toString());
      _groupByStatus();
      if (isClosed) return;

      emit(GetMyRequestsSuccess());
    } catch (e) {
      log(e.toString());
      if (isClosed) return;
      emit(GetMyRequestsError(message: e.toString()));
    }
  }

  void _groupByStatus() {
    requestsByStatus = {
      for (var status in RequestStatus.values) status: [],
    };

    for (final request in allRequests) {
      requestsByStatus[request.status]!.add(request);
    }
  }
}
