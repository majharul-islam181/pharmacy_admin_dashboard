import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimensions.dart';

class ProductAddPage extends StatelessWidget {
  const ProductAddPage({super.key});

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
                  onPressed: () {
                    // TODO: Navigate back to product main page
                  },
                  child: const Text('Products'),
                ),
                const Text(' > '),
                const Text(
                  'Add Product',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            const Text(
              'Add New Product',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 32,
                        color: Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFormField('Product Name', 'Enter product name'),
                  const SizedBox(height: 16),
                  _buildFormField('Category', 'Select category'),
                  const SizedBox(height: 16),
                  _buildFormField('SKU', 'Enter SKU'),
                  const SizedBox(height: 16),
                  _buildFormField('Unit Price', 'Enter unit price'),
                  const SizedBox(height: 16),
                  _buildFormField('Stock Quantity', 'Enter available quantity'),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Save product
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF10B981),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Save Product',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Reset form / navigate back
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildFormField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
