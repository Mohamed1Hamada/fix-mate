class UserModel {
  final String id;
  final String userName;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String image;
  final String role;
  final bool isCompleteProfile;
  final DateTime? createdAt;
  List<String>? tokens;

  UserModel({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.image,
    required this.role,
    required this.isCompleteProfile,
    this.createdAt,
    this.tokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      userName: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      isCompleteProfile: json['complete_profile'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      tokens: json['tokens'] is List
          ? List<String>.from(json['tokens'])
          : json['tokens'] is String
              ? [json['tokens']]
              : [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': userName,
        'full_name': fullName,
        'email': email,
        'phone_number': phoneNumber,
        'image': image,
        'role': role,
        'complete_profile': isCompleteProfile,
        if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
        'tokens': tokens,
      };

  @override
  String toString() =>
      'User(id: $id, name: $fullName, role: $role, complete: $isCompleteProfile)';
}
