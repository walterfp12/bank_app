/// Modelo de usuario de la app bancaria
class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? avatarUrl;
  final String? dpi;
  final DateTime? dateOfBirth;
  final DateTime createdAt;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.avatarUrl,
    this.dpi,
    this.dateOfBirth,
    required this.createdAt,
  });

  String get initials {
    final parts = fullName.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      dpi: json['dpi'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'avatar_url': avatarUrl,
      'dpi': dpi,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
