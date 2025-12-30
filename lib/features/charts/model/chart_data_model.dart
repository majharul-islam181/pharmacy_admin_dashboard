import 'package:flutter/material.dart';

/// Base chart data model
class ChartDataPoint {
  final dynamic x;
  final double y;
  final String? label;
  final Color? color;
  final double? size;

  ChartDataPoint({
    required this.x,
    required this.y,
    this.label,
    this.color,
    this.size,
  });
}

/// Multi-series chart data
class ChartSeries {
  final String name;
  final List<ChartDataPoint> data;
  final Color color;
  final bool isVisible;

  ChartSeries({
    required this.name,
    required this.data,
    required this.color,
    this.isVisible = true,
  });
}

/// Financial chart data (OHLC, Candle)
class FinancialDataPoint {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  FinancialDataPoint({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    this.volume = 0,
  });
}

/// Bubble chart data
class BubbleDataPoint {
  final double x;
  final double y;
  final double size;
  final String? label;
  final Color? color;

  BubbleDataPoint({
    required this.x,
    required this.y,
    required this.size,
    this.label,
    this.color,
  });
}

/// Range chart data
class RangeDataPoint {
  final dynamic x;
  final double high;
  final double low;
  final String? label;

  RangeDataPoint({
    required this.x,
    required this.high,
    required this.low,
    this.label,
  });
}

/// Box plot data
class BoxPlotDataPoint {
  final dynamic x;
  final double minimum;
  final double maximum;
  final double median;
  final double lowerQuartile;
  final double upperQuartile;
  final List<double>? outliers;

  BoxPlotDataPoint({
    required this.x,
    required this.minimum,
    required this.maximum,
    required this.median,
    required this.lowerQuartile,
    required this.upperQuartile,
    this.outliers,
  });
}

/// Chart configuration
class ChartConfig {
  final String title;
  final String? subtitle;
  final bool showLegend;
  final bool showGrid;
  final bool enableZoom;
  final bool enablePan;
  final bool showTooltip;
  final bool showCrosshair;
  final bool showTrackball;
  final Duration animationDuration;
  final Curve animationCurve;

  ChartConfig({
    this.title = '',
    this.subtitle,
    this.showLegend = true,
    this.showGrid = true,
    this.enableZoom = true,
    this.enablePan = true,
    this.showTooltip = true,
    this.showCrosshair = false,
    this.showTrackball = false,
    this.animationDuration = const Duration(milliseconds: 800),
    this.animationCurve = Curves.easeOutCubic,
  });
}

/// Chart type enum
enum ChartType {
  // Cartesian
  line,
  spline,
  fastLine,
  stepLine,
  area,
  splineArea,
  stepArea,
  stackedArea,
  stackedArea100,
  rangeArea,

  // Column & Bar
  column,
  bar,
  stackedColumn,
  stackedColumn100,
  stackedBar,
  stackedBar100,
  rangeColumn,

  // Scatter & Bubble
  scatter,
  bubble,

  // Financial
  candle,
  hilo,
  hiloOpenClose,

  // Waterfall & Histogram
  waterfall,
  histogram,

  // Circular
  pie,
  doughnut,
  radialBar,

  // Funnel & Pyramid
  funnel,
  pyramid,
}

/// Chart category for navigation
enum ChartCategory {
  overview,
  lineArea,
  barColumn,
  financial,
  circular,
  advanced,
}
