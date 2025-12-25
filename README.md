# Pharmacy Admin Dashboard

Pharmacy Admin Dashboard is a Flutter-based admin panel template focused on web (and desktop). It provides ready-made UI for dashboards, purchases, stock management, products, customers, employees, and reports – ideal for CodeCanyon buyers who want a clean starting point for pharmacy, inventory, POS or any custom management system.

## Features

- Responsive Flutter UI (web-first) with sidebar + header layout
- Dashboard with analytics widgets and charts
- Purchase, stock, product, customer, manufacturer and employee pages
- Reports page for sales/stock insights
- Multi-language support (EN, BN, HI) via `easy_localization`
- Theming via centralized `AppTheme`

## Branding & Customization

- App name: **Pharmacy Admin Dashboard**
- Update logo, app icon and splash in `assets/icons/` and regenerate using:
  - `flutter pub run flutter_launcher_icons`
  - `flutter pub run flutter_native_splash:create`
- Change primary colors and typography in `lib/core/theme/app_theme.dart`

## Getting Started

```bash
flutter pub get
flutter run -d chrome
```

To build for web:

```bash
flutter build web --release
```

For more details on Flutter, see the official [documentation](https://docs.flutter.dev/).
