import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../view_model/sidebar_view_model.dart';
import 'widgets/sidebar_header.dart';
import 'widgets/sidebar_item.dart';

class SidebarView extends StatelessWidget {
  final double width;
  
  const SidebarView({
    super.key,
    this.width = 280,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          right: BorderSide(
            color: AppColors.border,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          const SidebarHeader(),
          Expanded(
            child: Consumer<SidebarViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                  ),
                  itemCount: viewModel.sidebarItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.sidebarItems[index];
                    return SidebarItem(
                      item: item,
                      onTap: () => viewModel.navigateToRoute(item.route),
                      onExpansionToggle: item.hasSubItems 
                          ? () => viewModel.toggleExpansion(item.id)
                          : null,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
