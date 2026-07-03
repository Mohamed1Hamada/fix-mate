import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'customer_requests_state.dart';

class CustomerRequestsCubit extends Cubit<CustomerRequestsState> {
  CustomerRequestsCubit() : super(CustomerRequestsInitial()) {
    getCustomerRequests();
  }

  final supabase = getIt<SupabaseClient>();

  List<TechnicianRequestModel> allRequests = [];
  late Map<RequestStatus, List<TechnicianRequestModel>> requestsByStatus;
  late StreamSubscription _subscription;

  Future<void> getCustomerRequests() async {
    try {
      emit(CustomerRequestsLoading());
      final userId = supabase.auth.currentUser!.id;
      log(userId);
      _subscription = supabase
          .from('requests')
          .stream(primaryKey: ['id'])
          .eq('technician_id', userId)
          .listen(
            (data) {
              _fetchData(userId);
            },
            onError: (error) {
              emit(CustomerRequestsError(message: error.toString()));
            },
          );
      // Initial fetch
      await _fetchData(userId);
    } catch (e) {
      emit(CustomerRequestsError(message: e.toString()));
    }
  }

  Future<void> _fetchData(String userId) async {
    try {
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
        users (
          id,
          username,
          full_name,
          email,
          phone_number,
          image,
          role,
          tokens,
          complete_profile,
          created_at
        )
      ''').eq('technician_id', userId);
      allRequests = response
          .map<TechnicianRequestModel>(
              (e) => TechnicianRequestModel.fromJson(e))
          .toList();
      _groupByStatus();
      emit(CustomerRequestsSuccess());
    } catch (e) {
      emit(CustomerRequestsError(message: e.toString()));
    }
  }

  // group requests by status
  void _groupByStatus() {
    requestsByStatus = {
      for (var status in RequestStatus.values) status: [],
    };

    for (final request in allRequests) {
      requestsByStatus[request.status]!.add(request);
    }
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}