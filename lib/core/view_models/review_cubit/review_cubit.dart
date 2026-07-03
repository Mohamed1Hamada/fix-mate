import 'package:bloc/bloc.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/models/review_model.dart';
import 'package:flutter/material.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  final commentController = TextEditingController();
  double rating = 5.0;

  Future<void> addReview(String technicianId) async {
    if (rating == 0) return;
    try {
      emit(AddReviewLoading());
      final customerId = getIt<CacheHelper>().getUserModel()!.id;
      
      await getIt<SupabaseClient>().from('reviews').insert({
        'customer_id': customerId,
        'technician_id': technicianId,
        'rating': rating,
        'comment': commentController.text,
      });

      commentController.clear();
      rating = 5.0;
      emit(AddReviewSuccess());
      // Await the refresh to ensure state is updated
      await fetchReviews(technicianId, isRefresh: true);
    } catch (e) {
      emit(AddReviewFailure(error: e.toString()));
    }
  }

  Future<void> fetchReviews(String technicianId, {bool isRefresh = false}) async {
    try {
      if (!isRefresh) {
        emit(FetchReviewsLoading());
      }
      // Using explicit join to avoid ambiguity if multiple FKs exist
      final response = await getIt<SupabaseClient>()
          .from('reviews')
          .select('*, users!customer_id(*)')
          .eq('technician_id', technicianId)
          .order('created_at', ascending: false);
      
      final reviews = (response as List).map((e) => ReviewModel.fromJson(e)).toList();
      emit(FetchReviewsSuccess(reviews: reviews));
    } catch (e) {
      emit(FetchReviewsFailure(error: e.toString()));
    }
  }
}
