import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/monthly_progress_model.dart';

class MonthlyProgressSyncfusionCard extends StatelessWidget {
  final List<MonthlyProgressModel> data;
  final String selectedPeriod;
  final Function(String) onPeriodChanged;

  const MonthlyProgressSyncfusionCard({
    super.key,
    required this.data,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedPeriod,
                      icon: const Icon(Icons.keyboard_arrow_down, size: 18),
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary),
                      items: const ['Monthly', 'Weekly', 'Yearly']
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) onPeriodChanged(newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            SizedBox(
              height: 260,
              child: RepaintBoundary(
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                    format: 'point.x: point.yk',
                  ),
                  primaryXAxis: const CategoryAxis(
                    axisLine: AxisLine(width: 0),
                    majorGridLines: MajorGridLines(width: 0),
                    labelStyle:
                        TextStyle(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  primaryYAxis: const NumericAxis(
                    axisLine: AxisLine(width: 0),
                    majorTickLines: MajorTickLines(size: 0),
                    majorGridLines:
                        MajorGridLines(width: 1, color: Color(0x11000000)),
                    labelStyle: TextStyle(fontSize: 11),
                  ),
                  series: <CartesianSeries<MonthlyProgressModel, String>>[
                    ColumnSeries<MonthlyProgressModel, String>(
                      dataSource: data,
                      xValueMapper: (d, _) => d.month,
                      yValueMapper: (d, _) => d.value,
                      pointColorMapper: (d, _) => d.isHighlighted
                          ? Colors.black87
                          : Colors.green.shade400,
                      width: 0.7,
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      animationDuration: 1200,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelAlignment: ChartDataLabelAlignment.outer,
                        textStyle: TextStyle(
                          fontSize: 11,
                          color: AppColors.textPrimary,
                        ),
                        useSeriesColor: false,
                        showZeroValue: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMedium),

            // Legend for highlight
            const Row(
              children: [
                _LegendDot(color: Colors.green),
                SizedBox(width: 6),
                Text('Regular',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
                SizedBox(width: 16),
                _LegendDot(color: Colors.black87),
                SizedBox(width: 6),
                Text('Highlight',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  const _LegendDot({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
