import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../models/stats_card_model.dart';
import 'stats_card.dart';

class ResponsiveStatsGrid extends StatelessWidget {
  final List<StatsCardModel> cards;

  const ResponsiveStatsGrid({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return _buildMobileLayout();
    } else if (ResponsiveUtils.isTablet(context)) {
      return _buildTabletLayout();
    } else {
      return _buildDesktopLayout();
    }
  }

  // Mobile: Single column (4 cards vertically)
  Widget _buildMobileLayout() {
    return Column(
      children: cards.map((card) => 
        Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
          child: StatsCard(card: card),
        ),
      ).toList(),
    );
  }

  // Tablet: 2x2 Grid
  Widget _buildTabletLayout() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppDimensions.paddingMedium,
        mainAxisSpacing: AppDimensions.paddingMedium,
        childAspectRatio: 1.4, // Adjust based on content height
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return StatsCard(card: cards[index]);
      },
    );
  }

  // Desktop: Single row (4 cards horizontally)
  Widget _buildDesktopLayout() {
    return Row(
      children: cards.asMap().entries.map((entry) {
        final index = entry.key;
        final card = entry.value;
        
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: index < cards.length - 1 ? AppDimensions.paddingMedium : 0,
            ),
            child: StatsCard(card: card),
          ),
        );
      }).toList(),
    );
  }
}