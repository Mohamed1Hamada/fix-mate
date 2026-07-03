import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';

class TechnicianModel {
  final String id;
  final String specialtyId;
  final double latitude;
  final double longitude;
  final double rating;
  final bool isAvailable;

  // user info
  final String fullName;
  final String image;
  final String phoneNumber;
  final String email;
  List<String>? tokens;

  // extra
  final double? distance;
  final TechnicianSpecialtyModel? specialty;

  TechnicianModel({
    required this.id,
    required this.specialtyId,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.isAvailable,
    required this.fullName,
    required this.image,
    required this.phoneNumber,
    required this.email,
    this.distance,
    this.specialty,
    this.tokens,
  });

  factory TechnicianModel.fromJson(Map<String, dynamic> json) {
    final user = json['users'] as Map<String, dynamic>?;

    return TechnicianModel(
      id: json['id'] as String,
      specialtyId: json['specialty_id'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      isAvailable: json['is_available'] as bool? ?? false,
      fullName: user?['full_name'] ?? '',
      image: user?['image'] ?? '',
      phoneNumber: user?['phone_number'] ?? '',
      email: user?['email'] ?? '',
      distance: (json['distance'] as num?)?.toDouble(),
      specialty: json['technician_specialties'] != null
          ? TechnicianSpecialtyModel.fromJson(
              json['technician_specialties'] as Map<String, dynamic>,
            )
          : null,
      tokens: user?['tokens'] is List
          ? List<String>.from(user?['tokens'])
          : user?['tokens'] is String
              ? [user?['tokens']]
              : [],
    );
  }

  TechnicianModel copyWith({
    String? id,
    String? specialtyId,
    double? latitude,
    double? longitude,
    double? rating,
    bool? isAvailable,
    String? fullName,
    String? image,
    String? phoneNumber,
    String? email,
    double? distance,
    TechnicianSpecialtyModel? specialty,
    List<String>? tokens,
  }) {
    return TechnicianModel(
      id: id ?? this.id,
      specialtyId: specialtyId ?? this.specialtyId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      rating: rating ?? this.rating,
      isAvailable: isAvailable ?? this.isAvailable,
      fullName: fullName ?? this.fullName,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      distance: distance ?? this.distance,
      specialty: specialty ?? this.specialty,
      tokens: tokens ?? this.tokens,
    );
  }

  toJson() => {
        'id': id,
        'specialty_id': specialtyId,
        'latitude': latitude,
        'longitude': longitude,
        'rating': rating,
        'is_available': isAvailable,
        'users': {
          'full_name': fullName,
          'image': image,
          'phone_number': phoneNumber,
          'email': email,
          "tokens": tokens
        },
      };
  @override
  String toString() =>
      'Technician(id: $id, name: $fullName, specialtyId: $specialtyId, rating: $rating, distance: $distance)';
}
