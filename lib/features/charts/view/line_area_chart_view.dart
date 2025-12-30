import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class LineAreaChartView extends StatelessWidget {
  const LineAreaChartView({super.key});

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
                  title: 'Line & Area Charts',
                  description:
                      'Advanced line, spline, step, and area chart variations',
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
            _buildLineChart(viewModel),
            _buildSplineChart(viewModel),
            _buildStepLineChart(viewModel),
            _buildFastLineChart(viewModel),
            _buildAreaChart(viewModel),
            _buildSplineAreaChart(viewModel),
            _buildStepAreaChart(viewModel),
            _buildStackedAreaChart(viewModel),
            _buildStackedArea100Chart(viewModel),
            _buildRangeAreaChart(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildLineChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Line Chart',
      subtitle: 'Basic line series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
        ),
        series: <CartesianSeries>[
          LineSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            color: Colors.blue,
            width: 2,
            animationDuration: 800,
          ),
        ],
      ),
    );
  }

  Widget _buildSplineChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Spline Chart',
      subtitle: 'Smooth curved line',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        crosshairBehavior: CrosshairBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
        ),
        series: <CartesianSeries>[
          SplineSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            color: Colors.purple,
            width: 3,
            markerSettings: const MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.diamond,
            ),
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildStepLineChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Step Line Chart',
      subtitle: 'Stepped line series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          StepLineSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            color: Colors.orange,
            width: 2,
            animationDuration: 800,
          ),
        ],
      ),
    );
  }

  Widget _buildFastLineChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Fast Line Chart',
      subtitle: 'Optimized for large datasets',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          FastLineSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            color: Colors.teal,
            width: 2,
            animationDuration: 600,
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Area Chart',
      subtitle: 'Filled area series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          AreaSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.green, Colors.lightGreen, Colors.white],
            ),
            borderColor: Colors.green,
            borderWidth: 2,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildSplineAreaChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Spline Area Chart',
      subtitle: 'Smooth curved area',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          SplineAreaSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(0.7),
                Colors.blue.withOpacity(0.3),
                Colors.blue.withOpacity(0.05),
              ],
            ),
            borderColor: Colors.blue,
            borderWidth: 2,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget _buildStepAreaChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Step Area Chart',
      subtitle: 'Stepped area series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          StepAreaSeries<dynamic, num>(
            dataSource: viewModel.lineChartData,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            gradient: LinearGradient(
              colors: [
                Colors.orange.withOpacity(0.6),
                Colors.orange.withOpacity(0.1),
              ],
            ),
            borderColor: Colors.orange,
            borderWidth: 2,
            animationDuration: 800,
          ),
        ],
      ),
    );
  }

  Widget _buildStackedAreaChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Stacked Area Chart',
      subtitle: 'Multiple stacked series',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedAreaSeries<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            gradient: LinearGradient(
              colors: [
                series.color.withOpacity(0.7),
                series.color.withOpacity(0.3),
              ],
            ),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStackedArea100Chart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: '100% Stacked Area',
      subtitle: 'Percentage-based stacking',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(labelFormat: '{value}%'),
        tooltipBehavior: TooltipBehavior(enable: true),
        legend: const Legend(isVisible: true, position: LegendPosition.bottom),
        series: viewModel.multiSeriesData.take(3).map((series) {
          return StackedArea100Series<dynamic, num>(
            dataSource: series.data,
            xValueMapper: (data, _) => data.x,
            yValueMapper: (data, _) => data.y,
            name: series.name,
            gradient: LinearGradient(
              colors: [
                series.color.withOpacity(0.7),
                series.color.withOpacity(0.3),
              ],
            ),
            animationDuration: 1000,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRangeAreaChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Range Area Chart',
      subtitle: 'High-low range visualization',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries>[
          RangeAreaSeries<dynamic, String>(
            dataSource: viewModel.rangeChartData,
            xValueMapper: (data, _) => data.x,
            highValueMapper: (data, _) => data.high,
            lowValueMapper: (data, _) => data.low,
            gradient: LinearGradient(
              colors: [
                Colors.purple.withOpacity(0.5),
                Colors.purple.withOpacity(0.2),
              ],
            ),
            borderColor: Colors.purple,
            borderWidth: 2,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }
}
