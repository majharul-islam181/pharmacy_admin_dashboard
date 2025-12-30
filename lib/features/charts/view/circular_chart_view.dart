import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class CircularChartView extends StatelessWidget {
  const CircularChartView({super.key});

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
                  title: 'Circular Charts',
                  description:
                      'Pie, Doughnut, Radial Bar, Funnel, and Pyramid charts',
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
            ? 3
            : constraints.maxWidth > 800
                ? 2
                : 1;

        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 1.0,
          children: [
            _buildPieChart(viewModel),
            _buildDoughnutChart(viewModel),
            _buildRadialBarChart(viewModel),
            _buildPieSemiCircleChart(viewModel),
            _buildFunnelChart(viewModel),
            _buildPyramidChart(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildPieChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Pie Chart',
      subtitle: 'Classic pie with explosion',
      onRefresh: viewModel.refreshData,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y%',
        ),
        series: <CircularSeries>[
          PieSeries<dynamic, String>(
            dataSource: viewModel.pieChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              connectorLineSettings: ConnectorLineSettings(
                type: ConnectorType.curve,
                length: '10%',
              ),
            ),
            explode: true,
            explodeIndex: 0,
            explodeOffset: '10%',
            explodeGesture: ActivationMode.singleTap,
            animationDuration: 1200,
            animationDelay: 0,
          ),
        ],
      ),
    );
  }

  Widget _buildDoughnutChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Doughnut Chart',
      subtitle: 'Ring chart with center text',
      onRefresh: viewModel.refreshData,
      child: SfCircularChart(
        centerX: '50%',
        centerY: '50%',
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '100%',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ],
            ),
          ),
        ],
        series: <CircularSeries>[
          DoughnutSeries<dynamic, String>(
            dataSource: viewModel.pieChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
            innerRadius: '60%',
            radius: '90%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget _buildRadialBarChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Radial Bar Chart',
      subtitle: 'Circular progress bars',
      onRefresh: viewModel.refreshData,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          RadialBarSeries<dynamic, String>(
            dataSource: viewModel.pieChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
            maximumValue: 100,
            radius: '100%',
            gap: '3%',
            innerRadius: '40%',
            cornerStyle: CornerStyle.bothCurve,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              textStyle: TextStyle(fontSize: 10),
            ),
            animationDuration: 1500,
          ),
        ],
      ),
    );
  }

  Widget _buildPieSemiCircleChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Semi-Circular Pie',
      subtitle: 'Half pie chart',
      onRefresh: viewModel.refreshData,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CircularSeries>[
          PieSeries<dynamic, String>(
            dataSource: viewModel.pieChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            pointColorMapper: (data, _) => data.color,
            startAngle: 270,
            endAngle: 90,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Funnel Chart',
      subtitle: 'Sales funnel visualization',
      onRefresh: viewModel.refreshData,
      child: SfFunnelChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
        ),
        series: FunnelSeries<dynamic, String>(
          dataSource: viewModel.pieChartData,
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.y,
          pointColorMapper: (data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          neckWidth: '20%',
          neckHeight: '15%',
          explode: true,
          explodeIndex: 0,
          explodeOffset: '5%',
          gapRatio: 0.05,
          animationDuration: 1200,
        ),
      ),
    );
  }

  Widget _buildPyramidChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Pyramid Chart',
      subtitle: 'Hierarchical data',
      onRefresh: viewModel.refreshData,
      child: SfPyramidChart(
        legend: const Legend(
          isVisible: true,
          position: LegendPosition.bottom,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x : point.y',
        ),
        series: PyramidSeries<dynamic, String>(
          dataSource: viewModel.pieChartData,
          xValueMapper: (data, _) => data.x,
          yValueMapper: (data, _) => data.y,
          pointColorMapper: (data, _) => data.color,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
          pyramidMode: PyramidMode.linear,
          gapRatio: 0.05,
          explode: true,
          explodeIndex: 0,
          explodeOffset: '5%',
          animationDuration: 1200,
        ),
      ),
    );
  }
}
