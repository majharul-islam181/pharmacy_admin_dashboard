import 'package:flutter/material.dart';
import '../model/crm_summary_model.dart';
import '../model/lead_model.dart';
import '../model/chart_data_model.dart';

class CrmViewModel extends ChangeNotifier {
  // Summary Data
  List<CrmSummaryModel> _summaries = [];
  List<CrmSummaryModel> get summaries => _summaries;

  // Lead Data
  List<LeadModel> _leads = [];
  List<LeadModel> get leads => _leads;

  // Chart Data
  SalesChartData? _salesChartData;
  SalesChartData? get salesChartData => _salesChartData;

  RevenueChartData? _revenueChartData;
  RevenueChartData? get revenueChartData => _revenueChartData;

  // Loading State
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CrmViewModel() {
    _initializeData();
  }

  void _initializeData() {
    _loadSummaries();
    _loadLeads();
    _loadChartData();
  }

  void _loadSummaries() {
    _summaries = [
      CrmSummaryModel(
        id: '1',
        title: 'Total Leads',
        value: '823',
        deltaText: '15.78%',
        deltaPositive: true,
        type: CrmSummaryType.totalLeads,
      ),
      CrmSummaryModel(
        id: '2',
        title: 'Total Revenue',
        value: '1,235.75',
        deltaText: '12.50%',
        deltaPositive: true,
        type: CrmSummaryType.totalRevenue,
      ),
      CrmSummaryModel(
        id: '3',
        title: 'Pending Tasks',
        value: '78',
        deltaText: '-23.45%',
        deltaPositive: false,
        type: CrmSummaryType.pendingTasks,
      ),
      CrmSummaryModel(
        id: '4',
        title: 'Completed Contracts',
        value: '543.60',
        deltaText: '18.45%',
        deltaPositive: true,
        type: CrmSummaryType.completedContracts,
      ),
      CrmSummaryModel(
        id: '5',
        title: 'New Subscribers',
        value: '120',
        deltaText: '9.25%',
        deltaPositive: true,
        type: CrmSummaryType.newSubscribers,
      ),
    ];
    notifyListeners();
  }

  void _loadLeads() {
    _leads = [
      LeadModel(
        id: '1',
        serialNumber: '#1',
        leadName: 'Erik',
        companyName: 'Digitube',
        phoneNumber: '957-550-9950',
        status: LeadStatus.won,
        location: 'Tasouloukou',
      ),
      LeadModel(
        id: '2',
        serialNumber: '#2',
        leadName: 'Sabina',
        companyName: 'Kwinu',
        phoneNumber: '612-207-4109',
        status: LeadStatus.lost,
        location: 'Minneapolis',
      ),
      LeadModel(
        id: '3',
        serialNumber: '#3',
        leadName: 'Andi',
        companyName: 'Photojam',
        phoneNumber: '410-936-5855',
        status: LeadStatus.won,
        location: 'Masina',
      ),
      LeadModel(
        id: '4',
        serialNumber: '#4',
        leadName: 'Kathy',
        companyName: 'Quinu',
        phoneNumber: '840-267-7381',
        status: LeadStatus.won,
        location: 'Shashi',
      ),
      LeadModel(
        id: '5',
        serialNumber: '#5',
        leadName: 'Lenka',
        companyName: 'Skaboo',
        phoneNumber: '962-993-3146',
        status: LeadStatus.won,
        location: 'Shireet',
      ),
    ];
    notifyListeners();
  }

  void _loadChartData() {
    _salesChartData = SalesChartData(
      revenueData: const [50, 48, 55, 60, 70, 75, 80, 78, 72, 65, 58, 52],
      otherData: const [40, 38, 42, 45, 50, 55, 60, 58, 55, 50, 45, 42],
      months: const [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ],
    );

    _revenueChartData = RevenueChartData(
      actualData: const [30, 35, 40, 38, 45, 50, 55, 60, 58, 62, 65, 70],
      forecastData: const [35, 40, 45, 48, 52, 58, 62, 68, 72, 75, 78, 82],
      months: const [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ],
    );

    notifyListeners();
  }

  // Method to refresh data
  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _loadSummaries();
    _loadLeads();
    _loadChartData();

    _isLoading = false;
    notifyListeners();
  }
}
