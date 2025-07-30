// import 'package:flutter/material.dart';

// class StatsCardModel {
//   final String id;
//   final String title;
//   final String value;
//   final IconData icon;
//   final Color iconBackground;
//   final Color iconColor;
//   final String? subtitle;
//   final VoidCallback? onShowDetails;

//   StatsCardModel({
//     required this.id,
//     required this.title,
//     required this.value,
//     required this.icon,
//     required this.iconBackground,
//     this.iconColor = Colors.white,
//     this.subtitle,
//     this.onShowDetails,
//   });
// }


import 'package:flutter/material.dart';

class StatsCardModel {
  final String id;
  final String title;
  final String value;
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;
  final String? subtitle;
  final VoidCallback? onShowDetails;

  StatsCardModel({
    required this.id,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconBackground,
    this.iconColor = Colors.white,
    this.subtitle,
    this.onShowDetails,
  });
}