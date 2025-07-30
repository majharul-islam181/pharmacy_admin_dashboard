class RecentOrderModel {
  final String id;
  final String medicineName;
  final String batchNo;
  final int quantity;
  final String status;
  final double price;

  RecentOrderModel({
    required this.id,
    required this.medicineName,
    required this.batchNo,
    required this.quantity,
    required this.status,
    required this.price,
  });

  RecentOrderModel copyWith({
    String? id,
    String? medicineName,
    String? batchNo,
    int? quantity,
    String? status,
    double? price,
  }) {
    return RecentOrderModel(
      id: id ?? this.id,
      medicineName: medicineName ?? this.medicineName,
      batchNo: batchNo ?? this.batchNo,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      price: price ?? this.price,
    );
  }
}