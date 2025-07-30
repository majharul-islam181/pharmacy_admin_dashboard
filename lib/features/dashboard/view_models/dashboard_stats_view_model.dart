import 'package:flutter/material.dart';
import '../../../core/localization/locale_keys.dart';
import '../models/expiring_medicine_model.dart';
import '../models/recent_order_model.dart';
import '../models/stats_card_model.dart';
import 'package:easy_localization/easy_localization.dart';
/*
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

*/

class DashboardStatsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;

  List<StatsCardModel> get statsCards => [
    StatsCardModel(
      id: 'total_customer',
      title: LocaleKeys.totalCustomer.tr(),
      value: '120',
      icon: Icons.people,
      iconBackground: const Color(0xFF4285F4),
      onShowDetails: () => _showDetails(LocaleKeys.totalCustomer.tr()),
    ),
    StatsCardModel(
      id: 'total_sales',
      title: LocaleKeys.totalSales.tr(),
      value: '234',
      icon: Icons.shopping_cart,
      iconBackground: const Color(0xFF34A853),
      onShowDetails: () => _showDetails(LocaleKeys.totalSales.tr()),
    ),
    StatsCardModel(
      id: 'total_profit',
      title: LocaleKeys.totalProfit.tr(),
      value: '\$456',
      icon: Icons.monetization_on,
      iconBackground: const Color(0xFFFBBC04),
      onShowDetails: () => _showDetails(LocaleKeys.totalProfit.tr()),
    ),
    StatsCardModel(
      id: 'out_of_stock',
      title: LocaleKeys.outOfStock.tr(),
      value: '56',
      icon: Icons.inventory_2,
      iconBackground: const Color(0xFFEA4335),
      onShowDetails: () => _showDetails(LocaleKeys.outOfStock.tr()),
    ),
  ];

  List<ExpiringMedicineModel> get expiringMedicines => [
    ExpiringMedicineModel(
      id: '1',
      medicineName: 'Doxycycline',
      expireDate: DateTime(2021, 12, 24),
      quantity: 40,
      chart: 'trend_up',
      returnStatus: 'returnable',
    ),
    ExpiringMedicineModel(
      id: '2',
      medicineName: 'Abetis',
      expireDate: DateTime(2021, 12, 24),
      quantity: 40,
      chart: 'trend_up',
      returnStatus: 'returnable',
    ),
    ExpiringMedicineModel(
      id: '3',
      medicineName: 'Diasulin 10ml',
      expireDate: DateTime(2021, 12, 24),
      quantity: 40,
      chart: 'trend_up',
      returnStatus: 'returnable',
    ),
    ExpiringMedicineModel(
      id: '4',
      medicineName: 'Cerox CV',
      expireDate: DateTime(2021, 12, 24),
      quantity: 40,
      chart: 'trend_up',
      returnStatus: 'returnable',
    ),
    ExpiringMedicineModel(
      id: '5',
      medicineName: 'Fluclox',
      expireDate: DateTime(2021, 12, 24),
      quantity: 40,
      chart: 'trend_up',
      returnStatus: 'returnable',
    ),
  ];

  List<RecentOrderModel> get recentOrders => [
    RecentOrderModel(
      id: '1',
      medicineName: 'Paricel 15mg',
      batchNo: '783627834',
      quantity: 40,
      status: 'Delivered',
      price: 23.00,
    ),
    RecentOrderModel(
      id: '2',
      medicineName: 'Abetis 20mg',
      batchNo: '888324433',
      quantity: 40,
      status: 'Pending',
      price: 23.00,
    ),
    RecentOrderModel(
      id: '3',
      medicineName: 'Cerox CV',
      batchNo: '767676344',
      quantity: 40,
      status: 'Cancelled',
      price: 23.00,
    ),
    RecentOrderModel(
      id: '4',
      medicineName: 'Abetis 20mg',
      batchNo: '455788866',
      quantity: 40,
      status: 'Delivered',
      price: 23.00,
    ),
    RecentOrderModel(
      id: '5',
      medicineName: 'Cerox CV',
      batchNo: '767676344',
      quantity: 40,
      status: 'Cancelled',
      price: 23.00,
    ),
  ];

  void _showDetails(String cardTitle) {
    debugPrint('Show details for: $cardTitle');
  }

  Future<void> refreshStats() async {
    _isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2));
    
    _isLoading = false;
    notifyListeners();
  }

  void onSeeAllExpiring() {
    debugPrint('See all expiring medicines');
  }

  void onSeeAllOrders() {
    debugPrint('See all recent orders');
  }
}
