import 'package:flutter/material.dart';

enum ActivityType {
  pdfExport,
  csvExport,
  scheduled,
}

extension ActivityTypeExtension on ActivityType {
  IconData get icon {
    switch (this) {
      case ActivityType.pdfExport:
        return Icons.picture_as_pdf_outlined;
      case ActivityType.csvExport:
        return Icons.table_view_outlined;
      case ActivityType.scheduled:
        return Icons.schedule_send_outlined;
    }
  }

  String get label {
    switch (this) {
      case ActivityType.pdfExport:
        return 'PDF';
      case ActivityType.csvExport:
        return 'CSV';
      case ActivityType.scheduled:
        return 'Automation';
    }
  }
}

class ReportActivityModel {
  final String id;
  final ActivityType type;
  final String title;
  final String subtitle;
  final DateTime timestamp;

  ReportActivityModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}
