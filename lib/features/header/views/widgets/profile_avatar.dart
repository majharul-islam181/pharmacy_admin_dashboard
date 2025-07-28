import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimensions.dart';
import '../../model/user_model.dart';

class ProfileAvatar extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingSmall),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppDimensions.avatarMedium,
              height: AppDimensions.avatarMedium,
              decoration: const BoxDecoration(
                color: AppColors.profileBackground,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            const Icon(
              Icons.keyboard_arrow_down,
              size: AppDimensions.iconMedium,
              color: AppColors.iconSecondary,
            ),
          ],
        ),
      ),
    );
  }
}