// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import '../../../../core/constants/app_colors.dart';
// import '../../../../core/constants/app_dimensions.dart';
// import '../../models/monthly_progress_model.dart';

// class MonthlyProgressCard extends StatelessWidget {
//   final List<MonthlyProgressModel> data;
//   final String selectedPeriod;
//   final Function(String) onPeriodChanged;

//   const MonthlyProgressCard({
//     super.key,
//     required this.data,
//     required this.selectedPeriod,
//     required this.onPeriodChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(AppDimensions.paddingLarge),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Monthly Progress',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: AppColors.border),
//                     borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
//                   ),
//                   child: DropdownButtonHideUnderline(
//                     child: DropdownButton<String>(
//                       value: selectedPeriod,
//                       icon: const Icon(Icons.keyboard_arrow_down, size: 18),
//                       style: const TextStyle(
//                         fontSize: 14,
//                         color: AppColors.textPrimary,
//                       ),
//                       items: ['Monthly', 'Weekly', 'Yearly'].map((String value) {
//                         return DropdownMenuItem<String>(
//                           value: value,
//                           child: Text(value),
//                         );
//                       }).toList(),
//                       onChanged: (String? newValue) {
//                         if (newValue != null) {
//                           onPeriodChanged(newValue);
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: AppDimensions.paddingLarge),

//             // FL Chart Bar Chart
//             SizedBox(
//               height: 220,
//               child: BarChart(
//                 BarChartData(
//                   alignment: BarChartAlignment.spaceAround,
//                   maxY: 100,
//                   minY: 0,
//                   gridData: FlGridData(
//                     show: true,
//                     drawHorizontalLine: true,
//                     drawVerticalLine: false,
//                     horizontalInterval: 20,
//                     getDrawingHorizontalLine: (value) {
//                       return FlLine(
//                         color: AppColors.border.withOpacity(0.3),
//                         strokeWidth: 1,
//                       );
//                     },
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         interval: 20,
//                         getTitlesWidget: (value, meta) {
//                           return Text(
//                             '${value.toInt()}',
//                             style: const TextStyle(
//                               color: AppColors.textSecondary,
//                               fontSize: 10,
//                             ),
//                           );
//                         },
//                         reservedSize: 28,
//                       ),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (value, meta) {
//                           if (value.toInt() >= 0 && value.toInt() < data.length) {
//                             return Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Text(
//                                 data[value.toInt()].month,
//                                 style: const TextStyle(
//                                   color: AppColors.textSecondary,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             );
//                           }
//                           return const Text('');
//                         },
//                         reservedSize: 32,
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: _buildBarGroups(),
//                   barTouchData: BarTouchData(
//                     enabled: true,
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.black87,
//                       tooltipRoundedRadius: 8,
//                       tooltipPadding: const EdgeInsets.all(8),
//                       getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                         if (groupIndex < data.length) {
//                           return BarTooltipItem(
//                             '${data[groupIndex].month}\n${rod.toY.toInt()}k',
//                             const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           );
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _buildBarGroups() {
//     return data.asMap().entries.map((entry) {
//       int index = entry.key;
//       MonthlyProgressModel item = entry.value;

//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: item.value,
//             color: item.isHighlighted ? Colors.black87 : Colors.green[400]!,
//             width: 16,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ],
//       );
//     }).toList();
//   }
// }
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/monthly_progress_model.dart';

class MonthlyProgressCard extends StatefulWidget {
  final List<MonthlyProgressModel> data;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const MonthlyProgressCard({
    super.key,
    required this.data,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  State<MonthlyProgressCard> createState() => _MonthlyProgressCardState();
}

class _MonthlyProgressCardState extends State<MonthlyProgressCard>
    with TickerProviderStateMixin {
  late AnimationController _cardAnimationController;
  late AnimationController _barsAnimationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  List<Animation<double>> _barAnimations = [];
  int? hoveredIndex;

  @override
  void initState() {
    super.initState();

    // Card entrance animation
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Bars growing animation
    _barsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Slide animation from bottom
    _slideAnimation = Tween<double>(
      begin: 50.0,
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

    // Create individual bar animations with staggered timing
    _barAnimations = widget.data.asMap().entries.map((entry) {
      int index = entry.key;
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _barsAnimationController,
        curve: Interval(
          index * 0.1, // Stagger each bar by 100ms
          0.8 + (index * 0.02), // End times spread out
          curve: Curves.elasticOut,
        ),
      ));
    }).toList();

    // Start animations
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cardAnimationController.forward();
      Future.delayed(const Duration(milliseconds: 300), () {
        _barsAnimationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _barsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _cardAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
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
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Monthly Progress',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusMedium),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: widget.selectedPeriod,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  size: 18),
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textPrimary,
                              ),
                              items: ['Monthly', 'Weekly', 'Yearly']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  widget.onPeriodChanged(newValue);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppDimensions.paddingLarge),

                    // Animated Bar Chart
                    SizedBox(
                      height: 220,
                      child: _buildAnimatedBarChart(),
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

  Widget _buildAnimatedBarChart() {
    double maxValue =
        widget.data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return AnimatedBuilder(
      animation: _barsAnimationController,
      builder: (context, child) {
        return Column(
          children: [
            // Y-axis labels and chart
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Y-axis
                  SizedBox(
                    width: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildYAxisLabel('100'),
                        _buildYAxisLabel('80'),
                        _buildYAxisLabel('60'),
                        _buildYAxisLabel('40'),
                        _buildYAxisLabel('20'),
                        _buildYAxisLabel('0'),
                      ],
                    ),
                  ),

                  const SizedBox(width: 10),

                  // Bars with animation
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: widget.data.asMap().entries.map((entry) {
                        int index = entry.key;
                        MonthlyProgressModel item = entry.value;
                        return _buildAnimatedBar(item, maxValue, index);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // X-axis labels
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.data
                    .map(
                      (item) => Text(
                        item.month,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildYAxisLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildAnimatedBar(
      MonthlyProgressModel item, double maxValue, int index) {
    double targetHeight = (item.value / maxValue) * 130; // Max height 160
    double animatedHeight = targetHeight * _barAnimations[index].value;
    bool isHovered = hoveredIndex == index;

    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Tooltip for highlighted or hovered bar
          if ((item.isHighlighted || isHovered) &&
              _barAnimations[index].value > 0.7)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 300),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        Text(
                          item.isHighlighted ? 'September' : item.month,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${item.value.toInt()}k',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          if ((item.isHighlighted || isHovered) &&
              _barAnimations[index].value > 0.7)
            const SizedBox(height: 8),

          // Animated Bar
          Container(
            width: 18,
            height: animatedHeight,
            decoration: BoxDecoration(
              color: item.isHighlighted ? Colors.black87 : Colors.green[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
