import 'package:flutter/material.dart';
import '../model/stats_card_model.dart';

class DashboardStatsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;

  List<StatsCardModel> get statsCards => [
    StatsCardModel(
      id: 'total_customer',
      title: 'Total Customer',
      value: '120',
      icon: Icons.people,
      iconBackground: const Color(0xFF4285F4), // Blue
      onShowDetails: () => _showDetails('Total Customer'),
    ),
    StatsCardModel(
      id: 'total_sales',
      title: 'Total Sales',
      value: '234',
      icon: Icons.shopping_cart,
      iconBackground: const Color(0xFF34A853), // Green
      onShowDetails: () => _showDetails('Total Sales'),
    ),
    StatsCardModel(
      id: 'total_profit',
      title: 'Total Profit',
      value: '\$456',
      icon: Icons.monetization_on,
      iconBackground: const Color(0xFFFBBC04), // Yellow
      onShowDetails: () => _showDetails('Total Profit'),
    ),
    StatsCardModel(
      id: 'out_of_stock',
      title: 'Out of Stock',
      value: '56',
      icon: Icons.inventory_2,
      iconBackground: const Color(0xFFEA4335), // Red
      onShowDetails: () => _showDetails('Out of Stock'),
    ),
  ];

  void _showDetails(String cardTitle) {
    debugPrint('Show details for: $cardTitle');
    // Implement navigation or modal logic here
  }

  Future<void> refreshStats() async {
    _isLoading = true;
    notifyListeners();
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading = false;
    notifyListeners();
  }
}