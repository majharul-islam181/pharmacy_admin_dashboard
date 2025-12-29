class CrmSummaryModel {
  final String id;
  final String title;
  final String value;
  final String deltaText;
  final bool deltaPositive;
  final CrmSummaryType type;

  CrmSummaryModel({
    required this.id,
    required this.title,
    required this.value,
    required this.deltaText,
    required this.deltaPositive,
    required this.type,
  });
}

enum CrmSummaryType {
  totalLeads,
  totalRevenue,
  pendingTasks,
  completedContracts,
  newSubscribers,
}
