enum EmployeeStatus { active, inactive }

enum EmployeeDepartment {
  sales,
  pharmacy,
  operations,
  management,
  support,
}

class EmployeeModel {
  final String id;
  final String name;
  final String designation;
  final String phone;
  final String email;
  final DateTime joiningDate;
  final String avatarUrl;
  final EmployeeDepartment department;
  final EmployeeStatus status;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.phone,
    required this.email,
    required this.joiningDate,
    required this.avatarUrl,
    required this.department,
    required this.status,
  });

  // Get initials from name
  String get initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  // Get department display name
  String get departmentName {
    switch (department) {
      case EmployeeDepartment.sales:
        return 'Sales';
      case EmployeeDepartment.pharmacy:
        return 'Pharmacy';
      case EmployeeDepartment.operations:
        return 'Operations';
      case EmployeeDepartment.management:
        return 'Management';
      case EmployeeDepartment.support:
        return 'Support';
    }
  }

  // Get status display name
  String get statusName {
    return status == EmployeeStatus.active ? 'Active' : 'Inactive';
  }

  // API-ready serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'phone': phone,
      'email': email,
      'joiningDate': joiningDate.toIso8601String(),
      'avatarUrl': avatarUrl,
      'department': department.name,
      'status': status.name,
    };
  }

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      joiningDate: DateTime.parse(json['joiningDate'] as String),
      avatarUrl: json['avatarUrl'] as String,
      department: EmployeeDepartment.values.firstWhere(
        (e) => e.name == json['department'],
      ),
      status: EmployeeStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
    );
  }

  EmployeeModel copyWith({
    String? id,
    String? name,
    String? designation,
    String? phone,
    String? email,
    DateTime? joiningDate,
    String? avatarUrl,
    EmployeeDepartment? department,
    EmployeeStatus? status,
  }) {
    return EmployeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      designation: designation ?? this.designation,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      joiningDate: joiningDate ?? this.joiningDate,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      department: department ?? this.department,
      status: status ?? this.status,
    );
  }
}
