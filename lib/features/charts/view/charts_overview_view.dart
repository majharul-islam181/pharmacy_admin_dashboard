import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class ChartsOverviewView extends StatelessWidget {
  const ChartsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartViewModel>(
      builder: (context, viewModel, child) {
        return RefreshIndicator(
          onRefresh: viewModel.refreshData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChartHeader(
                  title: 'Chart Analytics Overview',
                  description:
                      '30+ Advanced Chart Types with Real-time Updates',
                  actions: [
                    FilledButton.icon(
                      onPressed: viewModel.startLiveData,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Start Live'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: viewModel.stopLiveData,
                      icon: const Icon(Icons.stop_rounded),
                      label: const Text('Stop'),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Stats Cards
                _buildStatsCards(context),
                const SizedBox(height: 24),

                // Main Charts Grid
                LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 1200
                        ? 2
                        : constraints.maxWidth > 800
                            ? 2
                            : 1;

                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 1.5,
                      children: [
                        _buildLineChart(context, viewModel),
                        _buildColumnChart(context, viewModel),
                        _buildPieChart(context, viewModel),
                        _buildAreaChart(context, viewModel),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsCards(BuildContext context) {
    final theme = Theme.of(context);

    final stats = [
      {
        'title': 'Total Charts',
        'value': '30+',
        'icon': Icons.bar_chart_rounded,
        'color': Colors.blue
      },
      {
        'title': 'Categories',
        'value': '6',
        'icon': Icons.category_rounded,
        'color': Colors.green
      },
      {
        'title': 'Live Updates',
        'value': 'Real-time',
        'icon': Icons.update_rounded,
        'color': Colors.orange
      },
      {
        'title': 'Interactions',
        'value': 'Advanced',
        'icon': Icons.touch_app_rounded,
        'color': Colors.purple
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 1200
            ? 4
            : constraints.maxWidth > 800
                ? 2
                : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: stats.length,
          itemBuilder: (context, index) {
            final stat = stats[index];
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    (stat['color'] as Color).withOpacity(0.1),
                    (stat['color'] as Color).withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (stat['color'] as Color).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: stat['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          stat['title'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          stat['value'] as String,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: stat['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLineChart(BuildContext context, ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Line Chart',
      subtitle: 'Smooth animated line series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '{value}',
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          enableDoubleTapZooming: true,
        ),
        series: <CartesianSeries>[
          LineSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            color: Colors.blue,
            width: 3,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              width: 8,
              height: 8,
            ),
            animationDuration: 1000,
            animationDelay: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildColumnChart(BuildContext context, ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Column Chart',
      subtitle: 'Monthly sales data',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(
          labelFormat: '{value}',
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          ColumnSeries<dynamic, String>(
            dataSource: viewModel.columnChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            animationDuration: 1000,
            animationDelay: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildPieChart(BuildContext context, ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Pie Chart',
      subtitle: 'Product distribution',
      onRefresh: viewModel.refreshData,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<dynamic, String>(
            dataSource: viewModel.pieChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            animationDuration: 1200,
            animationDelay: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChart(BuildContext context, ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Area Chart',
      subtitle: 'Multi-series comparison',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true),
        series: viewModel.multiSeriesData.take(2).map((series) {
          return AreaSeries<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            opacity: 0.7,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                series.color,
                series.color.withOpacity(0.1),
              ],
            ),
            animationDuration: 1000,
            animationDelay: 0,
          );
        }).toList(),
      ),
    );
  }
}
