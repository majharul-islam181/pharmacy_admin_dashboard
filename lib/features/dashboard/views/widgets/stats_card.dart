import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/stats_card_model.dart';

// class StatsCard extends StatelessWidget {
//   final StatsCardModel card;

//   const StatsCard({
//     super.key,
//     required this.card,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.surface,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header with icon and content
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Circular Icon
//                 Container(
//                   width: 48,
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: card.iconBackground,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     card.icon,
//                     color: card.iconColor,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 16),
                
//                 // Title and Value
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title
//                       Text(
//                         card.title,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: Color(0xFF6B7280), // Gray-500
//                           height: 1.3,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
                      
//                       // Large Value
//                       Text(
//                         card.value,
//                         style: const TextStyle(
//                           fontSize: 32,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF111827), // Gray-900
//                           height: 1.1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
            
//             const SizedBox(height: 20),
            
//             // Show Details Link
//             GestureDetector(
//               onTap: card.onShowDetails,
//               child: const Text(
//                 'Show Details',
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF10B981), // Exact green from design
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class StatsCard extends StatelessWidget {
  final StatsCardModel card;

  const StatsCard({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header with icon and content
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Circular Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: card.iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    card.icon,
                    color: card.iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Title and Value
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        card.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280), // Gray-500
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      
                      // Large Value
                      Text(
                        card.value,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111827), // Gray-900
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Show Details Link
            GestureDetector(
              onTap: card.onShowDetails,
              child: const Text(
                'Show Details',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF10B981), // Exact green from design
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}