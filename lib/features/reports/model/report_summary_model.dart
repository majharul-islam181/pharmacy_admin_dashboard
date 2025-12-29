import 'package:flutter/material.dart';

enum ReportSummaryType {
  totalSales,
  totalOrders,
  netProfit,
  refunds,
}

extension ReportSummaryTypeExtension on ReportSummaryType {
  String get title {
    switch (this) {
      case ReportSummaryType.totalSales:
        return 'Total Sales';
      case ReportSummaryType.totalOrders:
        return 'Total Orders';
      case ReportSummaryType.netProfit:
        return 'Net Profit';
      case ReportSummaryType.refunds:
        return 'Refunds';
    }
  }

  IconData get icon {
    switch (this) {
      case ReportSummaryType.totalSales:
        return Icons.show_chart;
      case ReportSummaryType.totalOrders:
        return Icons.shopping_bag_outlined;
      case ReportSummaryType.netProfit:
        return Icons.account_balance_wallet_outlined;
      case ReportSummaryType.refunds:
        return Icons.receipt_long_outlined;
    }
  }
}

class ReportSummaryModel {
  final ReportSummaryType type;
  final String value;
  final String subtitle;
  final String trendLabel;
  final bool trendPositive;

  ReportSummaryModel({
    required this.type,
    required this.value,
    required this.subtitle,
    required this.trendLabel,
    required this.trendPositive,
  });
}
