import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/reports_view_model.dart';
import '../../../core/constants/app_dimensions.dart';
import 'widgets/report_summary_cards.dart';
import 'widgets/sales_overview_card.dart';
import 'widgets/top_products_card.dart';
import 'widgets/recent_activity_card.dart';
import 'widgets/period_filter_buttons.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsViewModel(),
      child: const _ReportsViewContent(),
    );
  }
}

class _ReportsViewContent extends StatelessWidget {
  const _ReportsViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ReportsViewModel>();
    final textTheme = Theme.of(context).textTheme;

    return RefreshIndicator(
      onRefresh: viewModel.refreshData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header + period filters (responsive)
            LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final isCompact = maxWidth < 720;

                final filters = PeriodFilterButtons(
                  selectedPeriod: viewModel.selectedPeriod,
                  onPeriodChanged: viewModel.setPeriodFilter,
                );

                if (isCompact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reports & Analytics',
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monitor sales performance, inventory movement and financial metrics.',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      filters,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reports & Analytics',
                            style: textTheme.titleLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monitor sales performance, inventory movement and financial metrics.',
                            style: textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingMedium),
                    filters,
                  ],
                );
              },
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Summary cards
            if (viewModel.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.paddingLarge),
                  child: CircularProgressIndicator(),
                ),
              )
            else ...[
              ReportSummaryCards(summaries: viewModel.summaries),
              const SizedBox(height: AppDimensions.paddingLarge),

              // Sales overview + Top products
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final isStacked = maxWidth < 1100;

                  if (isStacked) {
                    return Column(
                      children: [
                        SalesOverviewCard(
                          selectedChartType: viewModel.selectedChartType,
                          onChartTypeChanged: viewModel.setChartType,
                          chartData: viewModel.chartData,
                        ),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        TopProductsCard(topProducts: viewModel.topProducts),
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SalesOverviewCard(
                          selectedChartType: viewModel.selectedChartType,
                          onChartTypeChanged: viewModel.setChartType,
                          chartData: viewModel.chartData,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingLarge),
                      SizedBox(
                        width: maxWidth * 0.36,
                        child:
                            TopProductsCard(topProducts: viewModel.topProducts),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: AppDimensions.paddingLarge),

              // Recent activity / export actions
              RecentActivityCard(
                activities: viewModel.recentActivities,
                onExportPdf: viewModel.exportPdf,
                onExportCsv: viewModel.exportCsv,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
