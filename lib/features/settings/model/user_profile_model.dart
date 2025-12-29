class UserProfileModel {
  final String name;
  final String email;
  final String role;
  final String? profileImage;

  UserProfileModel({
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
  });
}
