import 'package:flutter/material.dart';
import '../model/report_summary_model.dart';
import '../model/top_product_model.dart';
import '../model/report_activity_model.dart';
import '../model/sales_chart_data_model.dart';

class ReportsViewModel extends ChangeNotifier {
  // State
  List<ReportSummaryModel> _summaries = [];
  List<TopProductModel> _topProducts = [];
  List<ReportActivityModel> _recentActivities = [];
  List<SalesChartDataPoint> _chartData = [];
  bool _isLoading = false;
  ChartPeriodFilter _selectedPeriod = ChartPeriodFilter.today;
  SalesChartType _selectedChartType = SalesChartType.revenue;

  // Getters
  List<ReportSummaryModel> get summaries => _summaries;
  List<TopProductModel> get topProducts => _topProducts;
  List<ReportActivityModel> get recentActivities => _recentActivities;
  List<SalesChartDataPoint> get chartData => _chartData;
  bool get isLoading => _isLoading;
  ChartPeriodFilter get selectedPeriod => _selectedPeriod;
  SalesChartType get selectedChartType => _selectedChartType;

  ReportsViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await refreshData();
  }

  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      _loadSummaries(),
      _loadTopProducts(),
      _loadRecentActivities(),
      _loadChartData(),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadSummaries() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _summaries = [
      ReportSummaryModel(
        type: ReportSummaryType.totalSales,
        value: '\$48,920',
        subtitle: 'Last 30 days',
        trendLabel: '+12.4% vs last period',
        trendPositive: true,
      ),
      ReportSummaryModel(
        type: ReportSummaryType.totalOrders,
        value: '1,284',
        subtitle: 'Completed & paid',
        trendLabel: '+4.1% vs last period',
        trendPositive: true,
      ),
      ReportSummaryModel(
        type: ReportSummaryType.netProfit,
        value: '\$12,640',
        subtitle: 'After discounts & tax',
        trendLabel: '+7.8% vs last period',
        trendPositive: true,
      ),
      ReportSummaryModel(
        type: ReportSummaryType.refunds,
        value: '\$1,120',
        subtitle: 'Processed this period',
        trendLabel: '-2.3% vs last period',
        trendPositive: false,
      ),
    ];
  }

  Future<void> _loadTopProducts() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _topProducts = [
      TopProductModel(
        id: '1',
        productName: 'Paracetamol 500mg',
        category: 'Pain Relief',
        unitsSold: 420,
        revenue: 3480.0,
      ),
      TopProductModel(
        id: '2',
        productName: 'Cough Syrup 100ml',
        category: 'Cold & Flu',
        unitsSold: 310,
        revenue: 2170.0,
      ),
      TopProductModel(
        id: '3',
        productName: 'Vitamin C Tablets',
        category: 'Supplements',
        unitsSold: 285,
        revenue: 1920.0,
      ),
      TopProductModel(
        id: '4',
        productName: 'Blood Pressure Monitor',
        category: 'Equipment',
        unitsSold: 64,
        revenue: 4260.0,
      ),
    ];
  }

  Future<void> _loadRecentActivities() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    _recentActivities = [
      ReportActivityModel(
        id: '1',
        type: ActivityType.pdfExport,
        title: 'Monthly sales report exported',
        subtitle: 'Exported by Admin on 24 Dec, 10:14 AM',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ReportActivityModel(
        id: '2',
        type: ActivityType.scheduled,
        title: 'Weekly email summary scheduled',
        subtitle: 'Will be sent every Monday at 9:00 AM',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      ),
      ReportActivityModel(
        id: '3',
        type: ActivityType.csvExport,
        title: 'Inventory valuation exported',
        subtitle: 'Exported by Manager on 22 Dec, 4:32 PM',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
      ),
    ];
  }

  Future<void> _loadChartData() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Sample data based on selected period and chart type
    if (_selectedChartType == SalesChartType.revenue) {
      _chartData = [
        SalesChartDataPoint(label: 'Mon', value: 4200),
        SalesChartDataPoint(label: 'Tue', value: 5100),
        SalesChartDataPoint(label: 'Wed', value: 4800),
        SalesChartDataPoint(label: 'Thu', value: 6300),
        SalesChartDataPoint(label: 'Fri', value: 7400),
        SalesChartDataPoint(label: 'Sat', value: 6900),
        SalesChartDataPoint(label: 'Sun', value: 5200),
      ];
    } else {
      _chartData = [
        SalesChartDataPoint(label: 'Mon', value: 42),
        SalesChartDataPoint(label: 'Tue', value: 51),
        SalesChartDataPoint(label: 'Wed', value: 48),
        SalesChartDataPoint(label: 'Thu', value: 63),
        SalesChartDataPoint(label: 'Fri', value: 74),
        SalesChartDataPoint(label: 'Sat', value: 69),
        SalesChartDataPoint(label: 'Sun', value: 52),
      ];
    }
  }

  void setPeriodFilter(ChartPeriodFilter period) {
    _selectedPeriod = period;
    notifyListeners();
    _loadChartData();
  }

  void setChartType(SalesChartType type) {
    _selectedChartType = type;
    notifyListeners();
    _loadChartData();
  }

  Future<void> exportPdf() async {
    // Simulate PDF export
    await Future.delayed(const Duration(seconds: 1));
    // Add new activity
    _recentActivities.insert(
      0,
      ReportActivityModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: ActivityType.pdfExport,
        title: 'Report exported to PDF',
        subtitle:
            'Exported by User on ${DateTime.now().toString().substring(0, 16)}',
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> exportCsv() async {
    // Simulate CSV export
    await Future.delayed(const Duration(seconds: 1));
    // Add new activity
    _recentActivities.insert(
      0,
      ReportActivityModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: ActivityType.csvExport,
        title: 'Report exported to CSV',
        subtitle:
            'Exported by User on ${DateTime.now().toString().substring(0, 16)}',
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
