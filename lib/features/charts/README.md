# 📊 Charts Module Documentation

## Overview

The Charts module is an enterprise-grade data visualization solution built with **Syncfusion Flutter Charts** and **Material Design 3**, providing 30+ advanced chart types with smooth animations, real-time updates, and interactive features.

---

## 🎯 Features

### Chart Categories

1. **Overview** - Dashboard with key metrics and sample charts
2. **Line & Area** - 10 chart variations including spline, step, stacked
3. **Bar & Column** - 8 chart types with gradients and stacking
4. **Financial** - 4 specialized OHLC/Candlestick charts
5. **Circular** - 6 pie, doughnut, funnel, and pyramid charts
6. **Advanced** - 4 specialized charts (scatter, bubble, waterfall, box plot)

### Interactive Features

- ✅ **Zooming** - Pinch and double-tap zoom
- ✅ **Panning** - Drag to pan across data
- ✅ **Tooltips** - Hover/tap for detailed information
- ✅ **Trackball** - Multi-series data tracking
- ✅ **Crosshair** - Precise value identification
- ✅ **Selection** - Highlight and interact with data points
- ✅ **Legend** - Interactive series toggles

### Animation System

- **Initial Load**: 800-1500ms smooth entry animations
- **Data Updates**: 600-1000ms transition animations
- **Easing Curves**: `easeOutCubic`, `easeInOutQuart`
- **Staggered Delays**: Progressive element loading

### Live Data Support

- Real-time data streaming
- Auto-refresh every 2 seconds
- Smooth data point transitions
- Live financial market simulation

---

## 📁 Architecture

```
features/charts/
├── model/
│   └── chart_data_model.dart          # Data models & types
├── view_model/
│   └── chart_view_model.dart          # State management
├── view/
│   ├── charts_overview_view.dart      # Overview dashboard
│   ├── line_area_chart_view.dart      # Line & area charts
│   ├── bar_column_chart_view.dart     # Bar & column charts
│   ├── financial_chart_view.dart      # Financial charts
│   ├── circular_chart_view.dart       # Pie & circular charts
│   └── advanced_chart_view.dart       # Advanced charts
└── widgets/
    ├── animated_chart_container.dart  # Reusable container
    ├── chart_header.dart              # Page headers
    └── chart_legend.dart              # Custom legends
```

---

## 🎨 Chart Types

### Line & Area (10 types)

1. **Line Chart** - Basic line series
2. **Spline Chart** - Smooth curved lines
3. **Step Line Chart** - Stepped line series
4. **Fast Line Chart** - Optimized for large datasets
5. **Area Chart** - Filled area with gradient
6. **Spline Area Chart** - Smooth filled area
7. **Step Area Chart** - Stepped filled area
8. **Stacked Area** - Multi-series stacking
9. **100% Stacked Area** - Percentage-based stacking
10. **Range Area** - High-low range visualization

### Bar & Column (8 types)

1. **Column Chart** - Vertical bars with gradient
2. **Bar Chart** - Horizontal bars
3. **Stacked Column** - Multi-series vertical stacking
4. **100% Stacked Column** - Percentage vertical
5. **Stacked Bar** - Multi-series horizontal
6. **100% Stacked Bar** - Percentage horizontal
7. **Range Column** - High-low vertical
8. **Histogram** - Distribution analysis

### Financial (4 types)

1. **Candlestick Chart** - OHLC with volume
2. **HiLo Chart** - High-low price range
3. **HiLo Open Close** - OHLC bar chart
4. **Candlestick + Volume** - Multi-pane financial

### Circular (6 types)

1. **Pie Chart** - Classic with explosion
2. **Doughnut Chart** - Ring with center text
3. **Radial Bar** - Circular progress bars
4. **Semi-Circular Pie** - Half-pie visualization
5. **Funnel Chart** - Sales funnel
6. **Pyramid Chart** - Hierarchical data

### Advanced (4 types)

1. **Scatter Chart** - Correlation analysis
2. **Bubble Chart** - Multi-dimensional data
3. **Waterfall Chart** - Cumulative effect
4. **Box & Whisker** - Statistical distribution

---

## 💻 Usage Examples

### Basic Line Chart

```dart
SfCartesianChart(
  primaryXAxis: NumericAxis(),
  primaryYAxis: NumericAxis(),
  tooltipBehavior: TooltipBehavior(enable: true),
  zoomPanBehavior: ZoomPanBehavior(
    enablePanning: true,
    enablePinching: true,
  ),
  series: <CartesianSeries>[
    LineSeries<ChartDataPoint, num>(
      dataSource: data,
      xValueMapper: (point, _) => point.x,
      yValueMapper: (point, _) => point.y,
      color: Colors.blue,
      width: 3,
      animationDuration: 1000,
    ),
  ],
)
```

### Financial Candlestick

```dart
SfCartesianChart(
  primaryXAxis: DateTimeAxis(),
  primaryYAxis: NumericAxis(opposedPosition: true),
  trackballBehavior: TrackballBehavior(
    enable: true,
    activationMode: ActivationMode.singleTap,
  ),
  series: <CartesianSeries>[
    CandleSeries<FinancialDataPoint, DateTime>(
      dataSource: financialData,
      xValueMapper: (data, _) => data.date,
      highValueMapper: (data, _) => data.high,
      lowValueMapper: (data, _) => data.low,
      openValueMapper: (data, _) => data.open,
      closeValueMapper: (data, _) => data.close,
      bullColor: Colors.green,
      bearColor: Colors.red,
      enableSolidCandles: true,
      animationDuration: 1200,
    ),
  ],
)
```

