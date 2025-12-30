import 'package:flutter/material.dart';

class AnimatedChartContainer extends StatefulWidget {
  final Widget child;
  final String title;
  final String? subtitle;
  final VoidCallback? onRefresh;
  final List<Widget>? actions;

  const AnimatedChartContainer({
    super.key,
    required this.child,
    required this.title,
    this.subtitle,
    this.onRefresh,
    this.actions,
  });

  @override
  State<AnimatedChartContainer> createState() => _AnimatedChartContainerState();
}

class _AnimatedChartContainerState extends State<AnimatedChartContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (widget.subtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              widget.subtitle!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (widget.actions != null) ...widget.actions!,
                    if (widget.onRefresh != null)
                      IconButton(
                        icon: const Icon(Icons.refresh_rounded),
                        onPressed: widget.onRefresh,
                        tooltip: 'Refresh',
                      ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Chart content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
