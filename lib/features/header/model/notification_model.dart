import 'package:flutter/material.dart';

class NotificationModel {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String timeAgo;
  final bool isRead;

  const NotificationModel({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.message,
    required this.timeAgo,
    this.isRead = false,
  });
}
