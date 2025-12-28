import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../view_model/sidebar_view_model.dart';
import 'widgets/sidebar_header.dart';
import 'widgets/sidebar_item.dart';

// class SidebarView extends StatelessWidget {
//   final double width;

//   const SidebarView({
//     super.key,
//     this.width = 280,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: double.infinity,
//       decoration: const BoxDecoration(
//         color: AppColors.surface,
//         border: Border(
//           right: BorderSide(
//             color: AppColors.border,
//             width: 1,
//           ),
//         ),
//       ),
//       child: Column(
//         children: [
//           const SidebarHeader(),
//           Expanded(
//             child: Consumer<SidebarViewModel>(
//               builder: (context, viewModel, child) {
//                 return ListView.builder(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: AppDimensions.paddingMedium,
//                   ),
//                   itemCount: viewModel.sidebarItems.length,
//                   itemBuilder: (context, index) {
//                     final item = viewModel.sidebarItems[index];
//                     return SidebarItem(
//                       item: item,
//                       onTap: () => viewModel.navigateToRoute(item.route),
//                       onExpansionToggle: item.hasSubItems
//                           ? () => viewModel.toggleExpansion(item.id)
//                           : null,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class SidebarView extends StatelessWidget {
  final double width;

  const SidebarView({
    super.key,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SidebarViewModel>(
      builder: (context, viewModel, child) {
        final isCollapsed = viewModel.isCollapsed;
        final sidebarWidth = isCollapsed ? 80.0 : width;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: sidebarWidth,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              right: BorderSide(
                color: AppColors.border.withOpacity(0.5),
                width: 1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(2, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              SidebarHeader(isCollapsed: isCollapsed),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                  ),
                  itemCount: viewModel.sidebarItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.sidebarItems[index];
                    return TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 30)),
                      tween: Tween(begin: 0, end: 1),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 10 * (1 - value)),
                            child: SidebarItem(
                              item: item,
                              isCollapsed: isCollapsed,
                              onTap: () {},
                              onExpansionToggle: item.hasSubItems
                                  ? () => viewModel.toggleExpansion(item.id)
                                  : null,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
