import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view/purchase_manage_view.dart';

class PurchaseManagePage extends StatelessWidget {
  const PurchaseManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PurchaseManageView();
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
                'Manage Purchase',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingMedium),

          const Text(
            'Manage Purchases',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Purchase List
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
                const Row(
                  children: [
                    Icon(
                      Icons.manage_search,
                      size: 32,
                      color: Color(0xFF3B82F6),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Purchase Orders Management',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Sample purchase list
                _buildPurchaseItem(
                    'PO-001', 'Supplier ABC', '\$1,200.00', 'Pending'),
                _buildPurchaseItem(
                    'PO-002', 'Supplier XYZ', '\$850.00', 'Completed'),
                _buildPurchaseItem(
                    'PO-003', 'Supplier DEF', '\$2,100.00', 'In Progress'),
              ],
            ),
          ),
        ],
      ),
     ) );
  }

  Widget _buildPurchaseItem(
      String id, String supplier, String amount, String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = const Color(0xFF10B981);
        break;
      case 'in progress':
        statusColor = const Color(0xFFF59E0B);
        break;
      default:
        statusColor = const Color(0xFF6B7280);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              id,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(supplier),
          ),
          Expanded(
            flex: 2,
            child: Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
