import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

class WidgetsBadgePage extends StatelessWidget {
  const WidgetsBadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildTemplate(
        title: 'Badges',
        icon: Icons.verified_outlined,
        description:
            'Display status, notification, and label badges in different styles.',
      ),
    );
  }

  Widget _buildTemplate({
    required String title,
    required IconData icon,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
