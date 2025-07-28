// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../core/utils/responsive_utils.dart';
// import '../../dashboard/view_model/dashboard_stats_view_model.dart';
// import '../../header/views/header_view.dart';
// import '../../sidebar/view_model/sidebar_view_model.dart';
// import '../../sidebar/views/sidebar_view.dart';
// import '../../sidebar/views/mobile_drawer.dart';
// import '../../dashboard/views/dashboard_stats_view.dart';

// class AppLayout extends StatelessWidget {
//   final Widget? child;
  
//   const AppLayout({
//     super.key,
//     this.child,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => SidebarViewModel()),
//         ChangeNotifierProvider(create: (_) => DashboardStatsViewModel()),
//       ],
//       child: Builder(
//         builder: (context) {
//           final isDesktop = ResponsiveUtils.isDesktop(context);
          
//           if (isDesktop) {
//             return _buildDesktopLayout(context);
//           } else {
//             return _buildMobileLayout(context);
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildDesktopLayout(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Persistent Sidebar
//           const SidebarView(),
          
//           // Main Content
//           Expanded(
//             child: Column(
//               children: [
//                 const HeaderView(),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Stats Cards
//                         const DashboardStatsView(),
                        
//                         // Additional content
//                         if (child != null) child!,
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMobileLayout(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(ResponsiveUtils.getHeaderHeight(context)),
//         child: const HeaderView(),
//       ),
//       drawer: const MobileDrawer(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Stats Cards
//             const DashboardStatsView(),
            
//             // Additional content  
//             if (child != null) child!,
//           ],
//         ),
//       ),
//     );
//   }
// }
