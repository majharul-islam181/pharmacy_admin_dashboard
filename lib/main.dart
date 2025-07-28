import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/header/view_model/header_view_model.dart';
import 'features/sidebar/views/app_layout.dart';

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
      ],
      child: MaterialApp(
        title: 'Admin Dashboard',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      child: Center(
        child: Text(
          'Dashboard Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}