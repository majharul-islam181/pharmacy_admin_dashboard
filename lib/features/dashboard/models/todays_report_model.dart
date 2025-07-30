import 'dart:ui';

class TodaysReportModel {
  final double totalEarning;
  final double totalPurchase;
  final double cashReceived;
  final double bankReceive;
  final double totalService;
  final double growthPercentage;

  TodaysReportModel({
    required this.totalEarning,
    required this.totalPurchase,
    required this.cashReceived,
    required this.bankReceive,
    required this.totalService,
    required this.growthPercentage,
  });

  List<ChartDataModel> get chartData => [
    ChartDataModel(
      label: 'Total Purchase',
      value: totalPurchase,
      color: const Color(0xFFEF4444), // Red
    ),
    ChartDataModel(
      label: 'Cash Received',
      value: cashReceived,
      color: const Color(0xFFFBBF24), // Yellow
    ),
    ChartDataModel(
      label: 'Bank Receive',
      value: bankReceive,
      color: const Color(0xFF3B82F6), // Blue
    ),
    ChartDataModel(
      label: 'Total Service',
      value: totalService,
      color: const Color(0xFF10B981), // Green
    ),
  ];
}

class ChartDataModel {
  final String label;
  final double value;
  final Color color;

  ChartDataModel({
    required this.label,
    required this.value,
    required this.color,
  });
}