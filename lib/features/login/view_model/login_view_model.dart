import 'package:flutter/material.dart';
import '../model/login_form_model.dart';

class LoginViewModel extends ChangeNotifier {
  LoginFormModel _formData = LoginFormModel(email: '', password: '');
  bool _isLoading = false;
  bool _obscurePassword = true;

  LoginFormModel get formData => _formData;
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;

  void updateEmail(String email) {
    _formData = _formData.copyWith(email: email);
    notifyListeners();
  }

  void updatePassword(String password) {
    _formData = _formData.copyWith(password: password);
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _formData = _formData.copyWith(rememberMe: value);
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (!_formData.isValid) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();
  }

  void reset() {
    _formData = LoginFormModel(email: '', password: '');
    _isLoading = false;
    _obscurePassword = true;
    notifyListeners();
  }
}
