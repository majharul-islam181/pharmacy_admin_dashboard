import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view/purchase_view_view.dart';

class PurchaseViewPage extends StatelessWidget {
  const PurchaseViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PurchaseViewView();
  }
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Purchase'),
              ),
              const Text(' > '),
              const Text(
                'View Purchase',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingMedium),

          const Text(
            'Purchase Reports & Analytics',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Statistics Cards Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                    'Total Orders', '45', const Color(0xFF3B82F6)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard('Pending', '12', const Color(0xFFF59E0B)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child:
                    _buildStatCard('Completed', '28', const Color(0xFF10B981)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                    'Total Value', '\$45,680', const Color(0xFF8B5CF6)),
              ),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

