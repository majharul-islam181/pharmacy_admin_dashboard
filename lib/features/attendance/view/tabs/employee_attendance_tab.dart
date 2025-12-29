import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/employee_attendance_view_model.dart';
import '../widgets/animated_chart.dart';
import '../widgets/employee_selector_card.dart';
import '../widgets/attendance_status_summary.dart';
import '../widgets/chart_period_toggle.dart';
import '../widgets/attendance_history_card.dart';
import '../widgets/employee_empty_state.dart';

class EmployeeAttendanceTab extends StatelessWidget {
  const EmployeeAttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeAttendanceViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Employee Selector
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: EmployeeSelectorCard(viewModel: viewModel),
              ),

              const SizedBox(height: 24),

              // Status Summary
              if (viewModel.selectedEmployee != null)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 700),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: AttendanceStatusSummary(viewModel: viewModel),
                ),

              const SizedBox(height: 24),

              // Chart Period Toggle & Chart
              if (viewModel.selectedEmployee != null) ...[
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      ChartPeriodToggle(viewModel: viewModel),
                      const SizedBox(height: 16),
                      AnimatedAttendanceChart(
                        chartData: viewModel.chartData,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Attendance History
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 900),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: AttendanceHistoryCard(viewModel: viewModel),
                ),
              ],

              if (viewModel.selectedEmployee == null)
                const EmployeeEmptyState(),
            ],
          ),
        );
      },
    );
  }
}
