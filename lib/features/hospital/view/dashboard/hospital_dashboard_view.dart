import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_model/dashboard_view_model.dart';
import '../widgets/stat_card.dart';
import '../widgets/doctor_tile.dart';

class HospitalDashboardView extends StatelessWidget {
  const HospitalDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DashboardViewModel>();
    final isMobile = MediaQuery.of(context).size.width < 800;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hospital Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          // Stat Cards
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile
                  ? 1
                  : (MediaQuery.of(context).size.width < 1200 ? 2 : 4),
              crossAxisSpacing: AppDimensions.paddingMedium,
              mainAxisSpacing: AppDimensions.paddingMedium,
              childAspectRatio: isMobile ? 3 : 2.5,
            ),
            itemCount: viewModel.stats.length,
            itemBuilder: (context, index) {
              final stat = viewModel.stats[index];
              return StatCard(
                title: stat.title,
                count: stat.count,
                icon: _getIconData(stat.icon),
                trend: stat.trend,
                index: index,
              );
            },
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          // Charts Section
          if (isMobile)
            Column(
              children: [
                _buildPatientChart(context, viewModel),
                const SizedBox(height: AppDimensions.paddingMedium),
                _buildReviewChart(context, viewModel),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildPatientChart(context, viewModel)),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(child: _buildReviewChart(context, viewModel)),
              ],
            ),
          const SizedBox(height: AppDimensions.paddingLarge),
          // Top Doctors
          _buildTopDoctorsSection(context, viewModel),
        ],
      ),
    );
  }

  Widget _buildPatientChart(
      BuildContext context, DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Patient Statistics',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              _buildPeriodToggle(viewModel),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: viewModel.patientChartData
                        .map((e) => e.value)
                        .reduce((a, b) => a > b ? a : b) *
                    1.2,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < viewModel.patientChartData.length) {
                          return Text(
                            viewModel.patientChartData[value.toInt()].label,
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups:
                    viewModel.patientChartData.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.value,
                        color: AppColors.primary,
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(4)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewChart(BuildContext context, DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Reviews',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < viewModel.reviewChartData.length) {
                          return Text(
                            viewModel.reviewChartData[value.toInt()].label,
                            style: const TextStyle(fontSize: 10),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots:
                        viewModel.reviewChartData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.value);
                    }).toList(),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.green.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodToggle(DashboardViewModel viewModel) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildPeriodButton('M', ChartPeriod.monthly, viewModel),
          _buildPeriodButton('W', ChartPeriod.weekly, viewModel),
          _buildPeriodButton('Y', ChartPeriod.yearly, viewModel),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(
      String label, ChartPeriod period, DashboardViewModel viewModel) {
    final isSelected = viewModel.selectedPeriod == period;
    return GestureDetector(
      onTap: () => viewModel.setChartPeriod(period),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
          ),
        ),
      ),
    );
  }

  Widget _buildTopDoctorsSection(
      BuildContext context, DashboardViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Top Doctors',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          ...viewModel.topDoctors.map((doctor) => DoctorTile(doctor: doctor)),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person_add':
        return Icons.person_add;
      case 'medical_services':
        return Icons.medical_services;
      case 'event':
        return Icons.event;
      case 'payments':
        return Icons.payments;
      default:
        return Icons.help;
    }
  }
}
