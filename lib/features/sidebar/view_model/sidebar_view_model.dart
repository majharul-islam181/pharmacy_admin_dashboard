import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/localization/locale_keys.dart';
import '../../../core/routes/app_routes.dart';
import '../model/sidebar_item_model.dart';

// class SidebarViewModel extends ChangeNotifier {
//   String _activeRoute = 'dashboard';
//   final Map<String, bool> _expandedItems = {};

//   String get activeRoute => _activeRoute;

//   List<SidebarItemModel> get sidebarItems => [
//     SidebarItemModel(
//       id: 'dashboard',
//       title: 'Dashboard',
//       icon: Icons.dashboard_outlined,
//       route: 'dashboard',
//       isActive: _activeRoute == 'dashboard',
//     ),
//     SidebarItemModel(
//       id: 'purchase',
//       title: 'Purchase',
//       icon: Icons.shopping_cart_outlined,
//       route: 'purchase',
//       hasSubItems: true,
//       isExpanded: _expandedItems['purchase'] ?? false,
//       isActive: _activeRoute == 'purchase',
//     ),
//     SidebarItemModel(
//       id: 'dispenser',
//       title: 'Dispenser',
//       icon: Icons.local_drink_outlined,
//       route: 'dispenser',
//       hasSubItems: true,
//       isExpanded: _expandedItems['dispenser'] ?? false,
//       isActive: _activeRoute == 'dispenser',
//     ),
//     SidebarItemModel(
//       id: 'product',
//       title: 'Product',
//       icon: Icons.inventory_2_outlined,
//       route: 'product',
//       hasSubItems: true,
//       isExpanded: _expandedItems['product'] ?? false,
//       isActive: _activeRoute == 'product',
//     ),
//     SidebarItemModel(
//       id: 'reports',
//       title: 'Reports',
//       icon: Icons.assessment_outlined,
//       route: 'reports',
//       hasSubItems: true,
//       isExpanded: _expandedItems['reports'] ?? false,
//       isActive: _activeRoute == 'reports',
//     ),
//     SidebarItemModel(
//       id: 'stock',
//       title: 'Stock',
//       icon: Icons.warehouse_outlined,
//       route: 'stock',
//       hasSubItems: true,
//       isExpanded: _expandedItems['stock'] ?? false,
//       isActive: _activeRoute == 'stock',
//     ),
//     SidebarItemModel(
//       id: 'customer',
//       title: 'Customer',
//       icon: Icons.people_outline,
//       route: 'customer',
//       isActive: _activeRoute == 'customer',
//     ),
//     SidebarItemModel(
//       id: 'manufacturer',
//       title: 'Manufacturer',
//       icon: Icons.factory_outlined,
//       route: 'manufacturer',
//       hasSubItems: true,
//       isExpanded: _expandedItems['manufacturer'] ?? false,
//       isActive: _activeRoute == 'manufacturer',
//     ),
//     SidebarItemModel(
//       id: 'employee',
//       title: 'Employee',
//       icon: Icons.badge_outlined,
//       route: 'employee',
//       hasSubItems: true,
//       isExpanded: _expandedItems['employee'] ?? false,
//       isActive: _activeRoute == 'employee',
//     ),
//     SidebarItemModel(
//       id: 'settings',
//       title: 'Settings',
//       icon: Icons.settings_outlined,
//       route: 'settings',
//       isActive: _activeRoute == 'settings',
//     ),
//   ];

//   void navigateToRoute(String route) {
//     _activeRoute = route;
//     notifyListeners();
//   }

//   void toggleExpansion(String itemId) {
//     _expandedItems[itemId] = !(_expandedItems[itemId] ?? false);
//     notifyListeners();
//   }

//   bool isItemExpanded(String itemId) {
//     return _expandedItems[itemId] ?? false;
//   }
// }

class SidebarViewModel extends ChangeNotifier {
  String _activeRoute = AppRoutes.dashboard;
  final Map<String, bool> _expandedItems = {};
  bool _isCollapsed = false;

  String get activeRoute => _activeRoute;
  bool get isCollapsed => _isCollapsed;

