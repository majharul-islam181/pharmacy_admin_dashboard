enum PatientStatus { pending, progress, complete }

class PatientModel {
  final String id;
  final DateTime date;
  final String name;
  final String doctorName;
  final String alignment;
  final String roomNumber;
  final PatientStatus status;

  PatientModel({
    required this.id,
    required this.date,
    required this.name,
    required this.doctorName,
    required this.alignment,
    required this.roomNumber,
    required this.status,
  });

  PatientModel copyWith({
    String? id,
    DateTime? date,
    String? name,
    String? doctorName,
    String? alignment,
    String? roomNumber,
    PatientStatus? status,
  }) {
    return PatientModel(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      doctorName: doctorName ?? this.doctorName,
      alignment: alignment ?? this.alignment,
      roomNumber: roomNumber ?? this.roomNumber,
      status: status ?? this.status,
    );
  }
}
