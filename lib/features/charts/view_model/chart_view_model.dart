import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../model/chart_data_model.dart';

class ChartViewModel extends ChangeNotifier {
  bool _isLoading = false;
  ChartCategory _selectedCategory = ChartCategory.overview;
  Timer? _liveDataTimer;

  bool get isLoading => _isLoading;
  ChartCategory get selectedCategory => _selectedCategory;

  // Sample data generators
  List<ChartDataPoint> _lineChartData = [];
  List<ChartDataPoint> _columnChartData = [];
  List<ChartSeries> _multiSeriesData = [];
  List<FinancialDataPoint> _financialData = [];
  List<ChartDataPoint> _pieChartData = [];
  List<BubbleDataPoint> _bubbleChartData = [];
  List<RangeDataPoint> _rangeChartData = [];

  List<ChartDataPoint> get lineChartData => _lineChartData;
  List<ChartDataPoint> get columnChartData => _columnChartData;
  List<ChartSeries> get multiSeriesData => _multiSeriesData;
  List<FinancialDataPoint> get financialData => _financialData;
  List<ChartDataPoint> get pieChartData => _pieChartData;
  List<BubbleDataPoint> get bubbleChartData => _bubbleChartData;
  List<RangeDataPoint> get rangeChartData => _rangeChartData;

  ChartViewModel() {
    _initializeData();
  }

  void _initializeData() {
    _generateLineChartData();
    _generateColumnChartData();
    _generateMultiSeriesData();
    _generateFinancialData();
    _generatePieChartData();
    _generateBubbleChartData();
    _generateRangeChartData();
  }

  void setCategory(ChartCategory category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Generate Line Chart Data
  void _generateLineChartData() {
    final random = Random();
    _lineChartData = List.generate(
      20,
      (index) => ChartDataPoint(
        x: index,
        y: 20 + random.nextDouble() * 60,
        label: 'Point $index',
      ),
    );
  }

  // Generate Column Chart Data
  void _generateColumnChartData() {
    final months = [
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
    ];
    final random = Random();
    _columnChartData = months.map((month) {
      return ChartDataPoint(
        x: month,
        y: 30 + random.nextDouble() * 70,
        label: month,
      );
    }).toList();
  }

  // Generate Multi-Series Data
  void _generateMultiSeriesData() {
    final random = Random();
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    _multiSeriesData = List.generate(4, (seriesIndex) {
      return ChartSeries(
        name: 'Series ${seriesIndex + 1}',
        color: colors[seriesIndex],
        data: List.generate(12, (index) {
          return ChartDataPoint(
            x: index,
            y: 20 + random.nextDouble() * 60,
          );
        }),
      );
    });
  }

  // Generate Financial Data (OHLC)
  void _generateFinancialData() {
    final random = Random();
    DateTime date = DateTime.now().subtract(const Duration(days: 90));
    double price = 100.0;

    _financialData = List.generate(90, (index) {
      final change = (random.nextDouble() - 0.5) * 10;
      price = (price + change).clamp(50.0, 200.0);

      final open = price;
      final close = price + (random.nextDouble() - 0.5) * 5;
      final high = max(open, close) + random.nextDouble() * 3;
      final low = min(open, close) - random.nextDouble() * 3;

      date = date.add(const Duration(days: 1));

      return FinancialDataPoint(
        date: date,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: 1000000 + random.nextDouble() * 5000000,
      );
    });
  }

  // Generate Pie Chart Data
  void _generatePieChartData() {
    final categories = [
      'Product A',
      'Product B',
      'Product C',
      'Product D',
      'Product E'
    ];
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
    ];

    _pieChartData = categories.asMap().entries.map((entry) {
      return ChartDataPoint(
        x: entry.value,
        y: 15 + Random().nextDouble() * 25,
        label: entry.value,
        color: colors[entry.key],
      );
    }).toList();
  }

  // Generate Bubble Chart Data
  void _generateBubbleChartData() {
    final random = Random();
    _bubbleChartData = List.generate(30, (index) {
      return BubbleDataPoint(
        x: random.nextDouble() * 100,
        y: random.nextDouble() * 100,
        size: 5 + random.nextDouble() * 25,
        label: 'Bubble $index',
      );
    });
  }

  // Generate Range Chart Data
  void _generateRangeChartData() {
    final months = [
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
    ];
    final random = Random();

    _rangeChartData = months.map((month) {
      final low = 10 + random.nextDouble() * 30;
      final high = low + 10 + random.nextDouble() * 30;
      return RangeDataPoint(
        x: month,
        low: low,
        high: high,
        label: month,
      );
    }).toList();
  }

  // Start live data updates
  void startLiveData() {
    _liveDataTimer?.cancel();
    _liveDataTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _updateLiveData();
    });
  }

  // Stop live data updates
  void stopLiveData() {
    _liveDataTimer?.cancel();
    _liveDataTimer = null;
  }

  // Update live data
  void _updateLiveData() {
    final random = Random();

    // Update line chart with new point
    if (_lineChartData.isNotEmpty) {
      _lineChartData.removeAt(0);
      _lineChartData.add(ChartDataPoint(
        x: _lineChartData.last.x + 1,
        y: 20 + random.nextDouble() * 60,
      ));
    }

    // Update financial data
    if (_financialData.isNotEmpty) {
      final lastData = _financialData.last;
      final change = (random.nextDouble() - 0.5) * 5;
      final newPrice = (lastData.close + change).clamp(50.0, 200.0);

      final open = lastData.close;
      final close = newPrice;
      final high = max(open, close) + random.nextDouble() * 2;
      final low = min(open, close) - random.nextDouble() * 2;

      _financialData.removeAt(0);
      _financialData.add(FinancialDataPoint(
        date: lastData.date.add(const Duration(days: 1)),
        open: open,
        high: high,
        low: low,
        close: close,
        volume: 1000000 + random.nextDouble() * 5000000,
      ));
    }

    notifyListeners();
  }

  // Refresh all data
  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _initializeData();

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _liveDataTimer?.cancel();
    super.dispose();
  }
}
