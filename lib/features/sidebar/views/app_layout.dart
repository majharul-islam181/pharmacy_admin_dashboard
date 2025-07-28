import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../header/views/header_view.dart';
import '../../sidebar/views/sidebar_view.dart';
import '../../sidebar/views/mobile_drawer.dart';
import '../view_model/sidebar_view_model.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  
  const AppLayout({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SidebarViewModel()),
      ],
      child: Builder(
        builder: (context) {
          final isDesktop = ResponsiveUtils.isDesktop(context);
          
          if (isDesktop) {
            return _buildDesktopLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Persistent Sidebar
          const SidebarView(),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                const HeaderView(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ResponsiveUtils.getHeaderHeight(context)),
        child: const HeaderView(),
      ),
      drawer: const MobileDrawer(),
      body: child,
    );
  }
}