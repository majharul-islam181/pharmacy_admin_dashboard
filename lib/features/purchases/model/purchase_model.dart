class PurchaseModel {
  final String id;
  final String orderId;
  final String supplierName;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final PurchaseStatus status;
  final DateTime orderDate;
  final DateTime? deliveryDate;

  PurchaseModel({
    required this.id,
    required this.orderId,
    required this.supplierName,
    required this.productName,
    required this.quantity,
    required this.unitPrice,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
  });

  double get calculatedTotal => quantity * unitPrice;
}

enum PurchaseStatus {
  pending,
  inProgress,
  completed,
  cancelled,
}

extension PurchaseStatusExtension on PurchaseStatus {
  String get displayName {
    switch (this) {
      case PurchaseStatus.pending:
        return 'Pending';
      case PurchaseStatus.inProgress:
        return 'In Progress';
      case PurchaseStatus.completed:
        return 'Completed';
      case PurchaseStatus.cancelled:
        return 'Cancelled';
    }
  }
}
