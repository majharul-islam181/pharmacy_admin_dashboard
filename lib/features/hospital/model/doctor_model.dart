enum DoctorStatus { available, unavailable }

class DoctorModel {
  final String id;
  final String name;
  final String specialist;
  final DateTime dateOfJoin;
  final int appointmentCount;
  final String contactNumber;
  final double rating;
  final String avatarUrl;
  final DoctorStatus status;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialist,
    required this.dateOfJoin,
    required this.appointmentCount,
    required this.contactNumber,
    required this.rating,
    required this.avatarUrl,
    this.status = DoctorStatus.available,
  });

  String get scheduleStatus {
    if (appointmentCount == 0) return 'No Schedule';
    return '$appointmentCount Appointment';
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialist,
    DateTime? dateOfJoin,
    int? appointmentCount,
    String? contactNumber,
    double? rating,
    String? avatarUrl,
    DoctorStatus? status,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialist: specialist ?? this.specialist,
      dateOfJoin: dateOfJoin ?? this.dateOfJoin,
      appointmentCount: appointmentCount ?? this.appointmentCount,
      contactNumber: contactNumber ?? this.contactNumber,
      rating: rating ?? this.rating,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
    );
  }
}
