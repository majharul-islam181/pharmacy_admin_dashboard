import 'dart:async';
import 'package:flutter/material.dart';
import '../model/attendance_model.dart';

class AttendanceViewModel extends ChangeNotifier {
  List<AttendanceModel> _allAttendance = [];
  List<AttendanceModel> _filteredAttendance = [];

  // Pagination
  int _currentPage = 1;
  int _pageSize = 10;

  // Filters
  String _searchQuery = '';
  String? _selectedDepartment;
  AttendanceStatus? _selectedStatus;

  Timer? _debounceTimer;

  // Getters
  List<AttendanceModel> get attendanceList {
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = startIndex + _pageSize;
    if (startIndex >= _filteredAttendance.length) return [];
    return _filteredAttendance.sublist(
      startIndex,
      endIndex > _filteredAttendance.length
          ? _filteredAttendance.length
          : endIndex,
    );
  }

  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  int get totalPages => (_filteredAttendance.length / _pageSize).ceil();
  int get totalRecords => _filteredAttendance.length;
  String get searchQuery => _searchQuery;
  String? get selectedDepartment => _selectedDepartment;
  AttendanceStatus? get selectedStatus => _selectedStatus;

  List<String> get departments {
    final deps = _allAttendance.map((a) => a.department).toSet().toList();
    deps.sort();
    return deps;
  }

  Map<AttendanceStatus, int> get statusCounts {
    return {
      AttendanceStatus.present: _filteredAttendance
          .where((a) => a.status == AttendanceStatus.present)
          .length,
      AttendanceStatus.late: _filteredAttendance
          .where((a) => a.status == AttendanceStatus.late)
          .length,
      AttendanceStatus.absent: _filteredAttendance
          .where((a) => a.status == AttendanceStatus.absent)
          .length,
      AttendanceStatus.leave: _filteredAttendance
          .where((a) => a.status == AttendanceStatus.leave)
          .length,
    };
  }

  AttendanceViewModel() {
    _initMockData();
  }

  void _initMockData() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final names = [
      'John Smith',
      'Emma Wilson',
      'Michael Brown',
      'Sophia Davis',
      'James Johnson',
      'Olivia Martinez',
      'William Garcia',
      'Ava Rodriguez',
      'David Miller',
      'Isabella Lopez',
      'Robert Taylor',
      'Mia Anderson',
      'Joseph Thomas',
      'Charlotte Jackson',
      'Charles White',
      'Amelia Harris',
      'Daniel Martin',
      'Harper Thompson',
      'Matthew Lee',
      'Evelyn Moore'
    ];

    final departments = ['Engineering', 'Sales', 'HR', 'Marketing', 'Finance'];
    final statuses = [
      AttendanceStatus.present,
      AttendanceStatus.late,
      AttendanceStatus.absent,
      AttendanceStatus.leave
    ];

    _allAttendance = List.generate(45, (index) {
      final status = index < 30
          ? statuses[0]
          : index < 35
              ? statuses[1]
              : index < 40
                  ? statuses[2]
                  : statuses[3];

      DateTime? checkIn;
      DateTime? checkOut;

      if (status == AttendanceStatus.present) {
        checkIn =
            DateTime(today.year, today.month, today.day, 8, 30 + (index % 30));
        checkOut =
            DateTime(today.year, today.month, today.day, 17, 0 + (index % 30));
      } else if (status == AttendanceStatus.late) {
        checkIn =
            DateTime(today.year, today.month, today.day, 9, 15 + (index % 45));
        checkOut =
            DateTime(today.year, today.month, today.day, 17, 30 + (index % 30));
      }

      return AttendanceModel(
        id: 'ATT${1000 + index}',
        employeeId: 'EMP${1000 + index}',
        employeeName: names[index % names.length],
        department: departments[index % departments.length],
        date: today,
        checkInTime: checkIn,
        checkOutTime: checkOut,
        status: status,
        notes: status == AttendanceStatus.leave ? 'Medical Leave' : null,
      );
    });

    _filteredAttendance = List.from(_allAttendance);
  }

  void searchAttendance(String query) {
    _searchQuery = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _applyFilters();
    });
  }

  void filterByDepartment(String? department) {
    _selectedDepartment = department;
    _currentPage = 1;
    _applyFilters();
  }

  void filterByStatus(AttendanceStatus? status) {
    _selectedStatus = status;
    _currentPage = 1;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredAttendance = _allAttendance.where((attendance) {
      bool matchesSearch = _searchQuery.isEmpty ||
          attendance.employeeName
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          attendance.employeeId
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

      bool matchesDepartment = _selectedDepartment == null ||
          attendance.department == _selectedDepartment;

      bool matchesStatus =
          _selectedStatus == null || attendance.status == _selectedStatus;

      return matchesSearch && matchesDepartment && matchesStatus;
    }).toList();

    notifyListeners();
  }

  void changePage(int page) {
    if (page >= 1 && page <= totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  void changePageSize(int size) {
    _pageSize = size;
    _currentPage = 1;
    notifyListeners();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedDepartment = null;
    _selectedStatus = null;
    _currentPage = 1;
    _filteredAttendance = List.from(_allAttendance);
    notifyListeners();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
