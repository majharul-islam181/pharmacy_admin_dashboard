class MonthlyProgressModel {
  final String month;
  final double value;
  final bool isHighlighted;

  MonthlyProgressModel({
    required this.month,
    required this.value,
    this.isHighlighted = false,
  });

  MonthlyProgressModel copyWith({
    String? month,
    double? value,
    bool? isHighlighted,
  }) {
    return MonthlyProgressModel(
      month: month ?? this.month,
      value: value ?? this.value,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }
}