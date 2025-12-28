enum AttendanceStatus { present, late, absent, leave }

class AttendanceModel {
  final String id;
  final String employeeId;
  final String employeeName;
  final String department;
  final DateTime date;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final AttendanceStatus status;
  final String? notes;

  AttendanceModel({
    required this.id,
    required this.employeeId,
    required this.employeeName,
    required this.department,
    required this.date,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
    this.notes,
  });

  String get workPeriod {
    if (checkInTime == null || checkOutTime == null) {
      return checkInTime != null ? 'Working...' : 'N/A';
    }
    final duration = checkOutTime!.difference(checkInTime!);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  bool get isLate {
    if (checkInTime == null) return false;
    final standardTime = DateTime(
      checkInTime!.year,
      checkInTime!.month,
      checkInTime!.day,
      9,
      0,
    );
    return checkInTime!.isAfter(standardTime);
  }

  AttendanceModel copyWith({
    String? id,
    String? employeeId,
    String? employeeName,
    String? department,
    DateTime? date,
    DateTime? checkInTime,
    DateTime? checkOutTime,
    AttendanceStatus? status,
    String? notes,
  }) {
    return AttendanceModel(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      employeeName: employeeName ?? this.employeeName,
      department: department ?? this.department,
      date: date ?? this.date,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }

  // API-ready serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'employeeName': employeeName,
      'department': department,
      'date': date.toIso8601String(),
      'checkInTime': checkInTime?.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
      'status': status.name,
      'notes': notes,
    };
  }

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json['id'],
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
      department: json['department'],
      date: DateTime.parse(json['date']),
      checkInTime: json['checkInTime'] != null
          ? DateTime.parse(json['checkInTime'])
          : null,
      checkOutTime: json['checkOutTime'] != null
          ? DateTime.parse(json['checkOutTime'])
          : null,
      status: AttendanceStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      notes: json['notes'],
    );
  }
}
