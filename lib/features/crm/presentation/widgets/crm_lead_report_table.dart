import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

class CrmLeadReportTable extends StatelessWidget {
  const CrmLeadReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  color: Color(0xFF3B82F6),
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
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('#1')),
                    DataCell(Text('Erik')),
                    DataCell(Text('Digitube')),
                    DataCell(Text('957-550-9950')),
                    DataCell(Text('Won Lead')),
                    DataCell(Text('Tasouloukou')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('#2')),
                    DataCell(Text('Sabina')),
                    DataCell(Text('Kwinu')),
                    DataCell(Text('612-207-4109')),
                    DataCell(Text('Lost Lead')),
                    DataCell(Text('Minneapolis')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('#3')),
                    DataCell(Text('Andi')),
                    DataCell(Text('Photojam')),
                    DataCell(Text('410-936-5855')),
                    DataCell(Text('Won Lead')),
                    DataCell(Text('Masina')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('#4')),
                    DataCell(Text('Kathy')),
                    DataCell(Text('Quinu')),
                    DataCell(Text('840-267-7381')),
                    DataCell(Text('Won Lead')),
                    DataCell(Text('Shashi')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('#5')),
                    DataCell(Text('Lenka')),
                    DataCell(Text('Skaboo')),
                    DataCell(Text('962-993-3146')),
                    DataCell(Text('Won Lead')),
                    DataCell(Text('Shireet')),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
