// import 'package:flutter/material.dart';

// class NavigationViewModel extends ChangeNotifier {
//   String _currentPage = 'dashboard';
  
//   String get currentPage => _currentPage;
  
//   void navigateToPage(String pageName) {
//     if (_currentPage != pageName) {
//       _currentPage = pageName;
//       notifyListeners();
//       debugPrint('Navigated to: $pageName');
//     }
//   }
  
//   String getPageTitle() {
//     switch (_currentPage) {
//       case 'dashboard':
//         return 'Dashboard';
//       case 'purchase':
//         return 'Purchase Management';
//       case 'dispenser':
//         return 'Dispenser Control';
//       case 'product':
//         return 'Product Management';
//       case 'reports':
//         return 'Reports & Analytics';
//       case 'stock':
//         return 'Stock Management';
//       case 'customer':
//         return 'Customer Management';
//       case 'manufacturer':
//         return 'Manufacturer Management';
//       case 'employee':
//         return 'Employee Management';
//       case 'settings':
//         return 'Settings';
//       default:
//         return 'Dashboard';
//     }
//   }
// }


import 'package:flutter/material.dart';

class NavigationViewModel extends ChangeNotifier {
  String _currentPage = 'dashboard';
  
  String get currentPage => _currentPage;
  
  void navigateToPage(String pageName) {
    if (_currentPage != pageName) {
      _currentPage = pageName;
      notifyListeners();
      debugPrint('Navigated to: $pageName');
    }
  }
  
  String getPageTitle() {
    switch (_currentPage) {
      case 'dashboard':
        return 'Dashboard';
      case 'purchase':
        return 'Purchase Management';
      case 'dispenser':
        return 'Dispenser Control';
      case 'product':
        return 'Product Management';
      case 'reports':
        return 'Reports & Analytics';
      case 'stock':
        return 'Stock Management';
      case 'customer':
        return 'Customer Management';
      case 'manufacturer':
        return 'Manufacturer Management';
      case 'employee':
        return 'Employee Management';
      case 'settings':
        return 'Settings';
      default:
        return 'Dashboard';
    }
  }
}