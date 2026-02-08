class UserModel {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    this.createdAt,
  });

  /// Create UserModel from JSON (from Supabase)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '', 
      email: json['email']?.toString() ?? '', 
      name: json['name']?.toString() ?? 'User', 
      profileImageUrl: json['profile_image_url']
          ?.toString(), 
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(
              json['created_at'].toString(),
            ) 
          : null,
    );
  }

  /// Convert UserModel to JSON (for Supabase insert/update)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profile_image_url': profileImageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }


}
