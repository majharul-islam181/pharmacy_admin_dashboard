import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/routes/app_routes.dart';
import '../model/navigation_item_model.dart';
import '../model/user_model.dart';
import '../model/notification_model.dart';

class HeaderViewModel extends ChangeNotifier {
  String _currentRoute = AppRoutes.dashboard;
  final UserModel _currentUser = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    notificationCount: 3,
  );

  String get currentRoute => _currentRoute;
  UserModel get currentUser => _currentUser;

  final List<NotificationModel> _notifications = const [
    NotificationModel(
      icon: Icons.shopping_bag_outlined,
      iconColor: Color(0xFF10B981),
      title: 'Your order is placed',
      message: 'If several languages coalesce the grammar.',
      timeAgo: '3 min ago',
    ),
    NotificationModel(
      icon: Icons.person_outline,
      iconColor: Color(0xFFF59E0B),
      title: 'James Lemire',
      message: 'It will seem like simplified English.',
      timeAgo: '1 hour ago',
    ),
    NotificationModel(
      icon: Icons.check_circle_outline,
      iconColor: Color(0xFF10B981),
      title: 'Your item is shipped',
      message: 'If several languages coalesce the grammar.',
      timeAgo: '3 min ago',
    ),
    NotificationModel(
      icon: Icons.chat_bubble_outline,
      iconColor: Color(0xFF3B82F6),
      title: 'Salena Layfield',
      message: 'As a skeptical Cambridge friend of mine.',
      timeAgo: '2 hours ago',
    ),
  ];

  List<NotificationModel> get notifications => _notifications;

  List<NavigationItemModel> get navigationItems => [
        NavigationItemModel(
          title: 'Dashboard',
          icon: Icons.dashboard_outlined,
          route: AppRoutes.dashboard,
          isActive: _currentRoute == AppRoutes.dashboard,
        ),
        NavigationItemModel(
          title: 'CRM',
          icon: Icons.people_alt_outlined,
          route: AppRoutes.crm,
          isActive: _currentRoute == AppRoutes.crm,
        ),
        NavigationItemModel(
          title: 'Purchases',
          icon: Icons.shopping_cart_outlined,
          route: AppRoutes.purchase,
          isActive: _currentRoute == AppRoutes.purchase,
        ),
        NavigationItemModel(
          title: 'Products',
          icon: Icons.inventory_2_outlined,
          route: AppRoutes.product,
          isActive: _currentRoute == AppRoutes.product,
        ),
        NavigationItemModel(
          title: 'Reports',
          icon: Icons.assessment_outlined,
          route: AppRoutes.reports,
          isActive: _currentRoute == AppRoutes.reports,
        ),
        NavigationItemModel(
          title: 'Settings',
          icon: Icons.settings_outlined,
          route: AppRoutes.settings,
          isActive: _currentRoute == AppRoutes.settings,
        ),
      ];

  void navigateToRoute(BuildContext context, String route) {
    if (_currentRoute == route) return;
    _currentRoute = route;
    notifyListeners();
    context.go(route);
  }

  void openProfile() {
    // Handle profile navigation
    debugPrint('Opening profile');
  }

  void openNotifications() {
    // Handle notifications navigation
    debugPrint('Opening notifications');
  }

  void openSearch() {
    // Handle search navigation
    debugPrint('Opening search');
  }

  void toggleProfileMenu() {
    // Handle profile menu toggle
    debugPrint('Toggling profile menu');
  }
}
