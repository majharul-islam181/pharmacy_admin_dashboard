enum ChartPeriod { weekly, monthly }

class ChartDataModel {
  final String label;
  final double value;
  final DateTime date;

  ChartDataModel({
    required this.label,
    required this.value,
    required this.date,
  });
}

class AttendanceChartData {
  final List<ChartDataModel> presentData;
  final List<ChartDataModel> lateData;
  final List<ChartDataModel> absentData;
  final ChartPeriod period;

  AttendanceChartData({
    required this.presentData,
    required this.lateData,
    required this.absentData,
    required this.period,
  });

  int get totalDays => presentData.length;

  double get presentPercentage {
    final total = presentData.fold<double>(0, (sum, item) => sum + item.value);
    final late = lateData.fold<double>(0, (sum, item) => sum + item.value);
    final absent = absentData.fold<double>(0, (sum, item) => sum + item.value);
    final totalCount = total + late + absent;
    return totalCount > 0 ? (total / totalCount) * 100 : 0;
  }
}
