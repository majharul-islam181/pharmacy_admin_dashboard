import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/attendance_model.dart';
import 'status_badge.dart';
import '../../../../core/constants/app_colors.dart';

class AttendanceTable extends StatelessWidget {
  final List<AttendanceModel> attendanceList;

  const AttendanceTable({
    super.key,
    required this.attendanceList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:  AppColors.borderLight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFF8FAFC),
                  const Color(0xFFF1F5F9).withOpacity(0.8),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              border: const Border(
                bottom: BorderSide(
                  color: AppColors.borderLight,
                  width: 2,
                ),
              ),
            ),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.5),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                5: FlexColumnWidth(1.2),
                6: FlexColumnWidth(0.8),
              },
              children: [
                TableRow(
                  children: [
                    _buildHeader('Employee'),
                    _buildHeader('Department'),
                    _buildHeader('ID'),
                    _buildHeader('Check-in'),
                    _buildHeader('Check-out'),
                    _buildHeader('Work Period'),
                    _buildHeader('Status'),
                  ],
                ),
              ],
            ),
          ),
          // Rows
          ...attendanceList.asMap().entries.map((entry) {
            return _buildRow(entry.value, entry.key);
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.gray600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildRow(AttendanceModel attendance, int index) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 200 + (index * 30)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:  AppColors.borderLight.withOpacity(0.5),
            ),
          ),
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1.2),
            6: FlexColumnWidth(0.8),
          },
          children: [
            TableRow(
              children: [
                _buildCell(attendance.employeeName, isName: true),
                _buildCell(attendance.department),
                _buildCell(attendance.employeeId),
                _buildCell(
                  attendance.checkInTime != null
                      ? DateFormat('HH:mm').format(attendance.checkInTime!)
                      : 'N/A',
                ),
                _buildCell(
                  attendance.checkOutTime != null
                      ? DateFormat('HH:mm').format(attendance.checkOutTime!)
                      : 'N/A',
                ),
                _buildCell(attendance.workPeriod),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child:
                      StatusBadge(status: attendance.status, animated: false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String text, {bool isName = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isName ? FontWeight.w600 : FontWeight.w500,
          color: isName ? const Color(0xFF1E293B) :  AppColors.gray500,
        ),
      ),
    );
  }
}
