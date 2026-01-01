import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_models/dashboard_stats_view_model.dart';
import 'monthly_progress_syncfusion_card.dart';
import 'todays_report_card.dart';

class DashboardChartsSection extends StatelessWidget {
  const DashboardChartsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardStatsViewModel>(
      builder: (context, viewModel, child) {
        if (ResponsiveUtils.isMobile(context)) {
          return _buildMobileLayout(viewModel);
        } else if (ResponsiveUtils.isTablet(context)) {
          return _buildTabletLayout(viewModel);
        } else {
          return _buildDesktopLayout(viewModel);
        }
      },
    );
  }

  Widget _buildMobileLayout(DashboardStatsViewModel viewModel) {
    return Column(
      children: [
        MonthlyProgressSyncfusionCard(
          data: viewModel.monthlyProgressData,
          selectedPeriod: viewModel.selectedPeriod,
          onPeriodChanged: viewModel.changePeriod,
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        TodaysReportCard(
          report: viewModel.todaysReport,
        ),
      ],
    );
  }

  Widget _buildTabletLayout(DashboardStatsViewModel viewModel) {
    return Column(
      children: [
        MonthlyProgressSyncfusionCard(
          data: viewModel.monthlyProgressData,
          selectedPeriod: viewModel.selectedPeriod,
          onPeriodChanged: viewModel.changePeriod,
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        TodaysReportCard(
          report: viewModel.todaysReport,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(DashboardStatsViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: MonthlyProgressSyncfusionCard(
            data: viewModel.monthlyProgressData,
            selectedPeriod: viewModel.selectedPeriod,
            onPeriodChanged: viewModel.changePeriod,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingLarge),
        Expanded(
          flex: 1,
          child: TodaysReportCard(
            report: viewModel.todaysReport,
          ),
        ),
      ],
    );
  }
}
