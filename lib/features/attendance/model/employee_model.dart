class EmployeeModel {
  final String id;
  final String name;
  final String email;
  final String department;
  final String position;
  final String avatarUrl;
  final DateTime joinDate;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
    required this.position,
    required this.avatarUrl,
    required this.joinDate,
  });

  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? email,
    String? department,
    String? position,
    String? avatarUrl,
    DateTime? joinDate,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      position: position ?? this.position,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      joinDate: joinDate ?? this.joinDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
      'position': position,
      'avatarUrl': avatarUrl,
      'joinDate': joinDate.toIso8601String(),
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      department: json['department'],
      position: json['position'],
      avatarUrl: json['avatarUrl'],
      joinDate: DateTime.parse(json['joinDate']),
    );
  }
}
