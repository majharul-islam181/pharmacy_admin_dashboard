import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../view_model/purchase_view_model.dart';
import 'widgets/purchase_statistics_cards.dart';

class PurchaseViewView extends StatelessWidget {
  const PurchaseViewView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PurchaseViewModel(),
      child: const _PurchaseViewViewContent(),
    );
  }
}

class _PurchaseViewViewContent extends StatelessWidget {
  const _PurchaseViewViewContent();

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
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Statistics Cards
          if (viewModel.statistics != null)
            PurchaseStatisticsCards(statistics: viewModel.statistics!),
        ],
      ),
    );
  }
}
