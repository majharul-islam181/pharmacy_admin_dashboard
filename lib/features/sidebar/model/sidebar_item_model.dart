import 'package:flutter/material.dart';

class SidebarItemModel {
  final String id;
  final String title;
  final IconData icon;
  final String route;
  final bool isActive;
  final bool hasSubItems;
  final bool isExpanded;
  final List<SidebarItemModel>? subItems;
  final bool isSectionHeader;

  SidebarItemModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.route,
    this.isActive = false,
    this.hasSubItems = false,
    this.isExpanded = false,
    this.subItems,
    this.isSectionHeader = false,
  });

  SidebarItemModel copyWith({
    String? id,
    String? title,
    IconData? icon,
    String? route,
    bool? isActive,
    bool? hasSubItems,
    bool? isExpanded,
    List<SidebarItemModel>? subItems,
    bool? isSectionHeader,
  }) {
    return SidebarItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      isActive: isActive ?? this.isActive,
      hasSubItems: hasSubItems ?? this.hasSubItems,
      isExpanded: isExpanded ?? this.isExpanded,
      subItems: subItems ?? this.subItems,
      isSectionHeader: isSectionHeader ?? this.isSectionHeader,
    );
  }
}
