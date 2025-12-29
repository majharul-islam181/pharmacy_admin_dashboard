enum SettingCategory {
  general,
  appearance,
  notifications,
  security,
  privacy,
  language,
}

extension SettingCategoryExtension on SettingCategory {
  String get displayName {
    switch (this) {
      case SettingCategory.general:
        return 'General';
      case SettingCategory.appearance:
        return 'Appearance';
      case SettingCategory.notifications:
        return 'Notifications';
      case SettingCategory.security:
        return 'Security';
      case SettingCategory.privacy:
        return 'Privacy';
      case SettingCategory.language:
        return 'Language';
    }
  }
}

class SettingSectionModel {
  final SettingCategory category;
  final String title;
  final String description;
  final List<SettingItemModel> items;

  SettingSectionModel({
    required this.category,
    required this.title,
    required this.description,
    required this.items,
  });
}

enum SettingType {
  toggle,
  dropdown,
  text,
  button,
}

class SettingItemModel {
  final String id;
  final String title;
  final String? subtitle;
  final SettingType type;
  final dynamic value;
  final List<String>? options;
  final void Function(dynamic)? onChanged;

  SettingItemModel({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    this.value,
    this.options,
    this.onChanged,
  });
}
