import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';

class CrmSummaryCards extends StatelessWidget {
  const CrmSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = <_SummaryCardData>[
      const _SummaryCardData(
        icon: Icons.group_outlined,
        title: 'Total Leads',
        value: '823',
        deltaText: '15.78%',
        deltaPositive: true,
      ),
      const _SummaryCardData(
        icon: Icons.attach_money_outlined,
        title: 'Total Revenue',
        value: '1,235.75',
        deltaText: '12.50%',
        deltaPositive: true,
      ),
      const _SummaryCardData(
        icon: Icons.pending_actions_outlined,
        title: 'Pending Tasks',
        value: '78',
        deltaText: '-23.45%',
        deltaPositive: false,
      ),
      const _SummaryCardData(
        icon: Icons.assignment_turned_in_outlined,
        title: 'Completed Contracts',
        value: '543.60',
        deltaText: '18.45%',
        deltaPositive: true,
      ),
      const _SummaryCardData(
        icon: Icons.person_add_alt_outlined,
        title: 'New Subscribers',
        value: '120',
        deltaText: '9.25%',
        deltaPositive: true,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isNarrow = maxWidth < 900;

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

class _SummaryCardData {
  final IconData icon;
  final String title;
  final String value;
  final String deltaText;
  final bool deltaPositive;

  const _SummaryCardData({
    required this.icon,
    required this.title,
    required this.value,
    required this.deltaText,
    required this.deltaPositive,
  });
}

class _CrmSummaryCard extends StatelessWidget {
  final _SummaryCardData data;
  final double maxWidth;

  const _CrmSummaryCard({
    required this.data,
    required this.maxWidth,
  });

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
                        data.icon,
                        size: 20,
                        color:  AppColors.infoDark,
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
                          ?  AppColors.successDark
                          : const Color(0xFFEF4444),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      data.deltaText,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: data.deltaPositive
                            ?  AppColors.successDark
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
