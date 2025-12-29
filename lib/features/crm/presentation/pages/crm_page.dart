import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../widgets/crm_charts_section.dart';
import '../widgets/crm_lead_report_table.dart';
import '../widgets/crm_summary_cards.dart';

class CrmPage extends StatelessWidget {
  const CrmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final padding =
        isMobile ? AppDimensions.paddingMedium : AppDimensions.paddingLarge;

    return SingleChildScrollView(
      padding: EdgeInsets.all(padding),
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
          const CrmSummaryCards(),
          const SizedBox(height: AppDimensions.paddingLarge),
          const CrmChartsRow(),
          const SizedBox(height: AppDimensions.paddingLarge),
          const CrmLeadReportTable(),
        ],
      ),
    );
  }
}