  List<SidebarItemModel> get sidebarItems => [
        SidebarItemModel(
          id: 'dashboard',
          title: LocaleKeys.dashboard.tr(),
          icon: Icons.dashboard_outlined,
          route: AppRoutes.dashboard,
          isActive: _activeRoute == AppRoutes.dashboard,
        ),
        SidebarItemModel(
          id: 'crm',
          title: 'CRM',
          icon: Icons.people_alt_outlined,
          route: AppRoutes.crm,
          isActive: _activeRoute == AppRoutes.crm,
        ),
        SidebarItemModel(
          id: 'purchase',
          title: LocaleKeys.purchase.tr(),
          icon: Icons.shopping_cart_outlined,
          route: AppRoutes.purchase,
          hasSubItems: true,
          isExpanded: _expandedItems['purchase'] ?? false,
          isActive: _activeRoute.startsWith('/purchases'),
        ),
        SidebarItemModel(
          id: 'dispenser',
          title: LocaleKeys.dispenser.tr(),
          icon: Icons.local_drink_outlined,
          route: AppRoutes.dispenser,
          hasSubItems: true,
          isExpanded: _expandedItems['dispenser'] ?? false,
          isActive: _activeRoute.startsWith('/dispenser'),
        ),
        SidebarItemModel(
          id: 'product',
          title: LocaleKeys.product.tr(),
          icon: Icons.inventory_2_outlined,
          route: AppRoutes.product,
          hasSubItems: true,
          isExpanded: _expandedItems['product'] ?? false,
          isActive: _activeRoute.startsWith('/products'),
        ),
        SidebarItemModel(
          id: 'productKanban',
          title: 'Kanban Board',
          icon: Icons.view_kanban_outlined,
          route: AppRoutes.productKanban,
          isActive: _activeRoute == AppRoutes.productKanban,
        ),
        SidebarItemModel(
          id: 'reports',
          title: LocaleKeys.reports.tr(),
          icon: Icons.assessment_outlined,
          route: AppRoutes.reports,
          hasSubItems: true,
          isExpanded: _expandedItems['reports'] ?? false,
          isActive: _activeRoute.startsWith('/reports'),
        ),
        SidebarItemModel(
          id: 'stock',
          title: LocaleKeys.stock.tr(),
          icon: Icons.warehouse_outlined,
          route: AppRoutes.stock,
          hasSubItems: true,
          isExpanded: _expandedItems['stock'] ?? false,
          isActive: _activeRoute.startsWith('/stock'),
        ),
        SidebarItemModel(
          id: 'customer',
          title: LocaleKeys.customer.tr(),
          icon: Icons.people_outline,
          route: AppRoutes.customer,
          isActive: _activeRoute == AppRoutes.customer,
        ),
        SidebarItemModel(
          id: 'manufacturer',
          title: LocaleKeys.manufacturer.tr(),
          icon: Icons.factory_outlined,
          route: AppRoutes.manufacturer,
          hasSubItems: true,
          isExpanded: _expandedItems['manufacturer'] ?? false,
          isActive: _activeRoute.startsWith('/manufacturers'),
        ),
        SidebarItemModel(
          id: 'employee',
          title: LocaleKeys.employee.tr(),
          icon: Icons.badge_outlined,
          route: AppRoutes.employee,
          hasSubItems: true,
          isExpanded: _expandedItems['employee'] ?? false,
          isActive: _activeRoute.startsWith('/employees'),
        ),
        SidebarItemModel(
          id: 'chat',
          title: 'Chat',
          icon: Icons.chat_bubble_outline,
          route: AppRoutes.chat,
          isActive: _activeRoute == AppRoutes.chat,
        ),
        SidebarItemModel(
          id: 'componentsHeader',
          title: 'Components',
          icon: Icons.circle,
          route: '',
          isSectionHeader: true,
        ),
        SidebarItemModel(
          id: 'widgets',
          title: 'Widgets',
          icon: Icons.widgets_outlined,
          route: AppRoutes.widgets,
          hasSubItems: true,
          isExpanded: _expandedItems['widgets'] ?? false,
          isActive: _activeRoute.startsWith('/widgets'),
          subItems: [
            SidebarItemModel(
              id: 'widgetsToast',
              title: 'Toast',
              icon: Icons.circle,
              route: AppRoutes.widgetsToast,
            ),
            SidebarItemModel(
              id: 'widgetsButtonElement',
              title: 'Button Element',
              icon: Icons.circle,
              route: AppRoutes.widgetsButtonElement,
            ),
            SidebarItemModel(
              id: 'widgetsRatingBar',
              title: 'Rating Bar',
              icon: Icons.circle,
              route: AppRoutes.widgetsRatingBar,
            ),
            SidebarItemModel(
              id: 'widgetsBadge',
              title: 'Badge',
              icon: Icons.circle,
              route: AppRoutes.widgetsBadge,
            ),
            SidebarItemModel(
              id: 'widgetsModal',
              title: 'Modal',
              icon: Icons.circle,
              route: AppRoutes.widgetsModal,
            ),
          ],
        ),
        SidebarItemModel(
          id: 'settings',
          title: LocaleKeys.settings.tr(),
          icon: Icons.settings_outlined,
          route: AppRoutes.settings,
          isActive: _activeRoute == AppRoutes.settings,
        ),
      ];

  void toggleCollapse() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  void navigateToRoute(BuildContext context, String route) {
    if (_activeRoute == route) return;
    _activeRoute = route;
    notifyListeners();
    context.go(route);
  }

  void toggleExpansion(String itemId) {
    _expandedItems[itemId] = !(_expandedItems[itemId] ?? false);
    notifyListeners();
  }

  bool isItemExpanded(String itemId) {
    return _expandedItems[itemId] ?? false;
  }
}
