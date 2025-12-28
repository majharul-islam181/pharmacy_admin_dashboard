import 'package:flutter/material.dart';
import '../model/dashboard_model.dart';
import '../model/doctor_model.dart';

enum ChartPeriod { monthly, weekly, yearly }

class DashboardViewModel extends ChangeNotifier {
  ChartPeriod _selectedPeriod = ChartPeriod.monthly;
  List<DashboardStatModel> _stats = [];
  List<ChartDataModel> _patientChartData = [];
  List<ChartDataModel> _reviewChartData = [];
  List<DoctorModel> _topDoctors = [];

  ChartPeriod get selectedPeriod => _selectedPeriod;
  List<DashboardStatModel> get stats => _stats;
  List<ChartDataModel> get patientChartData => _patientChartData;
  List<ChartDataModel> get reviewChartData => _reviewChartData;
  List<DoctorModel> get topDoctors => _topDoctors;

  DashboardViewModel() {
    _initMockData();
  }

  void _initMockData() {
    _stats = [
      DashboardStatModel(
        title: 'New Patients',
        count: 156,
        icon: 'person_add',
        trend: '+12%',
      ),
      DashboardStatModel(
        title: 'Total Doctors',
        count: 48,
        icon: 'medical_services',
        trend: '+3%',
      ),
      DashboardStatModel(
        title: 'Total Appointments',
        count: 284,
        icon: 'event',
        trend: '+18%',
      ),
      DashboardStatModel(
        title: 'Total Payments',
        count: 52840,
        icon: 'payments',
        trend: '+25%',
      ),
    ];

    _updateChartData();
    _loadTopDoctors();
  }

  void _updateChartData() {
    switch (_selectedPeriod) {
      case ChartPeriod.monthly:
        _patientChartData = [
          ChartDataModel(label: 'Jan', value: 45),
          ChartDataModel(label: 'Feb', value: 52),
          ChartDataModel(label: 'Mar', value: 48),
          ChartDataModel(label: 'Apr', value: 65),
          ChartDataModel(label: 'May', value: 58),
          ChartDataModel(label: 'Jun', value: 72),
        ];
        _reviewChartData = [
          ChartDataModel(label: 'Jan', value: 120),
          ChartDataModel(label: 'Feb', value: 145),
          ChartDataModel(label: 'Mar', value: 138),
          ChartDataModel(label: 'Apr', value: 165),
          ChartDataModel(label: 'May', value: 180),
          ChartDataModel(label: 'Jun', value: 195),
        ];
        break;
      case ChartPeriod.weekly:
        _patientChartData = [
          ChartDataModel(label: 'Mon', value: 12),
          ChartDataModel(label: 'Tue', value: 15),
          ChartDataModel(label: 'Wed', value: 10),
          ChartDataModel(label: 'Thu', value: 18),
          ChartDataModel(label: 'Fri', value: 14),
          ChartDataModel(label: 'Sat', value: 8),
          ChartDataModel(label: 'Sun', value: 5),
        ];
        _reviewChartData = [
          ChartDataModel(label: 'Mon', value: 25),
          ChartDataModel(label: 'Tue', value: 32),
          ChartDataModel(label: 'Wed', value: 28),
          ChartDataModel(label: 'Thu', value: 35),
          ChartDataModel(label: 'Fri', value: 30),
          ChartDataModel(label: 'Sat', value: 18),
          ChartDataModel(label: 'Sun', value: 12),
        ];
        break;
      case ChartPeriod.yearly:
        _patientChartData = [
          ChartDataModel(label: '2020', value: 320),
          ChartDataModel(label: '2021', value: 420),
          ChartDataModel(label: '2022', value: 480),
          ChartDataModel(label: '2023', value: 580),
          ChartDataModel(label: '2024', value: 650),
        ];
        _reviewChartData = [
          ChartDataModel(label: '2020', value: 850),
          ChartDataModel(label: '2021', value: 1120),
          ChartDataModel(label: '2022', value: 1380),
          ChartDataModel(label: '2023', value: 1650),
          ChartDataModel(label: '2024', value: 1920),
        ];
        break;
    }
  }

  void _loadTopDoctors() {
    final now = DateTime.now();
    _topDoctors = [
      DoctorModel(
        id: '1',
        name: 'Dr. Sarah Johnson',
        specialist: 'Cardiologist',
        dateOfJoin: now.subtract(const Duration(days: 450)),
        appointmentCount: 8,
        contactNumber: '+1 234 567 8900',
        rating: 4.9,
        avatarUrl: 'SJ',
      ),
      DoctorModel(
        id: '2',
        name: 'Dr. Michael Chen',
        specialist: 'Neurologist',
        dateOfJoin: now.subtract(const Duration(days: 520)),
        appointmentCount: 7,
        contactNumber: '+1 234 567 8901',
        rating: 4.8,
        avatarUrl: 'MC',
      ),
      DoctorModel(
        id: '3',
        name: 'Dr. Emily Roberts',
        specialist: 'Pediatrician',
        dateOfJoin: now.subtract(const Duration(days: 380)),
        appointmentCount: 6,
        contactNumber: '+1 234 567 8902',
        rating: 4.7,
        avatarUrl: 'ER',
      ),
    ];
  }

  void setChartPeriod(ChartPeriod period) {
    _selectedPeriod = period;
    _updateChartData();
    notifyListeners();
  }
}
