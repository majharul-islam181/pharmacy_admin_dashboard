import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

class CrmChartsRow extends StatelessWidget {
  const CrmChartsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isStacked = maxWidth < 1000;

        if (isStacked) {
          return const Column(
            children: [
              TotalSalesChartCard(),
              SizedBox(height: AppDimensions.paddingLarge),
              RevenueForecastChartCard(),
            ],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: TotalSalesChartCard()),
            SizedBox(width: AppDimensions.paddingLarge),
            Expanded(child: RevenueForecastChartCard()),
          ],
        );
      },
    );
  }
}

class TotalSalesChartCard extends StatelessWidget {
  const TotalSalesChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const revenue = <double>[50, 48, 55, 60, 70, 75, 80, 78, 72, 65, 58, 52];
    const other = <double>[40, 38, 42, 45, 50, 55, 60, 58, 55, 50, 45, 42];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Sales',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Monthly performance over the last year.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
                  label: const Text('Hours'),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const SizedBox(
              height: 220,
              child: _FlTotalSalesChart(
                revenue: revenue,
                other: other,
              ),
            ),
            const SizedBox(height: 16),
            const _LineChartLegend(),
          ],
        ),
      ),
    );
  }
}

class _FlTotalSalesChart extends StatelessWidget {
  final List<double> revenue;
  final List<double> other;

  const _FlTotalSalesChart({
    required this.revenue,
    required this.other,
  });

  @override
  Widget build(BuildContext context) {
    final months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    List<FlSpot> spotsFor(List<double> values) {
      return [
        for (var i = 0; i < values.length; i++) FlSpot(i.toDouble(), values[i]),
      ];
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (months.length - 1).toDouble(),
        minY: 30,
        maxY: 90,
        gridData: FlGridData(
          show: true,
          horizontalInterval: 10,
          getDrawingHorizontalLine: (value) => const FlLine(
            color: Color(0xFFE5E7EB),
            strokeWidth: 0.8,
          ),
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= months.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    months[index],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineTouchData: const LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spotsFor(other),
            isCurved: true,
            color: const Color(0xFF9CA3AF),
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 3,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: const Color(0xFF9CA3AF),
              ),
            ),
            belowBarData: BarAreaData(show: false),
          ),
          LineChartBarData(
            spots: spotsFor(revenue),
            isCurved: true,
            color: const Color(0xFF2563EB),
            barWidth: 2,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) =>
                  FlDotCirclePainter(
                radius: 3,
                color: Colors.white,
                strokeWidth: 2,
                strokeColor: const Color(0xFF2563EB),
              ),
            ),
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }
}

class _LineChartLegend extends StatelessWidget {
  const _LineChartLegend();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _LegendItem(color: Color(0xFF2563EB), label: 'Revenue'),
        SizedBox(width: 24),
        _LegendItem(color: Color(0xFF9CA3AF), label: 'Other'),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 18,
          height: 2,
          margin: const EdgeInsets.only(right: 4),
          color: color,
        ),
        CircleAvatar(
          radius: 3,
          backgroundColor: color,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class RevenueForecastChartCard extends StatelessWidget {
  const RevenueForecastChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const sales = <double>[18, 20, 24, 30, 28, 26, 24, 27, 29, 25, 22, 20];
    const cost = <double>[12, 13, 15, 18, 17, 16, 15, 16, 18, 16, 14, 13];

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue Forecast',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Projected revenue vs product cost.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert, size: 20),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const SizedBox(
              height: 220,
              child: _AnimatedBarChart(
                sales: sales,
                cost: cost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedBarChart extends StatelessWidget {
  final List<double> sales;
  final List<double> cost;

  const _AnimatedBarChart({
    required this.sales,
    required this.cost,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, t, _) {
        final maxValue = math.max(
          sales.reduce(math.max),
          cost.reduce(math.max),
        );

        return Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (var i = 0; i < sales.length; i++)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 120 * (cost[i] / maxValue) * t,
                                  decoration: BoxDecoration(
                                    color: colorScheme.outlineVariant,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Flexible(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 160 * (sales[i] / maxValue) * t,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22C55E),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF22C55E),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Sales Revenue',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Product Cost',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
