import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';
import '../model/navigation_item_model.dart';
import '../model/user_model.dart';

class HeaderViewModel extends ChangeNotifier {
  String _currentRoute = AppRoutes.home;
  final UserModel _currentUser = UserModel(
    id: '1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    notificationCount: 3,
  );

  String get currentRoute => _currentRoute;
  UserModel get currentUser => _currentUser;

  List<NavigationItemModel> get navigationItems => [
    NavigationItemModel(
      title: 'Home',
      icon: Icons.home_outlined,
      route: AppRoutes.home,
      isActive: _currentRoute == AppRoutes.home,
    ),
    NavigationItemModel(
      title: 'Explore',
      icon: Icons.explore_outlined,
      route: AppRoutes.explore,
      isActive: _currentRoute == AppRoutes.explore,
    ),
    NavigationItemModel(
      title: 'My Accounts',
      icon: Icons.account_balance_wallet_outlined,
      route: AppRoutes.myAccounts,
      isActive: _currentRoute == AppRoutes.myAccounts,
    ),
    NavigationItemModel(
      title: 'Accountants',
      icon: Icons.people_outline,
      route: AppRoutes.accountants,
      isActive: _currentRoute == AppRoutes.accountants,
    ),
    NavigationItemModel(
      title: 'Stakeholders',
      icon: Icons.business_outlined,
      route: AppRoutes.stakeholders,
      isActive: _currentRoute == AppRoutes.stakeholders,
    ),
  ];

  void navigateToRoute(String route) {
    _currentRoute = route;
    notifyListeners();
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
