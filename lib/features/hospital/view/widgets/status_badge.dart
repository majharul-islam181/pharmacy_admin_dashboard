import 'package:flutter/material.dart';

import '../../model/patient_model.dart';

class StatusBadge extends StatelessWidget {
  final PatientStatus status;

  const StatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 300),
      tween: Tween(begin: 0.8, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getStatusColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          _getStatusText(),
          style: TextStyle(
            color: _getStatusColor(),
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case PatientStatus.pending:
        return Colors.orange;
      case PatientStatus.progress:
        return Colors.blue;
      case PatientStatus.complete:
        return Colors.green;
    }
  }

  String _getStatusText() {
    switch (status) {
      case PatientStatus.pending:
        return 'Pending';
      case PatientStatus.progress:
        return 'In Progress';
      case PatientStatus.complete:
        return 'Complete';
    }
  }
}
