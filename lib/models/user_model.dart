class UserModel {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final List<String> stylePreferences;
  final Map<String, dynamic> bodyMeasurements;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    this.stylePreferences = const [],
    this.bodyMeasurements = const {},
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'stylePreferences': stylePreferences,
      'bodyMeasurements': bodyMeasurements,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profileImage: json['profileImage'] as String?,
      stylePreferences: List<String>.from(json['stylePreferences'] ?? []),
      bodyMeasurements: Map<String, dynamic>.from(json['bodyMeasurements'] ?? {}),
    );
  }
} 