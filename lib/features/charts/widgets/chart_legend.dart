import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  final List<LegendItem> items;
  final Axis direction;

  const ChartLegend({
    super.key,
    required this.items,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    if (direction == Axis.horizontal) {
      return Wrap(
        spacing: 16,
        runSpacing: 8,
        children: items.map((item) => _LegendItemWidget(item: item)).toList(),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _LegendItemWidget(item: item),
                ))
            .toList(),
      );
    }
  }
}

class _LegendItemWidget extends StatelessWidget {
  final LegendItem item;

  const _LegendItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: item.color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: item.color.withOpacity(0.3),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          item.label,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        if (item.value != null) ...[
          const SizedBox(width: 4),
          Text(
            item.value!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }
}

class LegendItem {
  final String label;
  final Color color;
  final String? value;

  LegendItem({
    required this.label,
    required this.color,
    this.value,
  });
}
