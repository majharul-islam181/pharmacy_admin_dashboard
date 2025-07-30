import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive_utils.dart';
import '../view_models/dashboard_stats_view_model.dart';
import 'widgets/responsive_stats_grid.dart';

// class DashboardStatsView extends StatelessWidget {
//   const DashboardStatsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DashboardStatsViewModel>(
//       builder: (context, viewModel, child) {
//         return Container(
//           width: double.infinity,
//           padding: EdgeInsets.all(
//             ResponsiveUtils.isMobile(context) 
//                 ? AppDimensions.paddingMedium 
//                 : AppDimensions.paddingLarge,
//           ),
//           child: viewModel.isLoading
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Page Title (Optional)
//                     if (ResponsiveUtils.isDesktop(context))
//                       const Padding(
//                         padding: EdgeInsets.only(bottom: AppDimensions.paddingMedium),
//                         child: Text(
//                           'Dashboard Overview',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.w600,
//                             color: Color(0xFF1F2937),
//                           ),
//                         ),
//                       ),
                    
//                     // Stats Cards
//                     ResponsiveStatsGrid(
//                       cards: viewModel.statsCards,
//                     ),
                    
//                     // Add more dashboard content here if needed
//                     const SizedBox(height: AppDimensions.paddingLarge),
//                   ],
//                 ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/localization/locale_keys.dart';
import '../view_models/dashboard_stats_view_model.dart';
import 'widgets/responsive_stats_grid.dart';
import 'widgets/dashboard_tables_section.dart';

class DashboardStatsView extends StatelessWidget {
  const DashboardStatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardStatsViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            ResponsiveUtils.isMobile(context) 
                ? AppDimensions.paddingMedium 
                : AppDimensions.paddingLarge,
          ),
          child: viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    if (ResponsiveUtils.isDesktop(context))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
                        child: Text(
                          LocaleKeys.dashboardOverview.tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                      ),
                    
                    // Stats Cards
                    ResponsiveStatsGrid(
                      cards: viewModel.statsCards,
                    ),
                    
                    const SizedBox(height: AppDimensions.paddingLarge),
                    
                    // Dashboard Tables Section (Expiring List + Recent Orders)
                    const DashboardTablesSection(),
                    
                    const SizedBox(height: AppDimensions.paddingLarge),
                  ],
                ),
        );
      },
    );
  }
}