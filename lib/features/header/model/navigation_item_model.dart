import 'package:flutter/material.dart';

class NavigationItemModel {
  final String title;
  final IconData icon;
  final String route;
  final bool isActive;

  NavigationItemModel({
    required this.title,
    required this.icon,
    required this.route,
    this.isActive = false,
  });

  NavigationItemModel copyWith({
    String? title,
    IconData? icon,
    String? route,
    bool? isActive,
  }) {
    return NavigationItemModel(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      isActive: isActive ?? this.isActive,
    );
  }
}
