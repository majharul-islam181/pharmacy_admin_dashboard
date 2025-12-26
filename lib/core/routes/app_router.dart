import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main_layout_view.dart';
import '../../features/dashboard/views/dashboard_stats_view.dart';
import '../../features/purchases/presentation/pages/purchase_page.dart';
import '../../features/purchases/presentation/pages/purchase_add_page.dart';
import '../../features/purchases/presentation/pages/purchase_manage_page.dart';
import '../../features/purchases/presentation/pages/purchase_view_page.dart';
import '../../features/dispenser/presentation/pages/dispenser_page.dart';
import '../../features/dispenser/presentation/pages/dispenser_add_page.dart';
import '../../features/dispenser/presentation/pages/dispenser_manage_page.dart';
import '../../features/dispenser/presentation/pages/dispenser_view_page.dart';
import '../../features/products/presentation/pages/product_page.dart';
import '../../features/products/presentation/pages/product_add_page.dart';
import '../../features/products/presentation/pages/product_manage_page.dart';
import '../../features/products/presentation/pages/product_view_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/stock/presentation/pages/stock_page.dart';
import '../../features/customers/presentation/pages/customer_page.dart';
import '../../features/manufacturers/presentation/pages/manufacturer_page.dart';
import '../../features/employees/presentation/pages/employee_page.dart';
import '../../features/settings/settings_page.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.dashboard,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayoutView(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.dashboard,
          builder: (context, state) => const DashboardStatsView(),
        ),
        // Purchase
        GoRoute(
          path: AppRoutes.purchase,
          builder: (context, state) => const PurchasePage(),
        ),
        GoRoute(
          path: AppRoutes.purchaseAdd,
          builder: (context, state) => const PurchaseAddPage(),
        ),
        GoRoute(
          path: AppRoutes.purchaseManage,
          builder: (context, state) => const PurchaseManagePage(),
        ),
        GoRoute(
          path: AppRoutes.purchaseView,
          builder: (context, state) => const PurchaseViewPage(),
        ),
        // Dispenser
        GoRoute(
          path: AppRoutes.dispenser,
          builder: (context, state) => const DispenserPage(),
        ),
        GoRoute(
          path: AppRoutes.dispenserAdd,
          builder: (context, state) => const DispenserAddPage(),
        ),
        GoRoute(
          path: AppRoutes.dispenserManage,
          builder: (context, state) => const DispenserManagePage(),
        ),
        GoRoute(
          path: AppRoutes.dispenserView,
          builder: (context, state) => const DispenserViewPage(),
        ),
        // Other main routes
        GoRoute(
          path: AppRoutes.product,
          builder: (context, state) => const ProductPage(),
        ),
        GoRoute(
          path: AppRoutes.productAdd,
          builder: (context, state) => const ProductAddPage(),
        ),
        GoRoute(
          path: AppRoutes.productManage,
          builder: (context, state) => const ProductManagePage(),
        ),
        GoRoute(
          path: AppRoutes.productView,
          builder: (context, state) => const ProductViewPage(),
        ),
        GoRoute(
          path: AppRoutes.reports,
          builder: (context, state) => const ReportsPage(),
        ),
        GoRoute(
          path: AppRoutes.stock,
          builder: (context, state) => const StockPage(),
        ),
        GoRoute(
          path: AppRoutes.customer,
          builder: (context, state) => const CustomerPage(),
        ),
        GoRoute(
          path: AppRoutes.manufacturer,
          builder: (context, state) => const ManufacturerPage(),
        ),
        GoRoute(
          path: AppRoutes.employee,
          builder: (context, state) => const EmployeePage(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
