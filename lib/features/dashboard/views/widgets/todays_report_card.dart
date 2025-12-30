import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/todays_report_model.dart';

class TodaysReportCard extends StatefulWidget {
  final TodaysReportModel report;

  const TodaysReportCard({
    super.key,
    required this.report,
  });

  @override
  State<TodaysReportCard> createState() => _TodaysReportCardState();
}

class _TodaysReportCardState extends State<TodaysReportCard>
    with TickerProviderStateMixin {
  late AnimationController _cardAnimationController;
  late AnimationController _chartAnimationController;
  late AnimationController _contentAnimationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _chartScaleAnimation;
  late Animation<double> _earningsAnimation;
  late Animation<double> _growthAnimation;

  @override
  void initState() {
    super.initState();

    // Card entrance animation
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    // Chart drawing animation
    _chartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Content animation
    _contentAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Slide animation from right
    _slideAnimation = Tween<double>(
      begin: 80.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _cardAnimationController,
      curve: Curves.easeInOut,
    ));

    // Chart scale animation
    _chartScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _chartAnimationController,
      curve: Curves.elasticOut,
    ));

    // Earnings count animation
    _earningsAnimation = Tween<double>(
      begin: 0.0,
      end: widget.report.totalEarning,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Growth percentage animation
    _growthAnimation = Tween<double>(
      begin: 0.0,
      end: widget.report.growthPercentage,
    ).animate(CurvedAnimation(
      parent: _contentAnimationController,
      curve: Curves.bounceOut,
    ));

    // Start animations with staggered timing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardAnimationController.forward();
      Future.delayed(const Duration(milliseconds: 400), () {
        _chartAnimationController.forward();
        _contentAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _chartAnimationController.dispose();
    _contentAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_slideAnimation.value, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animated Header
                    TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 800),
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Today\'s Report',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppDimensions.paddingLarge),

                    // Chart and Details Row
                    Row(
                      children: [
                        // Animated Donut Chart
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 120,
                            child: AnimatedBuilder(
                              animation: _chartAnimationController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _chartScaleAnimation.value,
                                  child: CustomPaint(
                                    painter: AnimatedDonutChartPainter(
                                      widget.report.chartData,
                                      _chartAnimationController.value,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: AppDimensions.paddingLarge),

                        // Animated Details
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Animated Total Earning
                              AnimatedBuilder(
                                animation: _contentAnimationController,
                                builder: (context, child) {
                                  return const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Earning',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       '\${_earningsAnimation.value.toStringAsFixed(2)}',
                                      //       style: const TextStyle(
                                      //         fontSize: 16,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: AppColors.textPrimary,
                                      //       ),
                                      //     ),
                                      //     const SizedBox(width: 4),
                                      //     Text(
                                      //       '${_growthAnimation.value.toStringAsFixed(0)}%',
                                      //       style: TextStyle(
                                      //         fontSize: 12,
                                      //         color: Colors.green[600],
                                      //         fontWeight: FontWeight.w500,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ],
                                  );
                                },
                              ),

                              const SizedBox(
                                  height: AppDimensions.paddingMedium),

                              // Animated Legend Items
                              ...widget.report.chartData.asMap().entries.map(
                                    (entry) => _buildAnimatedLegendItem(
                                        entry.value, entry.key),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedLegendItem(ChartDataModel data, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (index * 150)),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 400 + (index * 100)),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    curve: Curves.easeOutBack,
                    builder: (context, scaleValue, child) {
                      return Transform.scale(
                        scale: scaleValue,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: data.color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      data.label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Custom Painter for Animated Donut Chart
class AnimatedDonutChartPainter extends CustomPainter {
  final List<ChartDataModel> data;
  final double animationValue;

  AnimatedDonutChartPainter(this.data, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final innerRadius = radius * 0.6;

    double total = data.fold(0, (sum, item) => sum + item.value);
    double startAngle = -math.pi / 2;

    for (int i = 0; i < data.length; i++) {
      var item = data[i];
      double sweepAngle = (item.value / total) * 2 * math.pi * animationValue;

      final paint = Paint()
        ..color = item.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = radius - innerRadius
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: (radius + innerRadius) / 2),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += (item.value / total) * 2 * math.pi * animationValue;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
