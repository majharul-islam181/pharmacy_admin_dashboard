import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
  }
  
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.mobileBreakpoint &&
           MediaQuery.of(context).size.width < AppDimensions.desktopBreakpoint;
  }
  
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
  }
  
  static double getHeaderHeight(BuildContext context) {
    if (isMobile(context)) {
      return AppDimensions.mobileHeaderHeight;
    } else if (isTablet(context)) {
      return AppDimensions.tabletHeaderHeight;
    } else {
      return AppDimensions.headerHeight;
    }
  }
  
  static double getLogoSize(BuildContext context) {
    if (isMobile(context)) {
      return AppDimensions.mobileLogoSize;
    } else if (isTablet(context)) {
      return AppDimensions.tabletLogoSize;
    } else {
      return AppDimensions.logoSize;
    }
  }
  
  static EdgeInsets getHeaderPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium);
    } else {
      return const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge);
    }
  }
  
  static double getSearchBarWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isMobile(context)) {
      return 0; // Hide search bar on mobile
    } else if (isTablet(context)) {
      return AppDimensions.searchBarTabletWidth;
    } else {
      // Dynamic width for desktop based on available space
      return (screenWidth * 0.15).clamp(
        AppDimensions.searchBarMinWidth, 
        AppDimensions.searchBarMaxWidth
      );
    }
  }
  
  static bool shouldShowNavigationText(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }
  
  static int getVisibleNavigationItems(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 5; // All items
    if (screenWidth >= 1000) return 4; // Skip one item
    if (screenWidth >= 850) return 3;  // Show 3 items
    return 0; // Mobile - no navigation items in header
  }
}