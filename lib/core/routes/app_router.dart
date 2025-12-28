import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../main_layout_view.dart';
import '../../features/dashboard/views/dashboard_stats_view.dart';
import '../../features/crm/presentation/pages/crm_page.dart';
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
import '../../features/reports/presentation/pages/reports_manage_page.dart';
import '../../features/reports/presentation/pages/reports_view_page.dart';
import '../../features/stock/presentation/pages/stock_page.dart';
import '../../features/customers/presentation/pages/customer_page.dart';
import '../../features/manufacturers/presentation/pages/manufacturer_page.dart';
import '../../features/employees/presentation/pages/employee_page.dart';
import '../../features/settings/settings_page.dart';
import '../../features/kanban/view/kanban_board_view.dart';
import '../../features/kanban/view_model/kanban_view_model.dart';
import '../../features/widgets/presentation/pages/widgets_toast_page.dart';
import '../../features/widgets/presentation/pages/widgets_button_element_page.dart';
import '../../features/widgets/presentation/pages/widgets_rating_bar_page.dart';
import '../../features/widgets/presentation/pages/widgets_badge_page.dart';
import '../../features/widgets/presentation/pages/widgets_modal_page.dart';
import '../../features/chat/view/chat_view.dart';
import '../../features/chat/view_model/chat_view_model.dart';
import '../../features/hospital/view/dashboard/hospital_dashboard_view.dart';
import '../../features/hospital/view/doctor/doctor_view.dart';
import '../../features/hospital/view/review/review_view.dart';
import '../../features/hospital/view/patient/patient_view.dart';
import '../../features/hospital/view_model/dashboard_view_model.dart';
import '../../features/hospital/view_model/doctor_view_model.dart';
import '../../features/hospital/view_model/review_view_model.dart';
import '../../features/hospital/view_model/patient_view_model.dart';
import '../../features/attendance/view/attendance_view.dart';
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
        GoRoute(
          path: AppRoutes.crm,
          builder: (context, state) => const CrmPage(),
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
          path: AppRoutes.productKanban,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => KanbanViewModel(),
            child: const KanbanBoardView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.reports,
          builder: (context, state) => const ReportsPage(),
        ),
        GoRoute(
          path: AppRoutes.reportsAdd,
          builder: (context, state) => const ReportsPage(),
        ),
        GoRoute(
          path: AppRoutes.reportsManage,
          builder: (context, state) => const ReportsManagePage(),
        ),
        GoRoute(
          path: AppRoutes.reportsView,
          builder: (context, state) => const ReportsViewPage(),
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
        // Chat
        GoRoute(
          path: AppRoutes.chat,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => ChatViewModel(),
            child: const ChatView(),
          ),
        ),
        // Hospital
        GoRoute(
          path: AppRoutes.hospitalDashboard,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => DashboardViewModel(),
            child: const HospitalDashboardView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalDoctor,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => DoctorViewModel(),
            child: const DoctorView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalReview,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => ReviewViewModel(),
            child: const ReviewView(),
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalPatient,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => PatientViewModel(),
            child: const PatientView(),
          ),
        ),
        // Attendance
        GoRoute(
          path: AppRoutes.attendanceToday,
          builder: (context, state) => const AttendanceView(),
        ),
        GoRoute(
          path: AppRoutes.attendanceEmployee,
          builder: (context, state) => const AttendanceView(),
        ),
        // Components / Widgets
        GoRoute(
          path: AppRoutes.widgetsToast,
          builder: (context, state) => const WidgetsToastPage(),
        ),
        GoRoute(
          path: AppRoutes.widgetsButtonElement,
          builder: (context, state) => const WidgetsButtonElementPage(),
        ),
        GoRoute(
          path: AppRoutes.widgetsRatingBar,
          builder: (context, state) => const WidgetsRatingBarPage(),
        ),
        GoRoute(
          path: AppRoutes.widgetsBadge,
          builder: (context, state) => const WidgetsBadgePage(),
        ),
        GoRoute(
          path: AppRoutes.widgetsModal,
          builder: (context, state) => const WidgetsModalPage(),
        ),
        GoRoute(
          path: AppRoutes.settings,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
