import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/localization/locale_keys.dart';
import '../models/stats_card_model.dart';
import '../models/expiring_medicine_model.dart';
import '../models/recent_order_model.dart';
import '../models/monthly_progress_model.dart';
import '../models/todays_report_model.dart';
import '../models/chart_data_models.dart';

class DashboardStatsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _selectedPeriod = 'Monthly';

  bool get isLoading => _isLoading;
  String get selectedPeriod => _selectedPeriod;

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

  List<MonthlyProgressModel> get monthlyProgressData => [
        MonthlyProgressModel(month: 'Jan', value: 70),
        MonthlyProgressModel(month: 'Feb', value: 45),
        MonthlyProgressModel(month: 'Mar', value: 55),
        MonthlyProgressModel(month: 'Apr', value: 80),
        MonthlyProgressModel(month: 'May', value: 20),
        MonthlyProgressModel(month: 'Jun', value: 45),
        MonthlyProgressModel(
            month: 'Jul',
            value: 85,
            isHighlighted: true), // September in the image
        MonthlyProgressModel(month: 'Aug', value: 50),
        MonthlyProgressModel(month: 'Sep', value: 70),
        MonthlyProgressModel(month: 'Oct', value: 50),
        MonthlyProgressModel(month: 'Nov', value: 75),
        MonthlyProgressModel(month: 'Dec', value: 30),
      ];

  TodaysReportModel get todaysReport => TodaysReportModel(
        totalEarning: 5098.00,
        totalPurchase: 1200.00,
        cashReceived: 800.00,
        bankReceive: 1500.00,
        totalService: 1598.00,
        growthPercentage: 35.0,
      );

  void _showDetails(String cardTitle) {
    debugPrint('Show details for: $cardTitle');
  }

  void changePeriod(String period) {
    _selectedPeriod = period;
    notifyListeners();
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

  // Premium Charts Data
  List<RevenueData> get revenueCurrentData => [
        RevenueData('Jan', 45),
        RevenueData('Feb', 52),
        RevenueData('Mar', 48),
        RevenueData('Apr', 61),
        RevenueData('May', 55),
        RevenueData('Jun', 67),
        RevenueData('Jul', 72),
        RevenueData('Aug', 68),
        RevenueData('Sep', 75),
        RevenueData('Oct', 82),
        RevenueData('Nov', 78),
        RevenueData('Dec', 88),
      ];

  List<RevenueData> get revenuePreviousData => [
        RevenueData('Jan', 38),
        RevenueData('Feb', 42),
        RevenueData('Mar', 45),
        RevenueData('Apr', 48),
        RevenueData('May', 51),
        RevenueData('Jun', 55),
        RevenueData('Jul', 58),
        RevenueData('Aug', 54),
        RevenueData('Sep', 62),
        RevenueData('Oct', 65),
        RevenueData('Nov', 68),
        RevenueData('Dec', 71),
      ];

  List<ProductSalesData> get topProductsData => [
        ProductSalesData('Paracetamol', 245, const Color(0xFF2196F3)),
        ProductSalesData('Amoxicillin', 189, const Color(0xFF4CAF50)),
        ProductSalesData('Omeprazole', 167, const Color(0xFFFF9800)),
        ProductSalesData('Metformin', 142, const Color(0xFF9C27B0)),
        ProductSalesData('Atorvastatin', 128, const Color(0xFFF44336)),
        ProductSalesData('Lisinopril', 98, const Color(0xFF00BCD4)),
      ];

  double get currentSales => 85000;
  double get targetSales => 100000;
  String get salesPeriod => 'This Month';
}
