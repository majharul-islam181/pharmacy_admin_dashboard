import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/language_provider.dart';
import 'core/localization/locale_service.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/dashboard/view_models/dashboard_stats_view_model.dart';
import 'features/header/view_model/header_view_model.dart';
import 'features/sidebar/view_model/sidebar_view_model.dart';
import 'features/products/view_model/product_images_provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//    // Initialize web plugin if running on web
//   // if (kIsWeb) {
//   //   SharedPreferencesPlugin.registerWith();
//   // }
//   await EasyLocalization.ensureInitialized();

//   runApp(
//     EasyLocalization(
//       supportedLocales: LocaleService.supportedLocales,
//       path: 'assets/translations',
//       fallbackLocale: LocaleService.fallbackLocale,
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => HeaderViewModel()),
//         ChangeNotifierProvider(create: (_) => SidebarViewModel()),
//         ChangeNotifierProvider(create: (_) => DashboardStatsViewModel()),
//         ChangeNotifierProvider(create: (_) => NavigationViewModel()),
//       ],
//       child: MaterialApp(
//         title: 'app_title'.tr(),
//         theme: AppTheme.lightTheme,
//         debugShowCheckedModeBanner: false,
//         localizationsDelegates: context.localizationDelegates,
//         supportedLocales: context.supportedLocales,
//         locale: context.locale,
//         home: const MainLayoutView(),
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: LocaleService.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: LocaleService.fallbackLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HeaderViewModel()),
        ChangeNotifierProvider(create: (_) => SidebarViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardStatsViewModel()),
        ChangeNotifierProvider(create: (_) => ProductImagesProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          final themeProvider = context.watch<ThemeProvider>();
          return MaterialApp.router(
            title: 'app_title'.tr(),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
