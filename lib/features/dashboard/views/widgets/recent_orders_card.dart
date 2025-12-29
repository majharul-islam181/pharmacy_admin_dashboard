import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/app_strings.dart';
import '../../models/recent_order_model.dart';

class RecentOrdersCard extends StatelessWidget {
  final List<RecentOrderModel> orders;
  final VoidCallback onSeeAll;

  const RecentOrdersCard({
    super.key,
    required this.orders,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
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
          // Header
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  AppStrings.textRecentOrders,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: onSeeAll,
                  child: const Row(
                    children: [
                      Text(
                        AppStrings.buttonSeeAll,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.infoDark,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: AppColors.infoDark,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingLarge,
              vertical: AppDimensions.paddingSmall,
            ),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.border, width: 1),
                bottom: BorderSide(color: AppColors.border, width: 1),
              ),
            ),
            child: Row(
              children: [
                _buildHeaderCell(AppStrings.headerMedicineName, flex: 3),
                _buildHeaderCell(AppStrings.headerBatchNo, flex: 2),
                _buildHeaderCell(AppStrings.headerQuantity, flex: 2),
                _buildHeaderCell(AppStrings.headerStatus, flex: 2),
                _buildHeaderCell(AppStrings.headerPrice, flex: 2),
              ],
            ),
          ),

          // Table Rows
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildTableRow(order, index == orders.length - 1);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }

  Widget _buildTableRow(RecentOrderModel order, bool isLast) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(
                bottom: BorderSide(color: AppColors.border, width: 0.5),
              ),
      ),
      child: Row(
        children: [
          // Medicine Name
          Expanded(
            flex: 3,
            child: Text(
              order.medicineName,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Batch No
          Expanded(
            flex: 2,
            child: Text(
              order.batchNo,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Quantity
          Expanded(
            flex: 2,
            child: Text(
              order.quantity.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Status
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(order.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                order.status,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _getStatusColor(order.status),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Price
          Expanded(
            flex: 2,
            child: Text(
              '\$${order.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return AppColors.infoDark;
      case 'pending':
        return AppColors.warningDark;
      case 'cancelled':
        return AppColors.errorDark;
      default:
        return AppColors.textSecondary;
    }
  }
}
