import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class SalesPerformanceGauge extends StatefulWidget {
  final double currentValue;
  final double targetValue;
  final String period;

  const SalesPerformanceGauge({
    super.key,
    required this.currentValue,
    required this.targetValue,
    this.period = 'This Month',
  });

  @override
  State<SalesPerformanceGauge> createState() => _SalesPerformanceGaugeState();
}

class _SalesPerformanceGaugeState extends State<SalesPerformanceGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
    final percentage =
        (widget.currentValue / widget.targetValue * 100).clamp(0, 100);
    final isOverTarget = percentage >= 100;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.success.withOpacity(0.2),
                            AppColors.success.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.success,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sales Performance',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.period,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Gauge
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: RepaintBoundary(
                child: FadeTransition(
                  opacity: _animation,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        showLabels: false,
                        showTicks: false,
                        startAngle: 180,
                        endAngle: 360,
                        radiusFactor: 0.9,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.15,
                          cornerStyle: CornerStyle.bothCurve,
                          color: Colors.grey.withOpacity(0.1),
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: percentage.toDouble(),
                            width: 0.15,
                            sizeUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve,
                            gradient: SweepGradient(
                              colors: isOverTarget
                                  ? [
                                      AppColors.success,
                                      AppColors.success.withOpacity(0.7),
                                    ]
                                  : percentage > 70
                                      ? [
                                          AppColors.primary,
                                          Colors.blue,
                                        ]
                                      : [
                                          Colors.orange,
                                          Colors.orangeAccent,
                                        ],
                            ),
                            enableAnimation: true,
                            animationDuration: 1500,
                            animationType: AnimationType.easeOutBack,
                          ),
                          MarkerPointer(
                            value: percentage.toDouble(),
                            markerHeight: 20,
                            markerWidth: 20,
                            markerType: MarkerType.circle,
                            color: Colors.white,
                            borderWidth: 4,
                            borderColor: isOverTarget
                                ? AppColors.success
                                : percentage > 70
                                    ? AppColors.primary
                                    : Colors.orange,
                            enableAnimation: true,
                            animationDuration: 1500,
                            animationType: AnimationType.easeOutBack,
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '${percentage.toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = LinearGradient(
                                        colors: isOverTarget
                                            ? [
                                                AppColors.success,
                                                AppColors.success
                                                    .withOpacity(0.7),
                                              ]
                                            : percentage > 70
                                                ? [
                                                    AppColors.primary,
                                                    Colors.blue,
                                                  ]
                                                : [
                                                    Colors.orange,
                                                    Colors.orangeAccent,
                                                  ],
                                      ).createShader(
                                        const Rect.fromLTWH(0, 0, 200, 70),
                                      ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Achievement',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            angle: 270,
                            positionFactor: 0.1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Stats
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Current',
                    '\$${(widget.currentValue / 1000).toStringAsFixed(1)}K',
                    AppColors.primary,
                    theme,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Target',
                    '\$${(widget.targetValue / 1000).toStringAsFixed(1)}K',
                    Colors.grey,
                    theme,
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Remaining',
                    '\$${((widget.targetValue - widget.currentValue) / 1000).abs().toStringAsFixed(1)}K',
                    isOverTarget ? AppColors.success : Colors.orange,
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

  Widget _buildStatItem(
      String label, String value, Color color, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
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
    );
  }
}