### Interactive Pie Chart

```dart
SfCircularChart(
  legend: Legend(isVisible: true, position: LegendPosition.bottom),
  tooltipBehavior: TooltipBehavior(enable: true),
  series: <CircularSeries>[
    PieSeries<ChartDataPoint, String>(
      dataSource: data,
      xValueMapper: (data, _) => data.x,
      yValueMapper: (data, _) => data.y,
      pointColorMapper: (data, _) => data.color,
      explode: true,
      explodeIndex: 0,
      explodeGesture: ActivationMode.singleTap,
      dataLabelSettings: DataLabelSettings(
        isVisible: true,
        labelPosition: ChartDataLabelPosition.outside,
      ),
      animationDuration: 1200,
    ),
  ],
)
```

---

## 🔄 Live Data Integration

### Start Live Updates

```dart
final viewModel = context.read<ChartViewModel>();
viewModel.startLiveData(); // Updates every 2 seconds
```

### Stop Live Updates

```dart
viewModel.stopLiveData();
```

### Manual Refresh

```dart
await viewModel.refreshData();
```

---

## 🎨 Customization

### Chart Container

All charts use `AnimatedChartContainer` with:

- Scale & fade animations (600ms)
- Refresh button
- Title & subtitle
- Custom actions
- Material 3 styling

### Color Schemes

Charts automatically adapt to:

- Light/Dark themes
- Material 3 color system
- Custom gradients
- Accessibility standards

### Responsive Behavior

- **Mobile**: 1 column, compact legends
- **Tablet**: 2 columns, larger charts
- **Desktop**: 2-3 columns, full features

---

## ⚙️ State Management

### ChartViewModel

```dart
class ChartViewModel extends ChangeNotifier {
  // Data generators
  void _generateLineChartData();
  void _generateFinancialData();
  void _generatePieChartData();

  // Live updates
  void startLiveData();
  void stopLiveData();

  // Refresh
  Future<void> refreshData();
}
```

### Provider Integration

```dart
ChangeNotifierProvider(
  create: (_) => ChartViewModel(),
  child: const ChartsOverviewView(),
)
```

---

## 🚀 Performance

### Optimization Techniques

1. **Fast Line Series** - For 10,000+ data points
2. **Lazy Loading** - Load views on demand
3. **Animation Delays** - Staggered rendering
4. **Memory Management** - Efficient data structures
5. **Timer Disposal** - Clean live data streams

### Best Practices

- Use `FastLineSeries` for large datasets
- Implement pagination for historical data
- Debounce live updates (2+ seconds)
- Dispose timers properly
- Cache computed values

---

## 📱 Navigation

### Sidebar Menu

```
📊 Charts
   ├─ Overview
   ├─ Line & Area
   ├─ Bar & Column
   ├─ Financial Charts
   ├─ Pie & Circular
   └─ Advanced Charts
```

### Routes

```dart
AppRoutes.chartsOverview      // /charts/overview
AppRoutes.chartsLineArea      // /charts/line-area
AppRoutes.chartsBarColumn     // /charts/bar-column
AppRoutes.chartsFinancial     // /charts/financial
AppRoutes.chartsCircular      // /charts/circular
AppRoutes.chartsAdvanced      // /charts/advanced
```

---

## 🎓 Learning Resources

### Syncfusion Documentation

- [Flutter Charts User Guide](https://help.syncfusion.com/flutter/cartesian-charts/overview)
- [Chart API Reference](https://pub.dev/documentation/syncfusion_flutter_charts/latest/)
- [Chart Customization](https://help.syncfusion.com/flutter/cartesian-charts/chart-title)

### Material Design 3

- [Data Visualization Guidelines](https://m3.material.io/foundations/data-visualization)
- [Color System](https://m3.material.io/styles/color/overview)
- [Motion & Animation](https://m3.material.io/styles/motion/overview)

---

## 🐛 Troubleshooting

### Common Issues

**Issue**: Charts not rendering

- **Solution**: Ensure data is not null/empty
- Check parent widget constraints

**Issue**: Animations stuttering

- **Solution**: Reduce animation duration
- Use `FastLineSeries` for large data

**Issue**: Live data memory leak

- **Solution**: Call `stopLiveData()` before dispose
- Always dispose timers properly

---

## 📈 Future Enhancements

- [ ] Export charts as PNG/PDF
- [ ] Custom color themes
- [ ] More financial indicators
- [ ] 3D charts
- [ ] Polar/Radar charts
- [ ] Heat maps
- [ ] Gantt charts
- [ ] Network graphs
- [ ] Treemaps
- [ ] Calendar charts

---

## 📄 License

This module follows the project's main license. Syncfusion charts require a [community license](https://www.syncfusion.com/sales/communitylicense) for free usage.

---

## 🤝 Contributing

To add new chart types:

1. Add data model in `chart_data_model.dart`
2. Create generator in `ChartViewModel`
3. Build view in appropriate view file
4. Use `AnimatedChartContainer` wrapper
5. Test with live data
6. Update documentation

---

**Built with ❤️ using Flutter & Syncfusion Charts**
