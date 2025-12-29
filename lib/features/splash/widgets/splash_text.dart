import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

class SplashText extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const SplashText({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final isTablet = MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 1024;

    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: isMobile ? 32 : (isTablet ? 40 : 48),
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1F2937),
                letterSpacing: -1,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.appTagline,
              style: TextStyle(
                fontSize: isMobile ? 14 : (isTablet ? 16 : 18),
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
