import 'package:flutter/material.dart';
import '../../view_model/employee_attendance_view_model.dart';
import '../../model/chart_data_model.dart';
import '../../../../core/constants/app_colors.dart';

class ChartPeriodToggle extends StatelessWidget {
  final EmployeeAttendanceViewModel viewModel;

  const ChartPeriodToggle({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Period:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(width: 12),
        _buildToggleButton(
          'Weekly',
          viewModel.chartPeriod == ChartPeriod.weekly,
          () => viewModel.setChartPeriod(ChartPeriod.weekly),
        ),
        const SizedBox(width: 8),
        _buildToggleButton(
          'Monthly',
          viewModel.chartPeriod == ChartPeriod.monthly,
          () => viewModel.setChartPeriod(ChartPeriod.monthly),
        ),
      ],
    );
  }

  Widget _buildToggleButton(String label, bool isActive, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                )
              : null,
          color: isActive ? null : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.white : AppColors.gray500,
          ),
        ),
      ),
    );
  }
}
