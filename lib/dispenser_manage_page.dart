import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';

class DispenserManagePage extends StatelessWidget {
  const DispenserManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Dispenser'),
              ),
              const Text(' > '),
              const Text(
                'Manage Dispenser',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          
          const Text(
            'Manage Dispensers',
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
                  Icons.settings,
                  size: 64,
                  color: Color(0xFF8B5CF6),
                ),
                SizedBox(height: 16),
                Text(
                  'Dispenser Management',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Monitor and control all dispenser units.',
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