class PurchaseStatisticsModel {
  final int totalOrders;
  final int pendingOrders;
  final int completedOrders;
  final int cancelledOrders;
  final double totalValue;
  final double averageOrderValue;

  PurchaseStatisticsModel({
    required this.totalOrders,
    required this.pendingOrders,
    required this.completedOrders,
    required this.cancelledOrders,
    required this.totalValue,
    required this.averageOrderValue,
  });
}
