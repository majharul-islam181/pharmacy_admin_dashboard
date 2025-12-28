import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Centralized page transition animations for consistent UX across the app
/// Following Material 3 motion principles with smooth, subtle animations
class PageTransitions {
  /// Standard fade + slide transition for page navigation
  /// Duration: 400ms for buttery smooth feel
  /// Direction: Subtle horizontal slide (right to left)
  static CustomTransitionPage<T> fadeSlide<T>({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Primary animation: fade + slide from right
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Material ease out
          reverseCurve: const Cubic(0.4, 0.0, 1.0, 1.0), // Material ease in
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.015, 0), // Ultra subtle 1.5% horizontal slide
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Smooth deceleration
        ));

        // Secondary animation: slide out current page
        final secondarySlideAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.01, 0), // Very subtle slide left
        ).animate(CurvedAnimation(
          parent: secondaryAnimation,
          curve: const Cubic(0.4, 0.0, 0.6, 1.0),
        ));

        return SlideTransition(
          position: secondarySlideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          ),
        );
      },
    );
  }

  /// Fade-only transition for subtle page changes
  /// Best for related content or dashboard navigation
  static CustomTransitionPage<T> fade<T>({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Smooth ease out
          reverseCurve: const Cubic(0.4, 0.0, 1.0, 1.0),
        );

        return FadeTransition(
          opacity: fadeAnimation,
          child: child,
        );
      },
    );
  }

  /// Scale + fade transition for modal-like pages
  /// Creates a gentle "pop in" effect
  static CustomTransitionPage<T> scaleFade<T>({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 450),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Smooth deceleration
          reverseCurve: const Cubic(0.4, 0.0, 1.0, 1.0),
        );

        final scaleAnimation = Tween<double>(
          begin: 0.97, // More subtle scale
          end: 1.0,
        ).animate(curvedAnimation);

        return ScaleTransition(
          scale: scaleAnimation,
          child: FadeTransition(
            opacity: curvedAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Vertical slide + fade for child pages
  /// Best for forms, add/edit pages, detail views
  static CustomTransitionPage<T> verticalSlide<T>({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Smooth ease
          reverseCurve: const Cubic(0.4, 0.0, 1.0, 1.0),
        );

        final slideAnimation = Tween<Offset>(
          begin: const Offset(0, 0.02), // Very subtle 2% vertical slide
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0),
        ));

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// Mobile-optimized slide transition
  /// Stronger slide effect for mobile devices
  static CustomTransitionPage<T> mobileSlide<T>({
    required Widget child,
    required GoRouterState state,
    Duration duration = const Duration(milliseconds: 400),
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final isMobile = MediaQuery.of(context).size.width < 600;

        final slideAnimation = Tween<Offset>(
          begin: Offset(isMobile ? 0.08 : 0.02, 0), // Smoother on both
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.4, 0.0, 0.2, 1.0), // Material ease
        ));

        final fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: const Cubic(0.0, 0.0, 0.2, 1.0), // Fast start, smooth end
        );

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: child,
          ),
        );
      },
    );
  }

  /// No animation - instant page change
  /// Use sparingly for same-context updates
  static CustomTransitionPage<T> noTransition<T>({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  /// Responsive transition selector
  /// Automatically chooses best transition based on screen size
  static CustomTransitionPage<T> adaptive<T>({
    required Widget child,
    required GoRouterState state,
    required BuildContext context,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width < 600) {
      // Mobile: stronger slide
      return mobileSlide(child: child, state: state);
    } else if (width < 1200) {
      // Tablet: standard fade + slide
      return fadeSlide(
        child: child,
        state: state,
        duration: const Duration(milliseconds: 400),
      );
    } else {
      // Desktop: subtle fade
      return fade(
        child: child,
        state: state,
        duration: const Duration(milliseconds: 350),
      );
    }
  }
}
