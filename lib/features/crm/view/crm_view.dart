import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';

import '../presentation/widgets/crm_charts_section.dart';
import '../presentation/widgets/crm_lead_report_table.dart';
import '../presentation/widgets/crm_summary_cards.dart';
import '../view_model/crm_view_model.dart';

class CrmView extends StatelessWidget {
  const CrmView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CrmViewModel(),
      child: const _CrmViewContent(),
    );
  }
}

class _CrmViewContent extends StatelessWidget {
  const _CrmViewContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CrmViewModel>();
    final isMobile = ResponsiveUtils.isMobile(context);
    final padding =
        isMobile ? AppDimensions.paddingMedium : AppDimensions.paddingLarge;

    return RefreshIndicator(
      onRefresh: viewModel.refreshData,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile)
              const Padding(
                padding: EdgeInsets.only(bottom: AppDimensions.paddingMedium),
                child: Text(
                  'CRM',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            CrmSummaryCards(viewModel: viewModel),
            const SizedBox(height: AppDimensions.paddingLarge),
            CrmChartsRow(viewModel: viewModel),
            const SizedBox(height: AppDimensions.paddingLarge),
            CrmLeadReportTable(viewModel: viewModel),
          ],
        ),
      ),
    );
  }
}
