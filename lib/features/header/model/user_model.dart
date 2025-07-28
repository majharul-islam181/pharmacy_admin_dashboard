class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final int notificationCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.notificationCount = 0,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    int? notificationCount,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      notificationCount: notificationCount ?? this.notificationCount,
    );
  }
}
