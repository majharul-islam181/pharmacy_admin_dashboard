import 'package:flutter/material.dart';
import '../../view_model/employee_attendance_view_model.dart';
import '../../../../core/constants/app_colors.dart';

class AttendanceStatusSummary extends StatelessWidget {
  final EmployeeAttendanceViewModel viewModel;

  const AttendanceStatusSummary({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final summary = viewModel.statusSummary;
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildSummaryTile(
          'Present',
          summary['present'] ?? 0,
          Icons.check_circle,
          AppColors.successDark,
        ),
        _buildSummaryTile(
          'Late',
          summary['late'] ?? 0,
          Icons.access_time,
          AppColors.warningDark,
        ),
        _buildSummaryTile(
          'Absent',
          summary['absent'] ?? 0,
          Icons.cancel,
          AppColors.errorDark,
        ),
        _buildSummaryTile(
          'Leave',
          summary['leave'] ?? 0,
          Icons.event_note,
          AppColors.purple,
        ),
      ],
    );
  }

  Widget _buildSummaryTile(
      String label, int count, IconData icon, Color color) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
