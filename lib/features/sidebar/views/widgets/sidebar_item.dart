import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/sidebar_item_model.dart';
import '../../view_model/sidebar_view_model.dart';

class SidebarItem extends StatelessWidget {
  final SidebarItemModel item;
  final VoidCallback onTap;
  final VoidCallback? onExpansionToggle;

  const SidebarItem({
    super.key,
    required this.item,
    required this.onTap,
    this.onExpansionToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (item.hasSubItems) {
              onExpansionToggle?.call();
            } else {
              // Navigate to the page using go_router via SidebarViewModel
              context
                  .read<SidebarViewModel>()
                  .navigateToRoute(context, item.route);
              onTap();
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSmall,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: item.isActive
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
                vertical: AppDimensions.paddingMedium,
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    size: AppDimensions.iconMedium,
                    color: item.isActive
                        ? AppColors.primary
                        : AppColors.iconSecondary,
                  ),
                  const SizedBox(width: AppDimensions.paddingMedium),
                  Expanded(
                    child: Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight:
                            item.isActive ? FontWeight.w600 : FontWeight.w400,
                        color: item.isActive
                            ? AppColors.primary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  if (item.hasSubItems)
                    Icon(
                      item.isExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      size: AppDimensions.iconMedium,
                      color: AppColors.iconSecondary,
                    ),
                ],
              ),
            ),
          ),
        ),
        // Sub-items for expandable items
        if (item.hasSubItems && item.isExpanded)
          Container(
            margin: const EdgeInsets.only(left: AppDimensions.paddingLarge),
            child: Column(
              children: [
                _buildSubItem(
                    context, 'Add ${item.title}', '${item.route}/add'),
                _buildSubItem(
                    context, 'Manage ${item.title}', '${item.route}/manage'),
                _buildSubItem(
                    context, 'View ${item.title}', '${item.route}/view'),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildSubItem(BuildContext context, String title, String route) {
    return InkWell(
      onTap: () {
        context.read<SidebarViewModel>().navigateToRoute(context, route);
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
          vertical: 1,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall,
          ),
          child: Row(
            children: [
              const SizedBox(width: AppDimensions.paddingMedium),
              const Icon(
                Icons.circle,
                size: 6,
                color: AppColors.iconSecondary,
              ),
              const SizedBox(width: AppDimensions.paddingMedium),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
