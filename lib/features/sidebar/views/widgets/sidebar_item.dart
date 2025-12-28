import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/sidebar_item_model.dart';
import '../../view_model/sidebar_view_model.dart';

class SidebarItem extends StatefulWidget {
  final SidebarItemModel item;
  final VoidCallback onTap;
  final VoidCallback? onExpansionToggle;
  final bool isCollapsed;

  const SidebarItem({
    super.key,
    required this.item,
    required this.onTap,
    required this.isCollapsed,
    this.onExpansionToggle,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _expandController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _expandController,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.item.isExpanded) {
      _expandController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(SidebarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.isExpanded != oldWidget.item.isExpanded) {
      if (widget.item.isExpanded) {
        _expandController.forward();
      } else {
        _expandController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item.isSectionHeader) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.paddingMedium,
          AppDimensions.paddingLarge,
          AppDimensions.paddingMedium,
          AppDimensions.paddingSmall,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedOpacity(
            opacity: widget.isCollapsed ? 0 : 1,
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.item.title.toUpperCase(),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              if (widget.item.hasSubItems) {
                widget.onExpansionToggle?.call();
              } else {
                context
                    .read<SidebarViewModel>()
                    .navigateToRoute(context, widget.item.route);
                widget.onTap();
              }
            },
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 200),
              tween: Tween(begin: 0, end: _isHovered ? 1.0 : 0.0),
              builder: (context, hoverValue, child) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingSmall,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    gradient: widget.item.isActive
                        ? LinearGradient(
                            colors: [
                              const Color(0xFF6366F1).withOpacity(0.15),
                              const Color(0xFF8B5CF6).withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: !widget.item.isActive
                        ? AppColors.textSecondary
                            .withOpacity(0.03 + (hoverValue * 0.05))
                        : null,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusMedium),
                    border: widget.item.isActive
                        ? Border.all(
                            color: const Color(0xFF6366F1).withOpacity(0.3),
                            width: 1,
                          )
                        : null,
                    boxShadow: widget.item.isActive
                        ? [
                            BoxShadow(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        // Active indicator bar
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: widget.item.isActive ? 3 : 0,
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        if (widget.item.isActive)
                          const SizedBox(width: 8)
                        else
                          const SizedBox(width: 0),
                        // Icon with scale animation
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 200),
                          tween: Tween(
                            begin: 1.0,
                            end: _isHovered ? 1.1 : 1.0,
                          ),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Icon(
                                widget.item.icon,
                                size: AppDimensions.iconMedium,
                                color: widget.item.isActive
                                    ? const Color(0xFF6366F1)
                                    : AppColors.iconSecondary,
                              ),
                            );
                          },
                        ),
                        if (!widget.isCollapsed) ...[
                          const SizedBox(width: AppDimensions.paddingMedium),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: widget.item.isActive
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: widget.item.isActive
                                    ? const Color(0xFF6366F1)
                                    : AppColors.textSecondary,
                                letterSpacing: 0.2,
                              ),
                              child: Text(widget.item.title),
                            ),
                          ),
                          if (widget.item.hasSubItems)
                            RotationTransition(
                              turns: _rotationAnimation,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: AppDimensions.iconMedium,
                                color: widget.item.isActive
                                    ? const Color(0xFF6366F1)
                                    : AppColors.iconSecondary,
                              ),
                            ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        // Animated sub-items expansion
        if (widget.item.hasSubItems && !widget.isCollapsed)
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              margin: const EdgeInsets.only(left: AppDimensions.paddingSmall),
              padding: const EdgeInsets.only(
                left: 12,
                top: 4,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: const Color(0xFF6366F1).withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
              child: Column(
                children: _buildSubItems(context),
              ),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildSubItems(BuildContext context) {
    if (widget.item.subItems != null && widget.item.subItems!.isNotEmpty) {
      return widget.item.subItems!
          .map((sub) => _buildSubItem(context, sub.title, sub.route))
          .toList();
    }

    return [
      _buildSubItem(
          context, 'Add ${widget.item.title}', '${widget.item.route}/add'),
      _buildSubItem(context, 'Manage ${widget.item.title}',
          '${widget.item.route}/manage'),
      _buildSubItem(
          context, 'View ${widget.item.title}', '${widget.item.route}/view'),
    ];
  }

  Widget _buildSubItem(BuildContext context, String title, String route) {
    return _SubMenuItem(
      title: title,
      route: route,
      onTap: () {
        context.read<SidebarViewModel>().navigateToRoute(context, route);
        widget.onTap();
      },
    );
  }
}

class _SubMenuItem extends StatefulWidget {
  final String title;
  final String route;
  final VoidCallback onTap;

  const _SubMenuItem({
    required this.title,
    required this.route,
    required this.onTap,
  });

  @override
  State<_SubMenuItem> createState() => _SubMenuItemState();
}

class _SubMenuItemState extends State<_SubMenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SidebarViewModel>();
    final isActive = viewModel.activeRoute == widget.route;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 200),
          tween: Tween(begin: 0, end: _isHovered ? 1.0 : 0.0),
          builder: (context, hoverValue, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSmall,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xFF6366F1).withOpacity(0.08)
                    : AppColors.textSecondary
                        .withOpacity(0.02 + (hoverValue * 0.04)),
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: isActive ? 6 : 6,
                      height: isActive ? 6 : 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? const Color(0xFF6366F1)
                            : AppColors.iconSecondary.withOpacity(0.4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight:
                              isActive ? FontWeight.w600 : FontWeight.w400,
                          color: isActive
                              ? const Color(0xFF6366F1)
                              : AppColors.textSecondary,
                          letterSpacing: 0.2,
                        ),
                        child: Text(widget.title),
                      ),
                    ),
                    if (isActive)
                      TweenAnimationBuilder<double>(
                        duration: const Duration(milliseconds: 300),
                        tween: Tween(begin: 0, end: 1),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: value,
                            child: Icon(
                              Icons.check_circle,
                              size: 14,
                              color: const Color(0xFF6366F1).withOpacity(0.8),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
