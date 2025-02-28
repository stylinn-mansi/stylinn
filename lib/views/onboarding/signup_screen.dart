import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/onboarding_layout.dart';
import '../../widgets/gradient_button.dart';
import '../../core/themes.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OnboardingLayout(
      title: _isSignUp ? 'Create Account' : 'Welcome Back',
      subtitle: _isSignUp
          ? 'Start your styling journey with us'
          : 'Sign in to continue your journey',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Social Login Buttons
            Row(
              children: [
                Expanded(
                  child: _SocialButton(
                    icon: 'assets/images/google_icon.png',
                    label: 'Google',
                    iconColor: AppTheme.primaryGold,
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _SocialButton(
                    icon: 'assets/images/apple_icon.png',
                    label: 'Apple',
                    onPressed: () {},
                    iconColor: AppTheme.primaryGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Divider
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppTheme.lightText.withOpacity(0.1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'or continue with',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightText.withOpacity(0.5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppTheme.lightText.withOpacity(0.1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Email Input
            TextField(
              controller: _emailController,
              style: const TextStyle(color: AppTheme.lightText),
              decoration: const InputDecoration(
                hintText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 16),
            // Password Input
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: AppTheme.lightText),
              decoration: const InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            if (!_isSignUp) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryGold,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            // Sign Up/In Button
            GradientButton(
              text: _isSignUp ? 'Create Account' : 'Sign In',
              onPressed: () {
                // Handle sign up/in
                if (_isSignUp) {
                  Navigator.pushNamed(context, '/style-preferences');
                } else {
                  Navigator.pushNamed(context, '/main');
                }
              },
            ),
            const SizedBox(height: 16),
            // Toggle Sign Up/In
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignUp
                      ? 'Already have an account?'
                      : 'Don\'t have an account?',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightText.withOpacity(0.7),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignUp = !_isSignUp;
                    });
                  },
                  child: Text(
                    _isSignUp ? 'Sign In' : 'Sign Up',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryGold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String icon;
  final String label;
  final Color iconColor;
  final VoidCallback onPressed;

  const _SocialButton(
      {required this.icon,
      required this.label,
      required this.onPressed,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.darkSecondary,
        foregroundColor: AppTheme.lightText,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 24,
            width: 24,
            color: iconColor,
          ),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
