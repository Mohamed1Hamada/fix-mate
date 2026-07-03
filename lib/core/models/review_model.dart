import 'package:fixmate/features/auth/sign_in/models/user_model.dart';

class ReviewModel {
  final String id;
  final String customerId;
  final String technicianId;
  final double rating;
  final String? comment;
  final DateTime createdAt;
  final UserModel? customer;

  ReviewModel({
    required this.id,
    required this.customerId,
    required this.technicianId,
    required this.rating,
    this.comment,
    required this.createdAt,
    this.customer,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      technicianId: json['technician_id'] as String,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      createdAt: DateTime.parse(json['created_at']),
      customer: json['users'] != null
          ? (json['users'] is List
              ? UserModel.fromJson(json['users'][0])
              : UserModel.fromJson(json['users']))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'technician_id': technicianId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
