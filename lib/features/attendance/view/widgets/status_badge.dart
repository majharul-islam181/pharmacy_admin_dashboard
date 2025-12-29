import 'package:flutter/material.dart';
import '../../model/attendance_model.dart';
import '../../../../core/constants/app_colors.dart';


class StatusBadge extends StatelessWidget {
  final AttendanceStatus status;
  final bool animated;

  const StatusBadge({
    super.key,
    required this.status,
    this.animated = true,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            config.color,
            config.color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: config.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            config.icon,
            size: 14,
            color: AppColors.white,
          ),
          const SizedBox(width: 6),
          Text(
            config.label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );

    if (animated) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: badge,
      );
    }

    return badge;
  }

  _StatusConfig _getStatusConfig(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.present:
        return _StatusConfig(
          color:  AppColors.successDark,
          icon: Icons.check_circle,
          label: 'Present',
        );
      case AttendanceStatus.late:
        return _StatusConfig(
          color:  AppColors.warningDark,
          icon: Icons.access_time,
          label: 'Late',
        );
      case AttendanceStatus.absent:
        return _StatusConfig(
          color:  AppColors.errorDark,
          icon: Icons.cancel,
          label: 'Absent',
        );
      case AttendanceStatus.leave:
        return _StatusConfig(
          color:  AppColors.purple,
          icon: Icons.event_note,
          label: 'Leave',
        );
    }
  }
}

class _StatusConfig {
  final Color color;
  final IconData icon;
  final String label;

  _StatusConfig({
    required this.color,
    required this.icon,
    required this.label,
  });
}
