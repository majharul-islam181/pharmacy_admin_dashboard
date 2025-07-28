import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/view_model/dashboard_stats_view_model.dart';
import 'features/header/view_model/header_view_model.dart';
import 'features/navigation/view_model/navigation_view_model.dart';
import 'features/sidebar/view_model/sidebar_view_model.dart';
import 'main_layout_view.dart';

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
        ChangeNotifierProvider(create: (_) => NavigationViewModel()),
      ],
      child: MaterialApp(
        title: 'Admin Dashboard',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const MainLayoutView(),
      ),
    );
  }
}
