// // lib/features/settings/widgets/language_selector.dart
// import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/constants/app_dimensions.dart';
// import '../../../core/localization/locale_service.dart';

// class LanguageSelector extends StatelessWidget {
//   const LanguageSelector({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final currentLanguage = LocaleService.getCurrentLanguageCode(context);
    
//     return Container(
//       padding: const EdgeInsets.all(AppDimensions.paddingLarge),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           const Row(
//             children: [
//               Icon(
//                 Icons.language,
//                 size: 24,
//                 color: AppColors.primary,
//               ),
//               SizedBox(width: 12),
//               Text(
//                 'Language Settings',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                   color: AppColors.textPrimary,
//                 ),
//               ),
//             ],
//           ),
          
//           const SizedBox(height: AppDimensions.paddingLarge),
          
//           // Language Options
//           const Text(
//             'Select Language',
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//               color: AppColors.textSecondary,
//             ),
//           ),
          
//           const SizedBox(height: AppDimensions.paddingMedium),
          
//           // Language List
//           _buildLanguageOption(
//             context,
//             'en',
//             'English',
//             '🇺🇸',
//             currentLanguage == 'en',
//           ),
//           _buildLanguageOption(
//             context,
//             'bn',
//             'বাংলা',
//             '🇧🇩',
//             currentLanguage == 'bn',
//           ),
//           _buildLanguageOption(
//             context,
//             'hi',
//             'हिंदी',
//             '🇮🇳',
//             currentLanguage == 'hi',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLanguageOption(
//     BuildContext context,
//     String languageCode,
//     String languageName,
//     String flag,
//     bool isSelected,
//   ) {
//     return InkWell(
//       onTap: () async {
//         await LocaleService.changeLanguage(context, languageCode);
//         // Show success message
//         if (context.mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Language changed to $languageName'),
//               duration: const Duration(seconds: 2),
//               backgroundColor: AppColors.primary,
//             ),
//           );
//         }
//       },
//       borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: AppDimensions.paddingMedium,
//           vertical: AppDimensions.paddingMedium,
//         ),
//         margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
//           borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
//           border: Border.all(
//             color: isSelected ? AppColors.primary : AppColors.border,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Text(
//               flag,
//               style: const TextStyle(fontSize: 24),
//             ),
//             const SizedBox(width: AppDimensions.paddingMedium),
//             Expanded(
//               child: Text(
//                 languageName,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
//                   color: isSelected ? AppColors.primary : AppColors.textPrimary,
//                 ),
//               ),
//             ),
//             if (isSelected)
//               const Icon(
//                 Icons.check_circle,
//                 color: AppColors.primary,
//                 size: 20,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// lib/features/settings/widgets/language_selector.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/localization/locale_service.dart';
import '../../dashboard/view_models/dashboard_stats_view_model.dart';
import '../../navigation/view_model/navigation_view_model.dart';
import '../../sidebar/view_model/sidebar_view_model.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage = LocaleService.getCurrentLanguageCode(context);
    
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Row(
            children: [
              Icon(
                Icons.language,
                size: 24,
                color: AppColors.primary,
              ),
              SizedBox(width: 12),
              Text(
                'Language Settings',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.paddingLarge),
          
          // Language Options
          const Text(
            'Select Language',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.paddingMedium),
          
          // Language List
          _buildLanguageOption(
            context,
            'en',
            'English',
            '🇺🇸',
            currentLanguage == 'en',
          ),
          _buildLanguageOption(
            context,
            'bn',
            'বাংলা',
            '🇧🇩',
            currentLanguage == 'bn',
          ),
          _buildLanguageOption(
            context,
            'hi',
            'हिंदी',
            '🇮🇳',
            currentLanguage == 'hi',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    String languageCode,
    String languageName,
    String flag,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () async {
        await LocaleService.changeLanguage(context, languageCode);
        
        // Force rebuild all ViewModels to update translations
        if (context.mounted) {
          // Notify all providers to rebuild with new language
          context.read<SidebarViewModel>().notifyListeners();
          context.read<NavigationViewModel>().notifyListeners();
          context.read<DashboardStatsViewModel>().notifyListeners();
          
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Language changed to $languageName'),
              duration: const Duration(seconds: 2),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),
        margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: Text(
                languageName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}