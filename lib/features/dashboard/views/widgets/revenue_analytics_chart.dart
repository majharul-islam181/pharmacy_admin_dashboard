import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/chart_data_models.dart';

class RevenueAnalyticsChart extends StatefulWidget {
  final List<RevenueData> currentData;
  final List<RevenueData> previousData;

  const RevenueAnalyticsChart({
    super.key,
    required this.currentData,
    required this.previousData,
  });

  @override
  State<RevenueAnalyticsChart> createState() => _RevenueAnalyticsChartState();
}

class _RevenueAnalyticsChartState extends State<RevenueAnalyticsChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showPrevious = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  AppColors.primary,
                                  AppColors.primary.withOpacity(0.5),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Revenue Analytics',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Compare current vs previous period',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                // Toggle button
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton(
                        'Current',
                        true,
                        theme,
                      ),
                      _buildToggleButton(
                        'Compare',
                        _showPrevious,
                        theme,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Chart
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RepaintBoundary(
                child: FadeTransition(
                  opacity: _animation,
                  child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: const CategoryAxis(
                    majorGridLines: MajorGridLines(width: 0),
                    axisLine: AxisLine(width: 0),
                    labelStyle: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    labelFormat: '\${value}K',
                    majorGridLines: MajorGridLines(
                      width: 1,
                      color: Colors.grey.withOpacity(0.1),
                      dashArray: const [5, 5],
                    ),
                  ),
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    elevation: 3,
                    canShowMarker: true,
                    format: 'point.x: \$point.yK',
                  ),
                  trackballBehavior: TrackballBehavior(
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    lineType: TrackballLineType.vertical,
                    tooltipSettings: const InteractiveTooltip(
                      enable: true,
                      color: Colors.black87,
                    ),
                  ),
                  series: <CartesianSeries>[
                    // Current period - Area with gradient
                    SplineAreaSeries<RevenueData, String>(
                      dataSource: widget.currentData,
                      xValueMapper: (data, _) => data.month,
                      yValueMapper: (data, _) => data.revenue,
                      name: 'Current Period',
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.primary.withOpacity(0.4),
                          AppColors.primary.withOpacity(0.1),
                          AppColors.primary.withOpacity(0.0),
                        ],
                      ),
                      borderColor: AppColors.primary,
                      borderWidth: 3,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        height: 8,
                        width: 8,
                        color: AppColors.primary,
                        borderColor: Colors.white,
                        borderWidth: 2,
                      ),
                      animationDuration: 1200,
                    ),
                    // Previous period - Line for comparison
                    if (_showPrevious)
                      SplineSeries<RevenueData, String>(
                        dataSource: widget.previousData,
                        xValueMapper: (data, _) => data.month,
                        yValueMapper: (data, _) => data.revenue,
                        name: 'Previous Period',
                        color: Colors.grey,
                        width: 2,
                        opacity: 0.5,
                        dashArray: const [5, 5],
                        markerSettings: MarkerSettings(
                          isVisible: true,
                          height: 6,
                          width: 6,
                          color: Colors.grey.shade400,
                        ),
                        animationDuration: 1200,
                      ),
                  ],
                  legend: const Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    overflowMode: LegendItemOverflowMode.wrap,
                    iconHeight: 12,
                    iconWidth: 12,
                    textStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isActive, ThemeData theme) {
    return InkWell(
      onTap: () {
        setState(() {
          if (label == 'Compare') {
            _showPrevious = !_showPrevious;
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: label == 'Current'
              ? AppColors.primary
              : isActive
                  ? AppColors.primary.withOpacity(0.2)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: label == 'Current'
                ? Colors.white
                : isActive
                    ? AppColors.primary
                    : theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
