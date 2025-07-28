import 'package:flutter/material.dart';
import '../core/utils/responsive_utils.dart';
import '../features/header/views/header_view.dart';
import '../features/sidebar/views/sidebar_view.dart';
import '../features/sidebar/views/mobile_drawer.dart';
import 'content_area_view.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveUtils.isDesktop(context);
    
    if (isDesktop) {
      return _buildDesktopLayout();
    } else {
      return _buildMobileLayout(context);
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar (Fixed)
          const SidebarView(width: 280),
          
          // Right Content Area
          Expanded(
            child: Column(
              children: [
                // Header at top
                const HeaderView(),
                
                // Dynamic Content Area
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFF8F9FA),
                    child: const ContentAreaView(),
                  ),
                ),
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
      backgroundColor: const Color(0xFFF8F9FA),
      body: const ContentAreaView(),
    );
  }
}
