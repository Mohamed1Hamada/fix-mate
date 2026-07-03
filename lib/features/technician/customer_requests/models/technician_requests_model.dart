import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';

enum RequestStatus { pending, accepted, completed, cancelled }

class TechnicianRequestModel {
  final String id;
  final String customerId;
  final String technicianId;
  final String title;
  final String? description;
  final DateTime? requestDate;
  final String? imageUrl;
  final RequestStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double? customerLatitude;
  final double? customerLongitude;
  TechnicianModel? technician;
  UserModel? customer;
  TechnicianRequestModel({
    required this.id,
    required this.customerId,
    required this.technicianId,
    required this.title,
    this.description,
    this.requestDate,
    this.imageUrl,
    required this.status,
    required this.createdAt,
    this.completedAt,
    this.customerLatitude,
    this.customerLongitude,
    this.technician,
    this.customer,
  });

  factory TechnicianRequestModel.fromJson(Map<String, dynamic> json) {
    return TechnicianRequestModel(
      id: json['id'] as String,
      customerId: json['customer_id'] as String,
      technicianId: json['technician_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      requestDate: json['request_date'] != null
          ? DateTime.parse(json['request_date'])
          : null,
      imageUrl: json['image_url'] as String?,
      status: RequestStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['status'] as String).toLowerCase(),
        orElse: () => RequestStatus.pending,
      ),
      createdAt: DateTime.parse(json['created_at']),
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
      customerLatitude: (json['customer_latitude'] as num?)?.toDouble(),
      customerLongitude: (json['customer_longtude'] as num?)?.toDouble(),
      technician: json['technicians'] != null
          ? TechnicianModel.fromJson(json['technicians'])
          : null,
      customer:
          json['users'] != null ? UserModel.fromJson(json['users']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'technician_id': technicianId,
      'title': title,
      'description': description,
      'request_date': requestDate?.toIso8601String(),
      'image_url': imageUrl,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'customer_latitude': customerLatitude,
      'customer_longtude': customerLongitude,
      'technician': technician?.toJson(),
      'users': customer?.toJson(),
    };
  }

  copyWith({
    String? id,
    String? customerId,
    String? technicianId,
    String? title,
    String? description,
    DateTime? requestDate,
    String? imageUrl,
    RequestStatus? status,
    DateTime? createdAt,
    DateTime? completedAt,
    double? customerLatitude,
    double? customerLongitude,
    TechnicianModel? technician,
    UserModel? customer,
  }) {
    return TechnicianRequestModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      technicianId: technicianId ?? this.technicianId,
      title: title ?? this.title,
      description: description ?? this.description,
      requestDate: requestDate ?? this.requestDate,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      customerLatitude: customerLatitude ?? this.customerLatitude,
      customerLongitude: customerLongitude ?? this.customerLongitude,
      technician: technician ?? this.technician,
      customer: customer ?? this.customer,
    );
  }
}
