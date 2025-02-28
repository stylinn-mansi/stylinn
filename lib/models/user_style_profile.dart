class UserStyleProfile {
  final String styleGoal;
  final String bodyType;
  final List<String> preferredColors;
  final String budgetRange;

  UserStyleProfile({
    required this.styleGoal,
    required this.bodyType,
    required this.preferredColors,
    required this.budgetRange,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'styleGoal': styleGoal,
      'bodyType': bodyType,
      'preferredColors': preferredColors,
      'budgetRange': budgetRange,
    };
  }

  // Create from JSON
  factory UserStyleProfile.fromJson(Map<String, dynamic> json) {
    return UserStyleProfile(
      styleGoal: json['styleGoal'] as String,
      bodyType: json['bodyType'] as String,
      preferredColors: List<String>.from(json['preferredColors']),
      budgetRange: json['budgetRange'] as String,
    );
  }
} 