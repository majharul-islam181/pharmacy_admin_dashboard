import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_models/dashboard_stats_view_model.dart';
import 'revenue_analytics_chart.dart';
import 'sales_performance_gauge.dart';
import 'top_products_chart.dart';
import 'realtime_order_chart.dart';

class PremiumChartsSection extends StatelessWidget {
  const PremiumChartsSection({super.key});

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
        // Revenue Analytics
        SizedBox(
          height: 400,
          child: RevenueAnalyticsChart(
            currentData: viewModel.revenueCurrentData,
            previousData: viewModel.revenuePreviousData,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        // Sales Performance Gauge
        SizedBox(
          height: 350,
          child: SalesPerformanceGauge(
            currentValue: viewModel.currentSales,
            targetValue: viewModel.targetSales,
            period: viewModel.selectedPeriod,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        // Top Products
        SizedBox(
          height: 400,
          child: TopProductsChart(
            products: viewModel.topProductsData,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        // Real-time Orders
        const SizedBox(
          height: 400,
          child: RealTimeOrderChart(),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(DashboardStatsViewModel viewModel) {
    return Column(
      children: [
        // Top row: Revenue + Gauge
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 400,
                child: RevenueAnalyticsChart(
                  currentData: viewModel.revenueCurrentData,
                  previousData: viewModel.revenuePreviousData,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingLarge),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 400,
                child: SalesPerformanceGauge(
                  currentValue: viewModel.currentSales,
                  targetValue: viewModel.targetSales,
                  period: viewModel.selectedPeriod,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        // Bottom row: Top Products + Real-time
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 400,
                child: TopProductsChart(
                  products: viewModel.topProductsData,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingLarge),
            const Expanded(
              child: SizedBox(
                height: 400,
                child: RealTimeOrderChart(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(DashboardStatsViewModel viewModel) {
    return Column(
      children: [
        // Top row: Revenue (spans 2) + Gauge (spans 1)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 400,
                child: RevenueAnalyticsChart(
                  currentData: viewModel.revenueCurrentData,
                  previousData: viewModel.revenuePreviousData,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingLarge),
            Expanded(
              flex: 1,
              child: SizedBox(
                height: 400,
                child: SalesPerformanceGauge(
                  currentValue: viewModel.currentSales,
                  targetValue: viewModel.targetSales,
                  period: viewModel.selectedPeriod,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingLarge),
        // Bottom row: Top Products + Real-time Orders
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 400,
                child: TopProductsChart(
                  products: viewModel.topProductsData,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingLarge),
            const Expanded(
              child: SizedBox(
                height: 400,
                child: RealTimeOrderChart(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
