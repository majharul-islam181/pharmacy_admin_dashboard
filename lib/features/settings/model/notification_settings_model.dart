class NotificationSettingsModel {
  final bool emailNotifications;
  final bool pushNotifications;
  final bool smsNotifications;
  final bool orderUpdates;
  final bool inventoryAlerts;
  final bool systemAlerts;

  NotificationSettingsModel({
    required this.emailNotifications,
    required this.pushNotifications,
    required this.smsNotifications,
    required this.orderUpdates,
    required this.inventoryAlerts,
    required this.systemAlerts,
  });

  NotificationSettingsModel copyWith({
    bool? emailNotifications,
    bool? pushNotifications,
    bool? smsNotifications,
    bool? orderUpdates,
    bool? inventoryAlerts,
    bool? systemAlerts,
  }) {
    return NotificationSettingsModel(
      emailNotifications: emailNotifications ?? this.emailNotifications,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      orderUpdates: orderUpdates ?? this.orderUpdates,
      inventoryAlerts: inventoryAlerts ?? this.inventoryAlerts,
      systemAlerts: systemAlerts ?? this.systemAlerts,
    );
  }
}
