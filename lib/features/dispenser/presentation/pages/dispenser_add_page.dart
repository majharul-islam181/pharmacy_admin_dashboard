import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class DispenserAddPage extends StatelessWidget {
  const DispenserAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Dispenser'),
              ),
              const Text(' > '),
              const Text(
                'Add Dispenser',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const Text(
            'Add New Dispenser',
            style: TextStyle(
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
            child: const Column(
              children: [
                Icon(
                  Icons.local_drink_outlined,
                  size: 64,
                  color: Color(0xFF06B6D4),
                ),
                SizedBox(height: 16),
                Text(
                  'Add New Dispenser',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Configure a new dispenser unit for your system.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
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
