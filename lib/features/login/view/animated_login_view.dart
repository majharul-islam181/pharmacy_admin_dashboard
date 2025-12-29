import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../view_model/login_view_model.dart';
import 'widgets/animated_login_button.dart';
import 'widgets/social_login_buttons.dart';
import 'dart:math' as math;

class AnimatedLoginView extends StatefulWidget {
  const AnimatedLoginView({super.key});

  @override
  State<AnimatedLoginView> createState() => _AnimatedLoginViewState();
}

class _AnimatedLoginViewState extends State<AnimatedLoginView>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _logoController;
  late AnimationController _formController;
  late Animation<double> _logoRotation;
  late Animation<double> _logoScale;
  late List<Animation<double>> _fieldAnimations;

  @override
  void initState() {
    super.initState();

    // Logo animation controller
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoRotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _logoScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(_logoController);

    _logoController.repeat();

    // Form stagger animation controller
    _formController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Staggered animations for form fields
    _fieldAnimations = List.generate(
      4,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _formController,
          curve: Interval(
            index * 0.15,
            0.4 + (index * 0.15),
            curve: Curves.easeOutCubic,
          ),
        ),
      ),
    );

    _formController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _formController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 20 : 40),
          child: Container(
            width: isMobile ? double.infinity : 500,
            padding: EdgeInsets.all(isMobile ? 32 : 48),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildAnimatedLogo(),
                  const SizedBox(height: 32),
                  _buildAnimatedField(
                    index: 0,
                    child: _buildHeader(),
                  ),
                  const SizedBox(height: 32),
                  _buildAnimatedField(
                    index: 1,
                    child: _buildEmailField(),
                  ),
                  const SizedBox(height: 20),
                  _buildAnimatedField(
                    index: 2,
                    child: _buildPasswordField(),
                  ),
                  const SizedBox(height: 32),
                  _buildAnimatedField(
                    index: 3,
                    child: _buildLoginButton(),
                  ),
                  const SizedBox(height: 24),
                  _buildDivider(),
                  const SizedBox(height: 24),
                  const SocialLoginButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _logoRotation.value,
          child: Transform.scale(
            scale: _logoScale.value,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.purpleDeep, AppColors.purple],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.purpleDeep.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.admin_panel_settings,
                size: 56,
                color: AppColors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedField({required int index, required Widget child}) {
    return AnimatedBuilder(
      animation: _fieldAnimations[index],
      builder: (context, _) {
        final value = _fieldAnimations[index].value;
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          AppStrings.pageAnimatedLogin,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.textDark,
            letterSpacing: -1,
          ),
        ),
        SizedBox(height: 8),
        Text(
          AppStrings.textExperienceSmoothAnimations,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.gray600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: AppStrings.labelEmailAddress,
        hintText: AppStrings.hintEmailPlaceholder,
        prefixIcon: Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.purpleDeep, AppColors.purple],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.email_outlined,
              color: AppColors.white, size: 20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.purpleDeep, width: 2),
        ),
        filled: true,
        fillColor: AppColors.gray50,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return AppStrings.errorValidEmail;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return TextFormField(
          controller: _passwordController,
          obscureText: viewModel.obscurePassword,
          decoration: InputDecoration(
            labelText: AppStrings.labelPassword,
            hintText: AppStrings.hintPasswordPlaceholder,
            prefixIcon: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.purpleDeep, AppColors.purple],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lock_outlined,
                  color: AppColors.white, size: 20),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                viewModel.obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.gray600,
              ),
              onPressed: viewModel.togglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.gray200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  const BorderSide(color: AppColors.purpleDeep, width: 2),
            ),
            filled: true,
            fillColor: AppColors.gray50,
          ),
          validator: (value) {
            if (value == null || value.isEmpty || value.length < 6) {
              return AppStrings.errorPasswordLength;
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildLoginButton() {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, child) {
        return AnimatedLoginButton(
          text: AppStrings.buttonLoginWithAnimation,
          isLoading: viewModel.isLoading,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              viewModel.updateEmail(_emailController.text);
              viewModel.updatePassword(_passwordController.text);
              await viewModel.login();
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(AppStrings.messageLoginSuccessAnimated),
                    backgroundColor: AppColors.successDark,
                  ),
                );
              }
            }
          },
        );
      },
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(color: AppColors.gray200, thickness: 1),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.textOrContinueWith,
            style: TextStyle(
              color: AppColors.gray600,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Divider(color: AppColors.gray200, thickness: 1),
        ),
      ],
    );
  }
}
