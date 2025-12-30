import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/chart_data_models.dart';

class RealTimeOrderChart extends StatefulWidget {
  const RealTimeOrderChart({super.key});

  @override
  State<RealTimeOrderChart> createState() => _RealTimeOrderChartState();
}

class _RealTimeOrderChartState extends State<RealTimeOrderChart> {
  late List<OrderData> _chartData;
  late Timer _timer;
  final Random _random = Random();
  int _time = 0;
  bool _isLive = true;

  @override
  void initState() {
    super.initState();
    _chartData = _getInitialData();
    _startTimer();
  }

  List<OrderData> _getInitialData() {
    return List.generate(20, (index) {
      return OrderData(index, 20 + _random.nextInt(30));
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_isLive) {
        setState(() {
          _time++;
          _chartData.add(OrderData(
            _time + 20,
            20 + _random.nextInt(30),
          ));
          if (_chartData.length > 20) {
            _chartData.removeAt(0);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Live indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _isLive
                        ? Colors.red.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _isLive ? Colors.red : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: _isLive
                          ? [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.6),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Real-time Orders',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (_isLive)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'LIVE',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Orders per minute - Last 20 points',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                // Control buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isLive = !_isLive;
                        });
                      },
                      icon: Icon(
                        _isLive
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: _isLive ? Colors.red : AppColors.primary,
                      ),
                      tooltip: _isLive ? 'Pause' : 'Resume',
                      style: IconButton.styleFrom(
                        backgroundColor: _isLive
                            ? Colors.red.withOpacity(0.1)
                            : AppColors.primary.withOpacity(0.1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _chartData = _getInitialData();
                          _time = 0;
                        });
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      tooltip: 'Reset',
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Chart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SfCartesianChart(
                plotAreaBorderWidth: 0,
                primaryXAxis: const NumericAxis(
                  isVisible: false,
                  majorGridLines: MajorGridLines(width: 0),
                ),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 60,
                  interval: 10,
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: MajorGridLines(
                    width: 1,
                    color: Colors.grey.withOpacity(0.1),
                    dashArray: const [5, 5],
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 11,
                  ),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  format: 'Orders: point.y',
                ),
                series: <CartesianSeries>[
                  // Area with gradient
                  SplineAreaSeries<OrderData, int>(
                    dataSource: _chartData,
                    xValueMapper: (data, _) => data.time,
                    yValueMapper: (data, _) => data.orders,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.05),
                        Colors.blue.withOpacity(0.0),
                      ],
                    ),
                    borderColor: Colors.blue,
                    borderWidth: 2,
                    animationDuration: 500,
                  ),
                  // Line on top
                  SplineSeries<OrderData, int>(
                    dataSource: _chartData,
                    xValueMapper: (data, _) => data.time,
                    yValueMapper: (data, _) => data.orders,
                    color: AppColors.primary,
                    width: 3,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 6,
                      width: 6,
                      color: AppColors.primary,
                      borderColor: Colors.white,
                      borderWidth: 2,
                    ),
                    animationDuration: 500,
                  ),
                ],
              ),
            ),
          ),
          // Stats
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(AppDimensions.radiusLarge),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Current',
                    '${_chartData.isNotEmpty ? _chartData.last.orders : 0}',
                    Icons.shopping_cart_rounded,
                    AppColors.primary,
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    'Average',
                    _chartData.isNotEmpty
                        ? (_chartData
                                    .map((e) => e.orders)
                                    .reduce((a, b) => a + b) /
                                _chartData.length)
                            .toStringAsFixed(0)
                        : '0',
                    Icons.analytics_rounded,
                    Colors.orange,
                    theme,
                  ),
                ),
                Expanded(
                  child: _buildStatCard(
                    'Peak',
                    _chartData.isNotEmpty
                        ? _chartData.map((e) => e.orders).reduce(max).toString()
                        : '0',
                    Icons.trending_up_rounded,
                    AppColors.success,
                    theme,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
