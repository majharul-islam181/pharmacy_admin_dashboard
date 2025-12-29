import 'package:flutter/material.dart';
import '../../model/user_profile_model.dart';
import '../../../../core/constants/app_dimensions.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfileModel profile;

  const UserProfileCard({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Row(
          children: [
            // Profile Avatar
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 40,
                color: colorScheme.onPrimaryContainer,
              ),
            ),

            const SizedBox(width: AppDimensions.paddingLarge),

            // Profile Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.email,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      profile.role,
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Edit Button
            IconButton.outlined(
              onPressed: () {
                // TODO: Navigate to edit profile
              },
              icon: const Icon(Icons.edit_outlined),
              tooltip: 'Edit Profile',
            ),
          ],
        ),
      ),
    );
  }
}
