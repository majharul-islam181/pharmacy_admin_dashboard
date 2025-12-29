import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/utils/responsive_utils.dart';
import 'features/header/views/header_view.dart';
import 'features/sidebar/views/mobile_drawer.dart';
import 'features/sidebar/views/sidebar_view.dart';
import 'features/dashboard/views/dashboard_stats_view.dart';

// class CompleteDashboardView extends StatelessWidget {
//   const CompleteDashboardView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDesktop = ResponsiveUtils.isDesktop(context);

//     if (isDesktop) {
//       return _buildDesktopLayout();
//     } else {
//       return _buildMobileLayout(context);
//     }
//   }

//   Widget _buildDesktopLayout() {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Left Sidebar (Fixed)
//           const SidebarView(width: 280),

//           // Right Content Area
//           Expanded(
//             child: Column(
//               children: [
//                 // Header at top
//                 const HeaderView(),

//                 // Main Dashboard Content
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     color: AppColors.backgroundLight, // Light gray background
//                     child: const SingleChildScrollView(
//                       child: DashboardStatsView(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize:
//             Size.fromHeight(ResponsiveUtils.getHeaderHeight(context)),
//         child: const HeaderView(),
//       ),
//       drawer: const MobileDrawer(),
//       backgroundColor: AppColors.backgroundLight,
//       body: const SingleChildScrollView(
//         child: DashboardStatsView(),
//       ),
//     );
//   }
// }

class CompleteDashboardView extends StatelessWidget {
  const CompleteDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);

    if (isDesktop) {
      return _buildDesktopLayout();
    } else {
      return _buildMobileLayout(context);
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar (Fixed)
          const SidebarView(width: 280),

          // Right Content Area
          Expanded(
            child: Column(
              children: [
                // Header at top
                const HeaderView(),

                // Main Dashboard Content
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.backgroundLight, // Light gray background
                    child: const SingleChildScrollView(
                      child: DashboardStatsView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(ResponsiveUtils.getHeaderHeight(context)),
        child: const HeaderView(),
      ),
      drawer: const MobileDrawer(),
      backgroundColor: AppColors.backgroundLight,
      body: const SingleChildScrollView(
        child: DashboardStatsView(),
      ),
    );
  }
}
