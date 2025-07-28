import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive_utils.dart';
import '../view_model/header_view_model.dart';
import 'widgets/app_logo.dart';
import 'widgets/navigation_item.dart';
import 'widgets/profile_avatar.dart';
import 'widgets/notification_icon.dart';
import 'widgets/search_bar.dart';


class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeaderViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          height: ResponsiveUtils.getHeaderHeight(context),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              bottom: BorderSide(
                color: AppColors.border,
                width: 1,
              ),
            ),
          ),
          child: Padding(
            padding: ResponsiveUtils.getHeaderPadding(context),
            child: _buildResponsiveHeader(context, viewModel),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveHeader(BuildContext context, HeaderViewModel viewModel) {
    if (ResponsiveUtils.isMobile(context)) {
      return _buildMobileHeader(viewModel);
    } else if (ResponsiveUtils.isTablet(context)) {
      return _buildTabletHeader(viewModel);
    } else {
      return _buildDesktopHeader(viewModel);
    }
  }

  Widget _buildDesktopHeader(HeaderViewModel viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final visibleItems = ResponsiveUtils.getVisibleNavigationItems(context);
        
        return Row(
          children: [
            // Logo
            const AppLogo(),
            
            const SizedBox(width: AppDimensions.paddingLarge),
            
            // Navigation Items - Flexible to prevent overflow
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: viewModel.navigationItems
                      .take(visibleItems)
                      .map((item) => NavigationItem(
                            item: item,
                            onTap: () => viewModel.navigateToRoute(item.route),
                          ))
                      .toList(),
                ),
              ),
            ),
            
            // Right side actions
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Search Bar - Flexible width
                  Flexible(
                    child: CustomSearchBar(
                      onTap: viewModel.openSearch,
                    ),
                  ),
                  
                  const SizedBox(width: AppDimensions.paddingMedium),
                  
                  // Notifications
                  NotificationIcon(
                    count: viewModel.currentUser.notificationCount,
                    onTap: viewModel.openNotifications,
                  ),
                  
                  const SizedBox(width: AppDimensions.paddingSmall),
                  
                  // Profile
                  ProfileAvatar(
                    user: viewModel.currentUser,
                    onTap: viewModel.toggleProfileMenu,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabletHeader(HeaderViewModel viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final visibleItems = ResponsiveUtils.getVisibleNavigationItems(context);
        
        return Row(
          children: [
            // Logo
            const AppLogo(),
            
            const SizedBox(width: AppDimensions.paddingMedium),
            
            // Navigation Items - Compact
            if (visibleItems > 0)
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: viewModel.navigationItems
                        .take(visibleItems)
                        .map((item) => NavigationItem(
                              item: item,
                              onTap: () => viewModel.navigateToRoute(item.route),
                            ))
                        .toList(),
                  ),
                ),
              ),
            
            // Spacer
            const Spacer(),
            
            // Right side actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search Bar
                CustomSearchBar(
                  onTap: viewModel.openSearch,
                ),
                
                const SizedBox(width: AppDimensions.paddingSmall),
                
                // Notifications
                NotificationIcon(
                  count: viewModel.currentUser.notificationCount,
                  onTap: viewModel.openNotifications,
                ),
                
                // Profile
                ProfileAvatar(
                  user: viewModel.currentUser,
                  onTap: viewModel.toggleProfileMenu,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMobileHeader(HeaderViewModel viewModel) {
    return Row(
      children: [
        // Logo
        const AppLogo(),
        
        const Spacer(),
        
        // Right side actions - Compact
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Icon
            IconButton(
              onPressed: viewModel.openSearch,
              icon: const Icon(
                Icons.search,
                size: AppDimensions.iconLarge,
                color: AppColors.iconPrimary,
              ),
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
            ),
            
            // Notifications
            NotificationIcon(
              count: viewModel.currentUser.notificationCount,
              onTap: viewModel.openNotifications,
            ),
            
            // Profile
            ProfileAvatar(
              user: viewModel.currentUser,
              onTap: viewModel.toggleProfileMenu,
            ),
          ],
        ),
      ],
    );
  }
}
