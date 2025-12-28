import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/attendance_view_model.dart';
import '../../model/attendance_model.dart';
import '../widgets/filter_panel.dart';
import '../widgets/attendance_table.dart';
import '../widgets/attendance_card.dart';
import '../widgets/pagination_widget.dart';

class TodayAttendanceTab extends StatelessWidget {
  const TodayAttendanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceViewModel>(
      builder: (context, viewModel, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop = constraints.maxWidth > 800;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Summary Cards
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
                    child: _buildStatusSummary(
                      {
                        'present':
                            viewModel.statusCounts[AttendanceStatus.present] ??
                                0,
                        'late':
                            viewModel.statusCounts[AttendanceStatus.late] ?? 0,
                        'absent':
                            viewModel.statusCounts[AttendanceStatus.absent] ??
                                0,
                        'leave':
                            viewModel.statusCounts[AttendanceStatus.leave] ?? 0,
                      },
                      isDesktop,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Filter Panel
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      );
                    },
                    child: FilterPanel(
                      searchQuery: viewModel.searchQuery,
                      selectedDepartment: viewModel.selectedDepartment,
                      selectedStatus: viewModel.selectedStatus,
                      departments: viewModel.departments,
                      onSearchChanged: viewModel.searchAttendance,
                      onDepartmentChanged: viewModel.filterByDepartment,
                      onStatusChanged: viewModel.filterByStatus,
                      onClearFilters: viewModel.clearFilters,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Attendance List
                  if (viewModel.attendanceList.isEmpty)
                    _buildEmptyState()
                  else if (isDesktop)
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 700),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: AttendanceTable(
                        attendanceList: viewModel.attendanceList,
                      ),
                    )
                  else
                    Column(
                      children: List.generate(
                        viewModel.attendanceList.length,
                        (index) => AttendanceCard(
                          attendance: viewModel.attendanceList[index],
                          index: index,
                        ),
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Pagination
                  if (viewModel.attendanceList.isNotEmpty)
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: child,
                        );
                      },
                      child: PaginationWidget(
                        currentPage: viewModel.currentPage,
                        totalPages: viewModel.totalPages,
                        pageSize: viewModel.pageSize,
                        totalRecords: viewModel.totalRecords,
                        onPageChanged: viewModel.changePage,
                        onPageSizeChanged: viewModel.changePageSize,
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStatusSummary(Map<String, int> statusCounts, bool isDesktop) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _buildSummaryCard(
          'Present',
          statusCounts['present'] ?? 0,
          Icons.check_circle,
          const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)],
          ),
        ),
        _buildSummaryCard(
          'Late',
          statusCounts['late'] ?? 0,
          Icons.access_time,
          const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
          ),
        ),
        _buildSummaryCard(
          'Absent',
          statusCounts['absent'] ?? 0,
          Icons.cancel,
          const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          ),
        ),
        _buildSummaryCard(
          'Leave',
          statusCounts['leave'] ?? 0,
          Icons.event_note,
          const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(
    String label,
    int count,
    IconData icon,
    Gradient gradient,
  ) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF14B8A6), Color(0xFF0D9488)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF14B8A6).withOpacity(0.3),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                Icons.search_off,
                size: 56,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No attendance records found',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your filters to see more results',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
