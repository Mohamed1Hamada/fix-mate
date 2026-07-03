part of 'review_cubit.dart';

@immutable
sealed class ReviewState {}

final class ReviewInitial extends ReviewState {}

// Add Review
final class AddReviewLoading extends ReviewState {}
final class AddReviewSuccess extends ReviewState {}
final class AddReviewFailure extends ReviewState {
  final String error;
  AddReviewFailure({required this.error});
}

// Fetch Reviews
final class FetchReviewsLoading extends ReviewState {}
final class FetchReviewsSuccess extends ReviewState {
  final List<ReviewModel> reviews;
  FetchReviewsSuccess({required this.reviews});
}
final class FetchReviewsFailure extends ReviewState {
  final String error;
  FetchReviewsFailure({required this.error});
}
