class ExpiringMedicineModel {
  final String id;
  final String medicineName;
  final DateTime expireDate;
  final int quantity;
  final String chart;
  final String returnStatus;

  ExpiringMedicineModel({
    required this.id,
    required this.medicineName,
    required this.expireDate,
    required this.quantity,
    required this.chart,
    required this.returnStatus,
  });

  ExpiringMedicineModel copyWith({
    String? id,
    String? medicineName,
    DateTime? expireDate,
    int? quantity,
    String? chart,
    String? returnStatus,
  }) {
    return ExpiringMedicineModel(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      expireDate: expireDate ?? this.expireDate,
      quantity: quantity ?? this.quantity,
      chart: chart ?? this.chart,
      returnStatus: returnStatus ?? this.returnStatus,
    );
  }
}