import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../main_layout_view.dart';
import '../../features/dashboard/views/dashboard_stats_view.dart';
import 'page_transitions.dart';
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
import '../../features/employee_management/view/employee_list_view.dart';
import '../../features/employee_management/view/add_employee_view.dart';
import '../../features/employee_management/view/edit_employee_view.dart';
import '../../features/employee_management/view_model/employee_view_model.dart';
import '../../features/login/view/login_showcase_view.dart';
import '../../features/login/view/classic_login_view.dart';
import '../../features/login/view/modern_login_view.dart';
import '../../features/login/view/animated_login_view.dart';
import '../../features/login/view_model/login_view_model.dart';
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
          pageBuilder: (context, state) => PageTransitions.fade(
            child: const DashboardStatsView(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.crm,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const CrmPage(),
            state: state,
          ),
        ),
        // Purchase
        GoRoute(
          path: AppRoutes.purchase,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const PurchasePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.purchaseAdd,
          pageBuilder: (context, state) => PageTransitions.verticalSlide(
            child: const PurchaseAddPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.purchaseManage,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const PurchaseManagePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.purchaseView,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: const PurchaseViewPage(),
            state: state,
          ),
        ),
        // Dispenser
        GoRoute(
          path: AppRoutes.dispenser,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const DispenserPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.dispenserAdd,
          pageBuilder: (context, state) => PageTransitions.verticalSlide(
            child: const DispenserAddPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.dispenserManage,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const DispenserManagePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.dispenserView,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: const DispenserViewPage(),
            state: state,
          ),
        ),
        // Other main routes
        GoRoute(
          path: AppRoutes.product,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ProductPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.productAdd,
          pageBuilder: (context, state) => PageTransitions.verticalSlide(
            child: const ProductAddPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.productManage,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ProductManagePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.productView,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: const ProductViewPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.productKanban,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => KanbanViewModel(),
              child: const KanbanBoardView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.reports,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ReportsPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.reportsAdd,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ReportsPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.reportsManage,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ReportsManagePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.reportsView,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: const ReportsViewPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.stock,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const StockPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.customer,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const CustomerPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.manufacturer,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const ManufacturerPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.employee,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const EmployeePage(),
            state: state,
          ),
        ),
        // Chat
        GoRoute(
          path: AppRoutes.chat,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => ChatViewModel(),
              child: const ChatView(),
            ),
            state: state,
          ),
        ),
        // Hospital
        GoRoute(
          path: AppRoutes.hospitalDashboard,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => DashboardViewModel(),
              child: const HospitalDashboardView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalDoctor,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => DoctorViewModel(),
              child: const DoctorView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalReview,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => ReviewViewModel(),
              child: const ReviewView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.hospitalPatient,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => PatientViewModel(),
              child: const PatientView(),
            ),
            state: state,
          ),
        ),
        // Attendance
        GoRoute(
          path: AppRoutes.attendanceToday,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const AttendanceView(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.attendanceEmployee,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const AttendanceView(),
            state: state,
          ),
        ),
        // Employee Management
        GoRoute(
          path: AppRoutes.employeeList,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => EmployeeViewModel(),
              child: const EmployeeListView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.employeeAdd,
          pageBuilder: (context, state) => PageTransitions.verticalSlide(
            child: ChangeNotifierProvider(
              create: (_) => EmployeeViewModel(),
              child: const AddEmployeeView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: '${AppRoutes.employeeEdit}/:id',
          pageBuilder: (context, state) {
            final id = state.pathParameters['id']!;
            return PageTransitions.verticalSlide(
              child: ChangeNotifierProvider(
                create: (_) => EmployeeViewModel(),
                child: EditEmployeeView(employeeId: id),
              ),
              state: state,
            );
          },
        ),
        // Components / Widgets
        GoRoute(
          path: AppRoutes.widgetsToast,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const WidgetsToastPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.widgetsButtonElement,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const WidgetsButtonElementPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.widgetsRatingBar,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const WidgetsRatingBarPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.widgetsBadge,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const WidgetsBadgePage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.widgetsModal,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const WidgetsModalPage(),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.settings,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: const SettingsPage(),
            state: state,
          ),
        ),
        // Login Screens
        GoRoute(
          path: AppRoutes.loginShowcase,
          pageBuilder: (context, state) => PageTransitions.fadeSlide(
            child: ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const LoginShowcaseView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.loginClassic,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const ClassicLoginView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.loginModern,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const ModernLoginView(),
            ),
            state: state,
          ),
        ),
        GoRoute(
          path: AppRoutes.loginAnimated,
          pageBuilder: (context, state) => PageTransitions.scaleFade(
            child: ChangeNotifierProvider(
              create: (_) => LoginViewModel(),
              child: const AnimatedLoginView(),
            ),
            state: state,
          ),
        ),
      ],
    ),
  ],
);
