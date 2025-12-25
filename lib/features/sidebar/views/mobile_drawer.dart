import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../view_model/sidebar_view_model.dart';
import 'widgets/sidebar_header.dart';
import 'widgets/sidebar_item.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Column(
        children: [
          // Custom header instead of DrawerHeader
          const SidebarHeader(),

          Expanded(
            child: Consumer<SidebarViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: viewModel.sidebarItems.length,
                  itemBuilder: (context, index) {
                    final item = viewModel.sidebarItems[index];
                    return SidebarItem(
                      item: item,
                      onTap: () {
                        Navigator.of(context)
                            .pop(); // Close drawer after navigation
                      },
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
