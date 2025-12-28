class LoginFormModel {
  final String email;
  final String password;
  final bool rememberMe;

  LoginFormModel({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });

  LoginFormModel copyWith({
    String? email,
    String? password,
    bool? rememberMe,
  }) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'rememberMe': rememberMe,
    };
  }

  factory LoginFormModel.fromJson(Map<String, dynamic> json) {
    return LoginFormModel(
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      rememberMe: json['rememberMe'] ?? false,
    );
  }

  bool get isValid {
    return email.isNotEmpty && password.isNotEmpty && email.contains('@');
  }

  String? validateEmail() {
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!email.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
