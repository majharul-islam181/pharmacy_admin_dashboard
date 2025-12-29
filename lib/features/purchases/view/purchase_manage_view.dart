import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../view_model/purchase_view_model.dart';
import '../model/purchase_model.dart';

class PurchaseManageView extends StatelessWidget {
  const PurchaseManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PurchaseViewModel(),
      child: const _PurchaseManageViewContent(),
    );
  }
}

class _PurchaseManageViewContent extends StatelessWidget {
  const _PurchaseManageViewContent();

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
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Search and Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: viewModel.searchPurchases,
                  decoration: InputDecoration(
                    hintText: 'Search purchases...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              DropdownButton<PurchaseStatus?>(
                value: viewModel.filterStatus,
                hint: const Text('Filter by status'),
                items: [
                  const DropdownMenuItem(value: null, child: Text('All')),
                  ...PurchaseStatus.values.map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.displayName),
                      )),
                ],
                onChanged: viewModel.setFilterStatus,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingLarge),

          // Purchase List
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
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.manage_search,
                      size: 32,
                      color: AppColors.infoDark,
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
                if (viewModel.filteredPurchases.isEmpty)
                  const Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No purchases found',
                      style: TextStyle(color: AppColors.gray500),
                    ),
                  )
                else
                  ...viewModel.filteredPurchases.map((purchase) {
                    return _buildPurchaseItem(context, viewModel, purchase);
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseItem(
    BuildContext context,
    PurchaseViewModel viewModel,
    PurchaseModel purchase,
  ) {
    Color statusColor;
    switch (purchase.status) {
      case PurchaseStatus.completed:
        statusColor = AppColors.successDark;
        break;
      case PurchaseStatus.inProgress:
        statusColor = AppColors.warningDark;
        break;
      case PurchaseStatus.pending:
        statusColor = AppColors.infoDark;
        break;
      case PurchaseStatus.cancelled:
        statusColor = AppColors.errorDark;
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderLight),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  purchase.orderId,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  purchase.supplierName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              purchase.productName,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${purchase.quantity} units',
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '\$${purchase.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                purchase.status.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            onSelected: (value) => _handleAction(
              context,
              viewModel,
              purchase,
              value,
            ),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'complete',
                child: Text('Mark as Completed'),
              ),
              const PopupMenuItem(
                value: 'cancel',
                child: Text('Cancel Order'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text(
                  'Delete',
                  style: TextStyle(color: AppColors.errorDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleAction(
    BuildContext context,
    PurchaseViewModel viewModel,
    PurchaseModel purchase,
    String action,
  ) {
    switch (action) {
      case 'complete':
        viewModel.updatePurchaseStatus(purchase.id, PurchaseStatus.completed);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchase marked as completed')),
        );
        break;
      case 'cancel':
        viewModel.updatePurchaseStatus(purchase.id, PurchaseStatus.cancelled);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchase cancelled')),
        );
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Purchase'),
            content:
                const Text('Are you sure you want to delete this purchase?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  viewModel.deletePurchase(purchase.id);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Purchase deleted')),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: AppColors.errorDark),
                ),
              ),
            ],
          ),
        );
        break;
    }
  }
}
