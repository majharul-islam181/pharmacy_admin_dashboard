import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../view_model/chart_view_model.dart';
import '../widgets/chart_header.dart';
import '../widgets/animated_chart_container.dart';

class FinancialChartView extends StatelessWidget {
  const FinancialChartView({super.key});

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
                  title: 'Financial Charts',
                  description:
                      'OHLC, Candle, HiLo charts for stock market analysis',
                  actions: [
                    FilledButton.icon(
                      onPressed: viewModel.startLiveData,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: const Text('Live Trading'),
                    ),
                  ],
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
          childAspectRatio: 1.3,
          children: [
            _buildCandleChart(viewModel),
            _buildHiLoChart(viewModel),
            _buildHiLoOpenCloseChart(viewModel),
            _buildCandleChartWithVolume(viewModel),
          ],
        );
      },
    );
  }

  Widget _buildCandleChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Candlestick Chart',
      subtitle: 'OHLC with volume',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '\${value}',
          opposedPosition: true,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format:
              'Date: point.x\nHigh: point.high\nLow: point.low\nOpen: point.open\nClose: point.close',
        ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          lineType: TrackballLineType.vertical,
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          zoomMode: ZoomMode.x,
        ),
        series: <CartesianSeries>[
          CandleSeries<dynamic, DateTime>(
            dataSource: viewModel.financialData,
            xValueMapper: (data, _) => data.date,
            highValueMapper: (data, _) => data.high,
            lowValueMapper: (data, _) => data.low,
            openValueMapper: (data, _) => data.open,
            closeValueMapper: (data, _) => data.close,
            bullColor: Colors.green,
            bearColor: Colors.red,
            enableSolidCandles: true,
            animationDuration: 1200,
          ),
        ],
      ),
    );
  }

  Widget _buildHiLoChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'HiLo Chart',
      subtitle: 'High-Low price range',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '\${value}',
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format: 'point.x\nHigh: point.high\nLow: point.low',
        ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
        ),
        series: <CartesianSeries>[
          HiloSeries<dynamic, DateTime>(
            dataSource: viewModel.financialData,
            xValueMapper: (data, _) => data.date,
            highValueMapper: (data, _) => data.high,
            lowValueMapper: (data, _) => data.low,
            color: Colors.blue,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildHiLoOpenCloseChart(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'HiLo Open Close',
      subtitle: 'OHLC bar chart',
      onRefresh: viewModel.refreshData,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '\${value}',
          opposedPosition: true,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          format:
              'point.x\nHigh: point.high\nLow: point.low\nOpen: point.open\nClose: point.close',
        ),
        crosshairBehavior: CrosshairBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
        ),
        series: <CartesianSeries>[
          HiloOpenCloseSeries<dynamic, DateTime>(
            dataSource: viewModel.financialData,
            xValueMapper: (data, _) => data.date,
            highValueMapper: (data, _) => data.high,
            lowValueMapper: (data, _) => data.low,
            openValueMapper: (data, _) => data.open,
            closeValueMapper: (data, _) => data.close,
            bullColor: Colors.green,
            bearColor: Colors.red,
            animationDuration: 1000,
          ),
        ],
      ),
    );
  }

  Widget _buildCandleChartWithVolume(ChartViewModel viewModel) {
    return AnimatedChartContainer(
      title: 'Candlestick + Volume',
      subtitle: 'Multi-pane financial chart',
      onRefresh: viewModel.refreshData,
      child: Column(
        children: [
          // Price Chart
          Expanded(
            flex: 3,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.MMMd(),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '\${value}',
                opposedPosition: true,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              trackballBehavior: TrackballBehavior(
                enable: true,
                activationMode: ActivationMode.singleTap,
              ),
              series: <CartesianSeries>[
                CandleSeries<dynamic, DateTime>(
                  dataSource: viewModel.financialData,
                  xValueMapper: (data, _) => data.date,
                  highValueMapper: (data, _) => data.high,
                  lowValueMapper: (data, _) => data.low,
                  openValueMapper: (data, _) => data.open,
                  closeValueMapper: (data, _) => data.close,
                  bullColor: Colors.green,
                  bearColor: Colors.red,
                  enableSolidCandles: true,
                  animationDuration: 1000,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Volume Chart
          Expanded(
            flex: 1,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.MMMd(),
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '{value}',
              ),
              series: <CartesianSeries>[
                ColumnSeries<dynamic, DateTime>(
                  dataSource: viewModel.financialData,
                  xValueMapper: (data, _) => data.date,
                  yValueMapper: (data, _) => data.volume,
                  pointColorMapper: (data, _) => data.close >= data.open
                      ? Colors.green.withOpacity(0.5)
                      : Colors.red.withOpacity(0.5),
                  animationDuration: 800,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
