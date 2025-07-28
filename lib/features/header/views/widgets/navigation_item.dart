import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../model/navigation_item_model.dart';

class NavigationItem extends StatelessWidget {
  final NavigationItemModel item;
  final VoidCallback onTap;
  final bool showText;

  const NavigationItem({
    super.key,
    required this.item,
    required this.onTap,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowText = showText && ResponsiveUtils.shouldShowNavigationText(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: shouldShowText ? AppDimensions.paddingMedium : AppDimensions.paddingSmall,
          vertical: AppDimensions.paddingSmall,
        ),
        constraints: const BoxConstraints(
          minWidth: 40,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              size: AppDimensions.iconMedium,
              color: item.isActive ? AppColors.primary : AppColors.iconSecondary,
            ),
            if (shouldShowText) ...[
              const SizedBox(width: AppDimensions.paddingSmall),
              Flexible(
                child: Text(
                  item.title,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.isTablet(context) ? 13 : 14,
                    fontWeight: item.isActive ? FontWeight.w600 : FontWeight.w400,
                    color: item.isActive ? AppColors.primary : AppColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
