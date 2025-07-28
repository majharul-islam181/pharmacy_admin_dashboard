import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

import '../../../../core/utils/responsive_utils.dart';


class CustomSearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const CustomSearchBar({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final searchWidth = ResponsiveUtils.getSearchBarWidth(context);
    
    // Don't show search bar on mobile
    if (ResponsiveUtils.isMobile(context)) {
      return const SizedBox.shrink();
    }
    
    return InkWell(
      onTap: onTap,
      child: Container(
        height: ResponsiveUtils.isTablet(context) ? 36 : 40,
        width: searchWidth,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const SizedBox(width: AppDimensions.paddingMedium),
            const Icon(
              Icons.search,
              size: AppDimensions.iconMedium,
              color: AppColors.iconSecondary,
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(
                  color: AppColors.textHint,
                  fontSize: ResponsiveUtils.isTablet(context) ? 13 : 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
