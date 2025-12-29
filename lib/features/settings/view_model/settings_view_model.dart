import 'package:flutter/material.dart';
import '../model/setting_model.dart';
import '../model/user_profile_model.dart';
import '../model/notification_settings_model.dart';

class SettingsViewModel extends ChangeNotifier {
  // State
  UserProfileModel? _userProfile;
  NotificationSettingsModel _notificationSettings = NotificationSettingsModel(
    emailNotifications: true,
    pushNotifications: true,
    smsNotifications: false,
    orderUpdates: true,
    inventoryAlerts: true,
    systemAlerts: true,
  );

  ThemeMode _themeMode = ThemeMode.light;
  String _selectedLanguage = 'en-US';
  bool _autoBackup = true;
  bool _twoFactorAuth = false;
  bool _isLoading = false;

  // Getters
  UserProfileModel? get userProfile => _userProfile;
  NotificationSettingsModel get notificationSettings => _notificationSettings;
  ThemeMode get themeMode => _themeMode;
  String get selectedLanguage => _selectedLanguage;
  bool get autoBackup => _autoBackup;
  bool get twoFactorAuth => _twoFactorAuth;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  SettingsViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadUserProfile();
    await _loadSettings();
  }

  Future<void> _loadUserProfile() async {
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    _userProfile = UserProfileModel(
      name: 'Admin User',
      email: 'admin@pharmacy.com',
      role: 'Administrator',
    );
    notifyListeners();
  }

  Future<void> _loadSettings() async {
    // Simulate loading saved settings
    await Future.delayed(const Duration(milliseconds: 300));
    // Settings loaded from storage
    notifyListeners();
  }

  // Theme Management
  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _saveSettings();
  }

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    _saveSettings();
  }

  // Language Management
  void setLanguage(String languageCode) {
    _selectedLanguage = languageCode;
    notifyListeners();
    _saveSettings();
  }

  // Notification Settings
  void updateEmailNotifications(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      emailNotifications: value,
    );
    notifyListeners();
    _saveSettings();
  }

  void updatePushNotifications(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      pushNotifications: value,
    );
    notifyListeners();
    _saveSettings();
  }

  void updateSmsNotifications(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      smsNotifications: value,
    );
    notifyListeners();
    _saveSettings();
  }

  void updateOrderUpdates(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      orderUpdates: value,
    );
    notifyListeners();
    _saveSettings();
  }

  void updateInventoryAlerts(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      inventoryAlerts: value,
    );
    notifyListeners();
    _saveSettings();
  }

  void updateSystemAlerts(bool value) {
    _notificationSettings = _notificationSettings.copyWith(
      systemAlerts: value,
    );
    notifyListeners();
    _saveSettings();
  }

  // Security Settings
  void setAutoBackup(bool value) {
    _autoBackup = value;
    notifyListeners();
    _saveSettings();
  }

  void setTwoFactorAuth(bool value) {
    _twoFactorAuth = value;
    notifyListeners();
    _saveSettings();
  }

  // Profile Management
  Future<void> updateProfile({
    String? name,
    String? email,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (_userProfile != null) {
      _userProfile = UserProfileModel(
        name: name ?? _userProfile!.name,
        email: email ?? _userProfile!.email,
        role: _userProfile!.role,
        profileImage: _userProfile!.profileImage,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
  }

  // Data Management
  Future<void> exportData() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> clearCache() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> resetSettings() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _themeMode = ThemeMode.light;
    _selectedLanguage = 'en-US';
    _autoBackup = true;
    _twoFactorAuth = false;
    _notificationSettings = NotificationSettingsModel(
      emailNotifications: true,
      pushNotifications: true,
      smsNotifications: false,
      orderUpdates: true,
      inventoryAlerts: true,
      systemAlerts: true,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    // Simulate saving to storage
    await Future.delayed(const Duration(milliseconds: 100));
  }

  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();

    await Future.wait([
      _loadUserProfile(),
      _loadSettings(),
    ]);

    _isLoading = false;
    notifyListeners();
  }
}
