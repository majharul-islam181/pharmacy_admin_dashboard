import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../view_model/crm_view_model.dart';
import '../../model/crm_summary_model.dart';

class CrmSummaryCards extends StatelessWidget {
  final CrmViewModel viewModel;

  const CrmSummaryCards({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isNarrow = maxWidth < 900;
        final cards = viewModel.summaries;

        return Wrap(
          spacing: AppDimensions.paddingMedium,
          runSpacing: AppDimensions.paddingMedium,
          children: cards
              .map(
                (card) => _CrmSummaryCard(
                  data: card,
                  maxWidth: isNarrow
                      ? maxWidth
                      : (maxWidth - 4 * AppDimensions.paddingMedium) /
                          cards.length,
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _CrmSummaryCard extends StatelessWidget {
  final CrmSummaryModel data;
  final double maxWidth;

  const _CrmSummaryCard({
    required this.data,
    required this.maxWidth,
  });

  IconData _getIconForType(CrmSummaryType type) {
    switch (type) {
      case CrmSummaryType.totalLeads:
        return Icons.group_outlined;
      case CrmSummaryType.totalRevenue:
        return Icons.attach_money_outlined;
      case CrmSummaryType.pendingTasks:
        return Icons.pending_actions_outlined;
      case CrmSummaryType.completedContracts:
        return Icons.assignment_turned_in_outlined;
      case CrmSummaryType.newSubscribers:
        return Icons.person_add_alt_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        builder: (context, t, child) {
          return Transform.translate(
            offset: Offset(0, (1 - t) * 12),
            child: Opacity(opacity: t, child: child),
          );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
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
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        _getIconForType(data.type),
                        size: 20,
                        color: AppColors.infoDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  data.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      data.deltaPositive
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 16,
                      color: data.deltaPositive
                          ? AppColors.successDark
                          : const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data.deltaText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: data.deltaPositive
                            ? AppColors.successDark
                            : const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
