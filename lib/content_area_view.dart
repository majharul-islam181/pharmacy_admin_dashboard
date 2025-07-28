import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/dashboard/views/dashboard_stats_view.dart';
import 'customer_page.dart';
import 'dispenser_add_page.dart';
import 'dispenser_manage_page.dart';
import 'dispenser_page.dart';
import 'dispenser_view_page.dart';
import 'employee_page.dart';
import 'features/navigation/view_model/navigation_view_model.dart';
import 'manufacturer_page.dart';
import 'product_page.dart';
import 'purchase_add_page.dart';
import 'purchase_manage_page.dart';
import 'purchase_page.dart';
import 'purchase_view_page.dart';
import 'reports_page.dart';
import 'settings_page.dart';
import 'stock_page.dart';

class ContentAreaView extends StatelessWidget {
  const ContentAreaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationViewModel>(
      builder: (context, navigationVM, child) {
        return SingleChildScrollView(
          child: _getPageContent(navigationVM.currentPage),
        );
      },
    );
  }

  Widget _getPageContent(String currentPage) {
    switch (currentPage) {
      case 'dashboard':
        return const DashboardStatsView();
      
      // Purchase routes
      case 'purchase':
        return const PurchasePage();
      case 'purchase_add':
        return const PurchaseAddPage();
      case 'purchase_manage':
        return const PurchaseManagePage();
      case 'purchase_view':
        return const PurchaseViewPage();
      
      // Dispenser routes
      case 'dispenser':
        return const DispenserPage();
      case 'dispenser_add':
        return const DispenserAddPage();
      case 'dispenser_manage':
        return const DispenserManagePage();
      case 'dispenser_view':
        return const DispenserViewPage();
      
      // Other main routes
      case 'product':
        return const ProductPage();
      case 'reports':
        return const ReportsPage();
      case 'stock':
        return const StockPage();
      case 'customer':
        return const CustomerPage();
      case 'manufacturer':
        return const ManufacturerPage();
      case 'employee':
        return const EmployeePage();
      case 'settings':
        return const SettingsPage();
      
      default:
        return const DashboardStatsView();
    }
  }
}
