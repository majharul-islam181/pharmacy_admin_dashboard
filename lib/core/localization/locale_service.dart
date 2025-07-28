import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleService {
  static const String _languageKey = 'selected_language';
  
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'), // English
    Locale('bn', 'BD'), // Bangla
    Locale('hi', 'IN'), // Hindi
  ];
  
  static const Locale fallbackLocale = Locale('en', 'US');
  
  static Future<void> changeLanguage(BuildContext context, String languageCode) async {
    Locale newLocale;
    
    switch (languageCode) {
      case 'bn':
        newLocale = const Locale('bn', 'BD');
        break;
      case 'hi':
        newLocale = const Locale('hi', 'IN');
        break;
      default:
        newLocale = const Locale('en', 'US');
    }
    
    await context.setLocale(newLocale);
    // await _saveLanguagePreference(languageCode);
  }
  
  // static Future<void> _saveLanguagePreference(String languageCode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(_languageKey, languageCode);
  // }
  
  static Future<String> getSavedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }
  
  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'bn':
        return 'বাংলা';
      case 'hi':
        return 'हिंदी';
      default:
        return 'English';
    }
  }
  
  static String getCurrentLanguageCode(BuildContext context) {
    return context.locale.languageCode;
  }
}
