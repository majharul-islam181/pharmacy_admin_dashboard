// lib/core/providers/language_provider.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';
  
  String get currentLanguage => _currentLanguage;
  
  Future<void> changeLanguage(BuildContext context, String languageCode) async {
    Locale newLocale;
    
    switch (languageCode) {
      case 'bn':
        newLocale = const Locale('bn');
        break;
      case 'hi':
        newLocale = const Locale('hi');
        break;
      default:
        newLocale = const Locale('en');
    }
    
    await context.setLocale(newLocale);
    _currentLanguage = languageCode;
    notifyListeners(); // This will rebuild all listening widgets
  }
}