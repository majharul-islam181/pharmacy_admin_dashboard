import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../view_model/purchase_view_model.dart';

class PurchaseAddView extends StatelessWidget {
  const PurchaseAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PurchaseViewModel(),
      child: const _PurchaseAddViewContent(),
    );
  }
}

class _PurchaseAddViewContent extends StatelessWidget {
  const _PurchaseAddViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PurchaseViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          Row(
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Purchase'),
              ),
              const Text(' > '),
              const Text(
                'Add Purchase',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingMedium),

          const Text(
            'Add New Purchase',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Add Purchase Form
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.05),
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
                      Icons.add_shopping_cart,
                      size: 32,
                      color: AppColors.successDark,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Add New Purchase Order',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Form fields
                _buildFormField(
                  'Supplier Name',
                  'Enter supplier name',
                  viewModel.supplierController,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  'Product',
                  'Enter product name',
                  viewModel.productController,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  'Quantity',
                  'Enter quantity',
                  viewModel.quantityController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                _buildFormField(
                  'Unit Price',
                  'Enter unit price',
                  viewModel.unitPriceController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24),

                // Action buttons
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: viewModel.isLoading
                          ? null
                          : () => _handleSave(context, viewModel),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successDark,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: viewModel.isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.white,
                              ),
                            )
                          : const Text('Save Purchase'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleSave(
    BuildContext context,
    PurchaseViewModel viewModel,
  ) async {
    final supplier = viewModel.supplierController.text.trim();
    final product = viewModel.productController.text.trim();
    final quantityText = viewModel.quantityController.text.trim();
    final priceText = viewModel.unitPriceController.text.trim();

    if (supplier.isEmpty ||
        product.isEmpty ||
        quantityText.isEmpty ||
        priceText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final quantity = int.tryParse(quantityText);
    final price = double.tryParse(priceText);

    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid quantity')),
      );
      return;
    }

    if (price == null || price <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid price')),
      );
      return;
    }

    await viewModel.addPurchase(
      supplierName: supplier,
      productName: product,
      quantity: quantity,
      unitPrice: price,
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Purchase order created successfully')),
      );
      Navigator.of(context).pop();
    }
  }
}
