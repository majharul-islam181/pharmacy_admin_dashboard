import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';

// class AppLogo extends StatelessWidget {
//   const AppLogo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final logoSize = ResponsiveUtils.getLogoSize(context);
//     final showMenuButton = ResponsiveUtils.isMobile(context) || ResponsiveUtils.isTablet(context);
    
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         // Menu icon for mobile/tablet (only show if drawer available)
//         if (showMenuButton && Scaffold.maybeOf(context)?.hasDrawer == true)
//           IconButton(
//             onPressed: () => Scaffold.of(context).openDrawer(),
//             icon: const Icon(
//               Icons.menu,
//               color: AppColors.iconPrimary,
//             ),
//           ),
        
//         // Logo
//         Container(
//           width: logoSize,
//           height: logoSize,
//           decoration: BoxDecoration(
//             color: AppColors.primary,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(
//             Icons.eco,
//             color: Colors.white,
//             size: logoSize * 0.6,
//           ),
//         ),
//       ],
//     );
//   }
// }


class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final logoSize = ResponsiveUtils.getLogoSize(context);
    final showMenuButton = ResponsiveUtils.isMobile(context) || ResponsiveUtils.isTablet(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Menu icon for mobile/tablet (only show if drawer available)
        if (showMenuButton && Scaffold.maybeOf(context)?.hasDrawer == true)
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: AppColors.iconPrimary,
            ),
          ),
        
        // Logo
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.eco,
            color: Colors.white,
            size: logoSize * 0.6,
          ),
        ),
      ],
    );
  }
}
