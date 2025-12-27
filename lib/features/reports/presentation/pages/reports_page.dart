import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + period filters (responsive)
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final isCompact = maxWidth < 720;

              final filters = Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: isCompact ? WrapAlignment.start : WrapAlignment.end,
                children: [
                  FilledButton.tonal(
                    onPressed: () {},
                    child: const Text('Today'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('This Week'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('This Month'),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today_outlined, size: 18),
                    label: const Text('Custom Range'),
                  ),
                ],
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reports & Analytics',
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Monitor sales performance, inventory movement and financial metrics.',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    filters,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reports & Analytics',
                          style: textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Monitor sales performance, inventory movement and financial metrics.',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingMedium),
                  filters,
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.paddingLarge),

          // Summary cards
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final isNarrow = maxWidth < 900;

              return Wrap(
                spacing: AppDimensions.paddingMedium,
                runSpacing: AppDimensions.paddingMedium,
                children: [
                  _buildSummaryCard(
                    context,
                    title: 'Total Sales',
                    value: '\$48,920',
                    subtitle: 'Last 30 days',
                    icon: Icons.show_chart,
                    trendLabel: '+12.4% vs last period',
                    trendPositive: true,
                    maxWidth: isNarrow
                        ? maxWidth
                        : (maxWidth - 3 * AppDimensions.paddingMedium) / 4,
                  ),
                  _buildSummaryCard(
                    context,
                    title: 'Total Orders',
                    value: '1,284',
                    subtitle: 'Completed & paid',
                    icon: Icons.shopping_bag_outlined,
                    trendLabel: '+4.1% vs last period',
                    trendPositive: true,
                    maxWidth: isNarrow
                        ? maxWidth
                        : (maxWidth - 3 * AppDimensions.paddingMedium) / 4,
                  ),
                  _buildSummaryCard(
                    context,
                    title: 'Net Profit',
                    value: '\$12,640',
                    subtitle: 'After discounts & tax',
                    icon: Icons.account_balance_wallet_outlined,
                    trendLabel: '+7.8% vs last period',
                    trendPositive: true,
                    maxWidth: isNarrow
                        ? maxWidth
                        : (maxWidth - 3 * AppDimensions.paddingMedium) / 4,
                  ),
                  _buildSummaryCard(
                    context,
                    title: 'Refunds',
                    value: '\$1,120',
                    subtitle: 'Processed this period',
                    icon: Icons.receipt_long_outlined,
                    trendLabel: '-2.3% vs last period',
                    trendPositive: false,
                    maxWidth: isNarrow
                        ? maxWidth
                        : (maxWidth - 3 * AppDimensions.paddingMedium) / 4,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.paddingLarge),

          // Sales overview + Top products
          LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;
              final isStacked = maxWidth < 1100;

              if (isStacked) {
                return Column(
                  children: [
                    _buildSalesOverviewCard(context),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    _buildTopProductsCard(context),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildSalesOverviewCard(context)),
                  const SizedBox(width: AppDimensions.paddingLarge),
                  SizedBox(
                    width: maxWidth * 0.36,
                    child: _buildTopProductsCard(context),
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: AppDimensions.paddingLarge),

          // Recent activity / export actions
          Card.filled(
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Report Activity',
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Quick history of report exports and scheduled summaries.',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      FilledButton.icon(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.file_download_outlined, size: 18),
                        label: const Text('Export PDF'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.table_chart_outlined, size: 18),
                        label: const Text('Export CSV'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  const Divider(height: 1),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  _buildActivityRow(
                    context,
                    icon: Icons.picture_as_pdf_outlined,
                    title: 'Monthly sales report exported',
                    subtitle: 'Exported by Admin on 24 Dec, 10:14 AM',
                    label: 'PDF',
                  ),
                  const SizedBox(height: 8),
                  _buildActivityRow(
                    context,
                    icon: Icons.schedule_send_outlined,
                    title: 'Weekly email summary scheduled',
                    subtitle: 'Will be sent every Monday at 9:00 AM',
                    label: 'Automation',
                  ),
                  const SizedBox(height: 8),
                  _buildActivityRow(
                    context,
                    icon: Icons.table_view_outlined,
                    title: 'Inventory valuation exported',
                    subtitle: 'Exported by Manager on 22 Dec, 4:32 PM',
                    label: 'CSV',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required String trendLabel,
    required bool trendPositive,
    required double maxWidth,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Card.outlined(
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    trendPositive
                        ? Icons.arrow_upward_rounded
                        : Icons.arrow_downward_rounded,
                    size: 18,
                    color: trendPositive ? Colors.green[600] : Colors.red[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trendLabel,
                    style: textTheme.bodySmall?.copyWith(
                      color:
                          trendPositive ? Colors.green[700] : Colors.red[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesOverviewCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sales Overview',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'High level view of revenue and orders over time.',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                SegmentedButton<int>(
                  style: const ButtonStyle(
                    visualDensity: VisualDensity.compact,
                  ),
                  segments: const [
                    ButtonSegment(
                      value: 0,
                      label: Text('Revenue'),
                    ),
                    ButtonSegment(
                      value: 1,
                      label: Text('Orders'),
                    ),
                  ],
                  selected: const {0},
                  onSelectionChanged: (_) {},
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Container(
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outlineVariant
                      .withOpacity(0.5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Chart placeholder – integrate fl_chart or Syncfusion here.',
                style: textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopProductsCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top Products',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Best performing medicines and items for the selected period.',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            DataTable(
              columnSpacing: 16,
              headingTextStyle: textTheme.labelMedium,
              dataTextStyle: textTheme.bodySmall,
              columns: const [
                DataColumn(label: Text('Product')),
                DataColumn(label: Text('Category')),
                DataColumn(label: Text('Units Sold')),
                DataColumn(label: Text('Revenue')),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(Text('Paracetamol 500mg')),
                    DataCell(Text('Pain Relief')),
                    DataCell(Text('420')),
                    DataCell(Text('3,480')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Cough Syrup 100ml')),
                    DataCell(Text('Cold & Flu')),
                    DataCell(Text('310')),
                    DataCell(Text('2,170')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Vitamin C Tablets')),
                    DataCell(Text('Supplements')),
                    DataCell(Text('285')),
                    DataCell(Text('1,920')),
                  ],
                ),
                DataRow(
                  cells: [
                    DataCell(Text('Blood Pressure Monitor')),
                    DataCell(Text('Equipment')),
                    DataCell(Text('64')),
                    DataCell(Text('4,260')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String label,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Icon(
            icon,
            size: 18,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}
