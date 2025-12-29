import 'package:flutter/material.dart';
import '../../model/top_product_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class TopProductsCard extends StatelessWidget {
  final List<TopProductModel> topProducts;

  const TopProductsCard({
    super.key,
    required this.topProducts,
  });

  @override
  Widget build(BuildContext context) {
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
            if (topProducts.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Text(
                    'No products data available',
                    style: textTheme.bodySmall,
                  ),
                ),
              )
            else
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
                rows: topProducts
                    .map(
                      (product) => DataRow(
                        cells: [
                          DataCell(Text(product.productName)),
                          DataCell(Text(product.category)),
                          DataCell(Text(product.unitsSold.toString())),
                          DataCell(Text(product.revenue.toStringAsFixed(0))),
                        ],
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
