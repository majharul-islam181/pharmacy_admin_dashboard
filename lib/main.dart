import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/view_model/dashboard_stats_view_model.dart';
import 'features/dashboard/views/complete_dashboard_view.dart';
import 'features/header/view_model/header_view_model.dart';
import 'features/sidebar/view_model/sidebar_view_model.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeaderViewModel()),
        ChangeNotifierProvider(create: (_) => SidebarViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardStatsViewModel()),
      ],
      child: MaterialApp(
        title: 'Admin Dashboard',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const CompleteDashboardView(),
      ),
    );
  }
}