import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/theme/theme_provider.dart';
import '../view_model/header_view_model.dart';
import 'widgets/app_logo.dart';
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

  Widget _buildResponsiveHeader(
      BuildContext context, HeaderViewModel viewModel) {
    if (ResponsiveUtils.isMobile(context)) {
      return _buildMobileHeader(context, viewModel);
    } else if (ResponsiveUtils.isTablet(context)) {
      return _buildTabletHeader(context, viewModel);
    } else {
      return _buildDesktopHeader(context, viewModel);
    }
  }

  Widget _buildDesktopHeader(BuildContext context, HeaderViewModel viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // Logo
            const AppLogo(),

            const Spacer(),

            // Right side actions
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Search Bar - Flexible width
                SizedBox(
                  width: 260,
                  child: CustomSearchBar(
                    onTap: viewModel.openSearch,
                  ),
                ),

                const SizedBox(width: AppDimensions.paddingMedium),

                // Theme toggle
                const _ThemeToggleButton(),

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
          ],
        );
      },
    );
  }

  Widget _buildTabletHeader(BuildContext context, HeaderViewModel viewModel) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            // Logo
            const AppLogo(),

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

                // Theme toggle
                const _ThemeToggleButton(),

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

  Widget _buildMobileHeader(BuildContext context, HeaderViewModel viewModel) {
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

            // Theme toggle
            const _ThemeToggleButton(),

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

class _ThemeToggleButton extends StatelessWidget {
  const _ThemeToggleButton();

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return IconButton(
      tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      icon: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        size: AppDimensions.iconMedium,
        color: AppColors.iconPrimary,
      ),
      onPressed: themeProvider.toggleTheme,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
    );
  }
}
