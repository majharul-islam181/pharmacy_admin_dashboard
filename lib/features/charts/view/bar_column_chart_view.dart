import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class BarColumnChartView extends StatelessWidget {
  const BarColumnChartView({super.key});

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
                const ChartHeader(
                  title: 'Bar & Column Charts',
                  description: 'Comprehensive bar and column chart variations',
                ),
                const SizedBox(height: 24),
                _buildChartsGrid(context, viewModel),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChartsGrid(BuildContext context, ChartViewModel viewModel) {
    return LayoutBuilder(
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
          childAspectRatio: 1.4,
          children: [
            _buildColumnChart(viewModel),
            _buildBarChart(viewModel),
            _buildStackedColumnChart(viewModel),
            _buildStackedColumn100Chart(viewModel),
            _buildStackedBarChart(viewModel),
            _buildStackedBar100Chart(viewModel),
            _buildRangeColumnChart(viewModel),
            _buildHistogramChart(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildColumnChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Column Chart',
      subtitle: 'Vertical bars with gradient',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
        ),
        series: <CartesianSeries>[
          ColumnSeries<dynamic, String>(
            dataSource: viewModel.columnChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.lightBlue],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            width: 0.8,
            spacing: 0.1,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Bar Chart',
      subtitle: 'Horizontal bars',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          BarSeries<dynamic, String>(
            dataSource: viewModel.columnChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: const LinearGradient(
              colors: [Colors.green, Colors.lightGreen],
            ),
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(8)),
            width: 0.8,
            spacing: 0.1,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildStackedColumnChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Stacked Column',
      subtitle: 'Multi-series stacked columns',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedColumnSeries<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            color: series.color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStackedColumn100Chart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: '100% Stacked Column',
      subtitle: 'Percentage-based stacking',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(labelFormat: '{value}%'),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedColumn100Series<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            gradient: LinearGradient(
              colors: [
                series.color,
                series.color.withOpacity(0.7),
              ],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStackedBarChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Stacked Bar',
      subtitle: 'Horizontal stacked bars',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedBarSeries<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            color: series.color,
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(4)),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStackedBar100Chart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: '100% Stacked Bar',
      subtitle: 'Percentage horizontal stacking',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(labelFormat: '{value}%'),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedBar100Series<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            gradient: LinearGradient(
              colors: [
                series.color,
                series.color.withOpacity(0.7),
              ],
            ),
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(4)),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRangeColumnChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Range Column Chart',
      subtitle: 'High-low range columns',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          RangeColumnSeries<dynamic, String>(
            dataSource: viewModel.rangeChartData,
            xValueMapper: (data, _) => data.x,
            highValueMapper: (data, _) => data.high,
            lowValueMapper: (data, _) => data.low,
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            width: 0.8,
            spacing: 0.1,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildHistogramChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Histogram Chart',
      subtitle: 'Distribution analysis',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          HistogramSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            yValueMapper: (data, _) => data.y,
            binInterval: 10,
            showNormalDistributionCurve: true,
            curveColor: Colors.red,
            borderWidth: 2,
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
            ),
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }
}
