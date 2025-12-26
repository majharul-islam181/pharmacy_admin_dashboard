import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class ProductManagePage extends StatelessWidget {
  const ProductManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Products'),
                ),
                const Text(' > '),
                const Text(
                  'Manage Products',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const Text(
              'Product List',
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
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusLarge),
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
                  const Row(
                    children: [
                      Icon(
                        Icons.list_alt_outlined,
                        size: 32,
                        color: Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'All Products',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildHeaderRow(),
                  const Divider(height: 16),
                  _buildProductRow('PR-001', 'Paracetamol 500mg', 'Tablet', 120,
                      1.25, 'Active'),
                  _buildProductRow('PR-002', 'Cough Syrup 100ml', 'Syrup', 80,
                      3.50, 'Low Stock'),
                  _buildProductRow('PR-003', 'Vitamin C 1000mg', 'Tablet', 200,
                      0.90, 'Active'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildHeaderRow() {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Code',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            'Product Name',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'Category',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Stock',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            'Status',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }

  static Widget _buildProductRow(String code, String name, String category,
      int stock, double price, String status) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = const Color(0xFF10B981);
        break;
      case 'low stock':
        statusColor = const Color(0xFFF59E0B);
        break;
      default:
        statusColor = const Color(0xFF6B7280);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              code,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(name),
          ),
          Expanded(
            flex: 3,
            child: Text(category),
          ),
          Expanded(
            flex: 2,
            child: Text('$stock'),
          ),
          Expanded(
            flex: 2,
            child: Text('$price'),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: statusColor,
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
}
