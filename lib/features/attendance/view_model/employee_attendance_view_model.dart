import 'package:flutter/material.dart';
import '../model/attendance_model.dart';
import '../model/employee_model.dart';
import '../model/chart_data_model.dart';

class EmployeeAttendanceViewModel extends ChangeNotifier {
  List<EmployeeModel> _employees = [];
  final Map<String, List<AttendanceModel>> _employeeAttendance = {};

  EmployeeModel? _selectedEmployee;
  ChartPeriod _chartPeriod = ChartPeriod.weekly;

  // Getters
  List<EmployeeModel> get employees => _employees;
  EmployeeModel? get selectedEmployee => _selectedEmployee;
  ChartPeriod get chartPeriod => _chartPeriod;

  List<AttendanceModel> get attendanceHistory {
    if (_selectedEmployee == null) return [];
    return _employeeAttendance[_selectedEmployee!.id] ?? [];
  }

  // Get attendance history for a specific employee
  List<AttendanceModel> getAttendanceHistory(String employeeId) {
    return _employeeAttendance[employeeId] ?? [];
  }

  AttendanceChartData get chartData {
    if (_selectedEmployee == null) {
      return AttendanceChartData(
        presentData: [],
        lateData: [],
        absentData: [],
        period: _chartPeriod,
      );
    }

    final history = attendanceHistory;
    final now = DateTime.now();
    final daysToShow = _chartPeriod == ChartPeriod.weekly ? 7 : 30;

    final presentData = <ChartDataModel>[];
    final lateData = <ChartDataModel>[];
    final absentData = <ChartDataModel>[];

    for (int i = daysToShow - 1; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayRecords = history
          .where((a) =>
              a.date.year == date.year &&
              a.date.month == date.month &&
              a.date.day == date.day)
          .toList();

      final presentCount = dayRecords
          .where((a) => a.status == AttendanceStatus.present)
          .length
          .toDouble();
      final lateCount = dayRecords
          .where((a) => a.status == AttendanceStatus.late)
          .length
          .toDouble();
      final absentCount = dayRecords
          .where((a) => a.status == AttendanceStatus.absent)
          .length
          .toDouble();

      final label = _chartPeriod == ChartPeriod.weekly
          ? ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1]
          : '${date.day}';

      presentData
          .add(ChartDataModel(label: label, value: presentCount, date: date));
      lateData.add(ChartDataModel(label: label, value: lateCount, date: date));
      absentData
          .add(ChartDataModel(label: label, value: absentCount, date: date));
    }

    return AttendanceChartData(
      presentData: presentData,
      lateData: lateData,
      absentData: absentData,
      period: _chartPeriod,
    );
  }

  Map<AttendanceStatus, int> get statusSummary {
    if (_selectedEmployee == null) {
      return {
        AttendanceStatus.present: 0,
        AttendanceStatus.late: 0,
        AttendanceStatus.absent: 0,
        AttendanceStatus.leave: 0,
      };
    }

    final history = attendanceHistory;
    return {
      AttendanceStatus.present:
          history.where((a) => a.status == AttendanceStatus.present).length,
      AttendanceStatus.late:
          history.where((a) => a.status == AttendanceStatus.late).length,
      AttendanceStatus.absent:
          history.where((a) => a.status == AttendanceStatus.absent).length,
      AttendanceStatus.leave:
          history.where((a) => a.status == AttendanceStatus.leave).length,
    };
  }

  EmployeeAttendanceViewModel() {
    _initMockData();
  }

  void _initMockData() {
    _employees = [
      EmployeeModel(
        id: 'EMP1001',
        name: 'John Smith',
        email: 'john.smith@company.com',
        department: 'Engineering',
        position: 'Senior Developer',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        joinDate: DateTime(2022, 1, 15),
      ),
      EmployeeModel(
        id: 'EMP1002',
        name: 'Emma Wilson',
        email: 'emma.wilson@company.com',
        department: 'Sales',
        position: 'Sales Manager',
        avatarUrl: 'https://i.pravatar.cc/150?img=45',
        joinDate: DateTime(2021, 6, 20),
      ),
      EmployeeModel(
        id: 'EMP1003',
        name: 'Michael Brown',
        email: 'michael.brown@company.com',
        department: 'HR',
        position: 'HR Specialist',
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        joinDate: DateTime(2023, 3, 10),
      ),
      EmployeeModel(
        id: 'EMP1004',
        name: 'Sophia Davis',
        email: 'sophia.davis@company.com',
        department: 'Marketing',
        position: 'Marketing Lead',
        avatarUrl: 'https://i.pravatar.cc/150?img=47',
        joinDate: DateTime(2022, 8, 5),
      ),
    ];

    // Generate attendance history for each employee
    for (final employee in _employees) {
      final history = <AttendanceModel>[];
      final now = DateTime.now();

      for (int i = 0; i < 30; i++) {
        final date = now.subtract(Duration(days: i));
        final dayOfWeek = date.weekday;

        // Skip weekends
        if (dayOfWeek == 6 || dayOfWeek == 7) continue;

        AttendanceStatus status;
        DateTime? checkIn;
        DateTime? checkOut;

        // Randomize status with weighted probability
        final rand = i % 10;
        if (rand < 7) {
          status = AttendanceStatus.present;
          checkIn = DateTime(date.year, date.month, date.day, 8, 30 + (i % 30));
          checkOut =
              DateTime(date.year, date.month, date.day, 17, 0 + (i % 30));
        } else if (rand < 9) {
          status = AttendanceStatus.late;
          checkIn = DateTime(date.year, date.month, date.day, 9, 15 + (i % 45));
          checkOut = DateTime(date.year, date.month, date.day, 17, 30);
        } else {
          status =
              i % 15 == 0 ? AttendanceStatus.leave : AttendanceStatus.absent;
        }

        history.add(AttendanceModel(
          id: 'ATT${employee.id}_$i',
          employeeId: employee.id,
          employeeName: employee.name,
          department: employee.department,
          date: date,
          checkInTime: checkIn,
          checkOutTime: checkOut,
          status: status,
        ));
      }

      _employeeAttendance[employee.id] = history;
    }
  }

  void selectEmployee(EmployeeModel? employee) {
    _selectedEmployee = employee;
    notifyListeners();
  }

  void setChartPeriod(ChartPeriod period) {
    _chartPeriod = period;
    notifyListeners();
  }
}
