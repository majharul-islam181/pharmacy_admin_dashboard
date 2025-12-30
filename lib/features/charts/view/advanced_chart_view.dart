import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class AdvancedChartView extends StatelessWidget {
  const AdvancedChartView({super.key});

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
                  title: 'Advanced Charts',
                  description:
                      'Scatter, Bubble, Waterfall, and specialized chart types',
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
            _buildScatterChart(viewModel),
            _buildBubbleChart(viewModel),
            _buildWaterfallChart(viewModel),
            _buildBoxAndWhiskerChart(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildScatterChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Scatter Chart',
      subtitle: 'Correlation analysis',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(
          title: AxisTitle(text: 'X-Axis'),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'Y-Axis'),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'X: point.x\nY: point.y',
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
        ),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return ScatterSeries<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            color: series.color,
            markerSettings: MarkerSettings(
              isVisible: true,
              height: 10,
              width: 10,
              shape: DataMarkerType.circle,
              borderColor: series.color,
              borderWidth: 2,
            ),
            animationDuration: 1000,
          );
        }).toList(),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      ),
    );
  }

  Widget _buildBubbleChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Bubble Chart',
      subtitle: 'Multi-dimensional data',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(
          title: AxisTitle(text: 'X-Value'),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'Y-Value'),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'X: point.x\nY: point.y\nSize: point.sizeValue',
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
        ),
        series: <CartesianSeries>[
          BubbleSeries<dynamic, num>(
            dataSource: viewModel.bubbleChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            sizeValueMapper: (data, _) => data.size,
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            opacity: 0.7,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget _buildWaterfallChart(ChartViewModel viewModel) {
    // Convert data for waterfall chart
    final waterfallData = [
      {'x': 'Sales', 'y': 100.0},
      {'x': 'Marketing', 'y': -20.0},
      {'x': 'Operations', 'y': -30.0},
      {'x': 'R&D', 'y': -15.0},
      {'x': 'Net Profit', 'isSummary': true},
    ];

    return AnimatedChartContainer(
      title: 'Waterfall Chart',
      subtitle: 'Cumulative effect analysis',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'Value (\$)'),
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          WaterfallSeries<Map<String, dynamic>, String>(
            dataSource: waterfallData,
            xValueMapper: (data, _) => data['x'] as String,
            yValueMapper: (data, _) => data['y'] as double?,
            intermediateSumPredicate: (data, _) => data['isSummary'] == true,
            totalSumPredicate: (data, _) => data['isSummary'] == true,
            connectorLineSettings: const WaterfallConnectorLineSettings(
              width: 2,
              color: Colors.black26,
            ),
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
            ),
            animationDuration: 1500,
          ),
        ],
      ),
    );
  }

  Widget _buildBoxAndWhiskerChart(ChartViewModel viewModel) {
    // Generate box plot data
    final boxPlotData = List.generate(6, (index) {
      return {
        'x': 'Q${index + 1}',
        'y': [
          20 + index * 5.0,
          30 + index * 5.0,
          40 + index * 5.0,
          50 + index * 5.0,
          60 + index * 5.0,
        ],
      };
    });

    return AnimatedChartContainer(
      title: 'Box & Whisker Chart',
      subtitle: 'Statistical distribution',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          title: AxisTitle(text: 'Value'),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format:
              'point.x\nMin: point.minimum\nQ1: point.lowerQuartile\nMedian: point.median\nQ3: point.upperQuartile\nMax: point.maximum',
        ),
        series: <CartesianSeries>[
          BoxAndWhiskerSeries<Map<String, dynamic>, String>(
            dataSource: boxPlotData,
            xValueMapper: (data, _) => data['x'] as String,
            yValueMapper: (data, _) => data['y'] as List<double>,
            boxPlotMode: BoxPlotMode.normal,
            pointColorMapper: (data, index) {
              final colors = [
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple,
                Colors.pink,
                Colors.teal,
              ];
              return colors[index];
            },
            spacing: 0.2,
            width: 0.8,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }
}
