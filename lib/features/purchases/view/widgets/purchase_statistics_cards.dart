import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/purchase_statistics_model.dart';

class PurchaseStatisticsCards extends StatelessWidget {
  final PurchaseStatisticsModel statistics;

  const PurchaseStatisticsCards({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;

        if (isNarrow) {
          return Column(
            children: [
              _buildStatCard(
                'Total Orders',
                statistics.totalOrders.toString(),
                AppColors.infoDark,
                Icons.shopping_bag_outlined,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Pending',
                statistics.pendingOrders.toString(),
                AppColors.warningDark,
                Icons.pending_actions_outlined,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Completed',
                statistics.completedOrders.toString(),
                AppColors.successDark,
                Icons.check_circle_outline,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                'Total Value',
                '\$${statistics.totalValue.toStringAsFixed(2)}',
                AppColors.purple,
                Icons.attach_money,
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Orders',
                statistics.totalOrders.toString(),
                AppColors.infoDark,
                Icons.shopping_bag_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Pending',
                statistics.pendingOrders.toString(),
                AppColors.warningDark,
                Icons.pending_actions_outlined,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Completed',
                statistics.completedOrders.toString(),
                AppColors.successDark,
                Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'Total Value',
                '\$${statistics.totalValue.toStringAsFixed(2)}',
                AppColors.purple,
                Icons.attach_money,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, Color color, IconData icon) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, t, child) {
        return Transform.translate(
          offset: Offset(0, (1 - t) * 20),
          child: Opacity(
            opacity: t,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray600,
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
      ),
    );
  }
}
