import 'package:flutter/material.dart';

/// Data model for revenue analytics chart
class RevenueData {
  RevenueData(this.month, this.revenue);
  final String month;
  final double revenue;
}

/// Data model for product sales chart
class ProductSalesData {
  ProductSalesData(this.productName, this.sales, this.color);
  final String productName;
  final int sales;
  final Color color;
}

/// Data model for real-time order tracking
class OrderData {
  OrderData(this.time, this.orders);
  final int time;
  final int orders;
}
