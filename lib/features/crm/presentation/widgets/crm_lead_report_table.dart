import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_model/crm_view_model.dart';
import '../../model/lead_model.dart';

class CrmLeadReportTable extends StatelessWidget {
  final CrmViewModel viewModel;

  const CrmLeadReportTable({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final leads = viewModel.leads;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lead Report',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Recent leads with status and contact details.',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 24,
                headingRowHeight: 40,
                dataRowHeight: 56,
                headingTextStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.infoDark,
                ),
                dataTextStyle: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF4B5563),
                ),
                columns: const [
                  DataColumn(label: Text('S.No')),
                  DataColumn(label: Text('Lead')),
                  DataColumn(label: Text('Company Name')),
                  DataColumn(label: Text('Phone Number')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Location')),
                ],
                rows: leads
                    .map((lead) => DataRow(
                          cells: [
                            DataCell(Text(lead.serialNumber)),
                            DataCell(Text(lead.leadName)),
                            DataCell(Text(lead.companyName)),
                            DataCell(Text(lead.phoneNumber)),
                            DataCell(_buildStatusBadge(lead.status)),
                            DataCell(Text(lead.location)),
                          ],
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(LeadStatus status) {
    Color color;
    switch (status) {
      case LeadStatus.won:
        color = AppColors.successDark;
        break;
      case LeadStatus.lost:
        color = AppColors.errorDark;
        break;
      case LeadStatus.pending:
        color = AppColors.warningDark;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
