import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_models/dashboard_stats_view_model.dart';
import 'expiring_list_card.dart';
import 'recent_orders_card.dart';

class DashboardTablesSection extends StatelessWidget {
  const DashboardTablesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardStatsViewModel>(
      builder: (context, viewModel, child) {
        if (ResponsiveUtils.isMobile(context)) {
          return _buildMobileLayout(viewModel);
        } else {
          return _buildDesktopTabletLayout(viewModel);
        }
      },
    );
  }

  Widget _buildMobileLayout(DashboardStatsViewModel viewModel) {
    return Column(
      children: [
        ExpiringListCard(
          medicines: viewModel.expiringMedicines,
          onSeeAll: viewModel.onSeeAllExpiring,
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        RecentOrdersCard(
          orders: viewModel.recentOrders,
          onSeeAll: viewModel.onSeeAllOrders,
        ),
      ],
    );
  }

  Widget _buildDesktopTabletLayout(DashboardStatsViewModel viewModel) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ExpiringListCard(
            medicines: viewModel.expiringMedicines,
            onSeeAll: viewModel.onSeeAllExpiring,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingLarge),
        Expanded(
          child: RecentOrdersCard(
            orders: viewModel.recentOrders,
            onSeeAll: viewModel.onSeeAllOrders,
          ),
        ),
      ],
    );
  }
}