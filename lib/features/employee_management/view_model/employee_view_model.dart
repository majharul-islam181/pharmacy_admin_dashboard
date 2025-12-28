import 'dart:async';
import 'package:flutter/material.dart';
import '../model/employee_model.dart';

class EmployeeViewModel extends ChangeNotifier {
  List<EmployeeModel> _employees = [];
  List<EmployeeModel> _filteredEmployees = [];

  int _currentPage = 1;
  int _pageSize = 10;
  String _searchQuery = '';
  Timer? _debounceTimer;

  // Getters
  List<EmployeeModel> get employees => _filteredEmployees
      .skip((_currentPage - 1) * _pageSize)
      .take(_pageSize)
      .toList();

  int get currentPage => _currentPage;
  int get pageSize => _pageSize;
  int get totalPages => (_filteredEmployees.length / _pageSize).ceil();
  int get totalRecords => _filteredEmployees.length;
  String get searchQuery => _searchQuery;

  EmployeeViewModel() {
    _initializeMockData();
  }

  // Initialize with mock data
  void _initializeMockData() {
    _employees = [
      EmployeeModel(
        id: 'EMP001',
        name: 'Sarah Johnson',
        designation: 'Senior Pharmacist',
        phone: '+1 (555) 123-4567',
        email: 'sarah.johnson@pharmacy.com',
        joiningDate: DateTime(2020, 3, 15),
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        department: EmployeeDepartment.pharmacy,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP002',
        name: 'Michael Chen',
        designation: 'Sales Manager',
        phone: '+1 (555) 234-5678',
        email: 'michael.chen@pharmacy.com',
        joiningDate: DateTime(2019, 7, 22),
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
        department: EmployeeDepartment.sales,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP003',
        name: 'Emily Rodriguez',
        designation: 'Operations Coordinator',
        phone: '+1 (555) 345-6789',
        email: 'emily.rodriguez@pharmacy.com',
        joiningDate: DateTime(2021, 1, 10),
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        department: EmployeeDepartment.operations,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP004',
        name: 'David Thompson',
        designation: 'Pharmacy Assistant',
        phone: '+1 (555) 456-7890',
        email: 'david.thompson@pharmacy.com',
        joiningDate: DateTime(2022, 5, 18),
        avatarUrl: 'https://i.pravatar.cc/150?img=13',
        department: EmployeeDepartment.pharmacy,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP005',
        name: 'Jessica Martinez',
        designation: 'Customer Support Lead',
        phone: '+1 (555) 567-8901',
        email: 'jessica.martinez@pharmacy.com',
        joiningDate: DateTime(2020, 11, 5),
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        department: EmployeeDepartment.support,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP006',
        name: 'Robert Wilson',
        designation: 'General Manager',
        phone: '+1 (555) 678-9012',
        email: 'robert.wilson@pharmacy.com',
        joiningDate: DateTime(2018, 4, 12),
        avatarUrl: 'https://i.pravatar.cc/150?img=14',
        department: EmployeeDepartment.management,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP007',
        name: 'Amanda Lee',
        designation: 'Sales Representative',
        phone: '+1 (555) 789-0123',
        email: 'amanda.lee@pharmacy.com',
        joiningDate: DateTime(2021, 9, 28),
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
        department: EmployeeDepartment.sales,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP008',
        name: 'Christopher Brown',
        designation: 'Inventory Manager',
        phone: '+1 (555) 890-1234',
        email: 'christopher.brown@pharmacy.com',
        joiningDate: DateTime(2019, 12, 3),
        avatarUrl: 'https://i.pravatar.cc/150?img=15',
        department: EmployeeDepartment.operations,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP009',
        name: 'Lisa Anderson',
        designation: 'Clinical Pharmacist',
        phone: '+1 (555) 901-2345',
        email: 'lisa.anderson@pharmacy.com',
        joiningDate: DateTime(2020, 8, 17),
        avatarUrl: 'https://i.pravatar.cc/150?img=20',
        department: EmployeeDepartment.pharmacy,
        status: EmployeeStatus.inactive,
      ),
      EmployeeModel(
        id: 'EMP010',
        name: 'James Garcia',
        designation: 'Support Specialist',
        phone: '+1 (555) 012-3456',
        email: 'james.garcia@pharmacy.com',
        joiningDate: DateTime(2022, 2, 25),
        avatarUrl: 'https://i.pravatar.cc/150?img=33',
        department: EmployeeDepartment.support,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP011',
        name: 'Maria Hernandez',
        designation: 'Assistant Manager',
        phone: '+1 (555) 123-4568',
        email: 'maria.hernandez@pharmacy.com',
        joiningDate: DateTime(2019, 6, 14),
        avatarUrl: 'https://i.pravatar.cc/150?img=24',
        department: EmployeeDepartment.management,
        status: EmployeeStatus.active,
      ),
      EmployeeModel(
        id: 'EMP012',
        name: 'Daniel Taylor',
        designation: 'Sales Executive',
        phone: '+1 (555) 234-5679',
        email: 'daniel.taylor@pharmacy.com',
        joiningDate: DateTime(2021, 10, 7),
        avatarUrl: 'https://i.pravatar.cc/150?img=51',
        department: EmployeeDepartment.sales,
        status: EmployeeStatus.active,
      ),
    ];
    _filteredEmployees = List.from(_employees);
  }

  // Search employees
  void searchEmployees(String query) {
    _searchQuery = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _applyFilter();
    });
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredEmployees = List.from(_employees);
    } else {
      final lowerQuery = _searchQuery.toLowerCase();
      _filteredEmployees = _employees.where((employee) {
        return employee.name.toLowerCase().contains(lowerQuery) ||
            employee.designation.toLowerCase().contains(lowerQuery) ||
            employee.email.toLowerCase().contains(lowerQuery) ||
            employee.phone.contains(lowerQuery);
      }).toList();
    }
    _currentPage = 1;
    notifyListeners();
  }

  // Pagination
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

  // Add employee
  void addEmployee(EmployeeModel employee) {
    _employees.insert(0, employee);
    _applyFilter();
    notifyListeners();
  }

  // Update employee
  void updateEmployee(String id, EmployeeModel updatedEmployee) {
    final index = _employees.indexWhere((e) => e.id == id);
    if (index != -1) {
      _employees[index] = updatedEmployee;
      _applyFilter();
      notifyListeners();
    }
  }

  // Delete employee
  void deleteEmployee(String id) {
    _employees.removeWhere((e) => e.id == id);
    _applyFilter();
    notifyListeners();
  }

  // Get employee by ID
  EmployeeModel? getEmployeeById(String id) {
    try {
      return _employees.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _applyFilter();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}
