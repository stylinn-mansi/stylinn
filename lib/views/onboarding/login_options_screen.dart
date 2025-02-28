import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../core/themes.dart';
import '../../core/google_fonts_typography.dart';

class LoginOptionsScreen extends ConsumerWidget {
  const LoginOptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Lottie Animation
              SizedBox(
                height: 200,
                child: Lottie.asset(
                  'assets/lottie/hello.json',
                  fit: BoxFit.contain,
                  repeat: true,
                  animate: true,
                ),
              ),
              
              // Badge with stars and laurel
              
              
              const SizedBox(height: 20),
              // Main heading
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Meet ',
                      style: AppTypography.heading1.copyWith(
                        color: Colors.black,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'STYLINN',
                      style: AppTypography.heading1.copyWith(
                        color: AppTheme.primaryGold,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                    TextSpan(
                      text: ', Your Personal AI Stylist',
                      style: AppTypography.heading1.copyWith(
                        color: Colors.black,
                        fontWeight: AppTypography.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 16),
              // Subheading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Unlock your best style - trusted by millions of Indian women and men',
                  style: AppTypography.bodyMedium.copyWith(
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const Spacer(),
              
              // Login options
              _buildLoginButton(
                context: context,
                icon: Icons.email_outlined,
                text: 'Continue with Email',
                backgroundColor: Colors.grey.shade100,
                textColor: Colors.black87,
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildLoginButton(
                context: context,
                icon: null,
                text: 'Continue with Google',
                backgroundColor: Colors.grey.shade100,
                textColor: Colors.black87,
                googleLogo: true,
                onPressed: () {
                  // Implement Google sign-in
                },
              ),
              
              const SizedBox(height: 16),
              
              _buildLoginButton(
                context: context,
                icon: null,
                text: 'Continue with Apple',
                backgroundColor: Colors.black,
                textColor: Colors.white,
                appleLogo: true,
                onPressed: () {
                  // Implement Apple sign-in
                },
              ),
              
              const SizedBox(height: 24),
              
              // Terms and conditions text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTypography.caption.copyWith(
                      color: Colors.black54,
                    ),
                    children: [
                      const TextSpan(
                        text: 'By using Stylinn you confirm that you over 18 years and agree to the ',
                      ),
                      TextSpan(
                        text: 'Terms and conditions',
                        style: AppTypography.caption.copyWith(
                          color: Colors.black,
                          fontWeight: AppTypography.semiBold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTypography.caption.copyWith(
                          color: Colors.black,
                          fontWeight: AppTypography.semiBold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Laurel wreath using custom icons
            SizedBox(
              width: 200,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Left laurel branch
                  Positioned(
                    left: 20,
                    child: Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: AppTheme.primaryGold,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          5,
                          (index) => Transform.rotate(
                            angle: -0.5,
                            child: Icon(
                              Icons.grain,
                              color: AppTheme.primaryGold,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Right laurel branch
                  Positioned(
                    right: 20,
                    child: Container(
                      height: 100,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: AppTheme.primaryGold,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          5,
                          (index) => Transform.rotate(
                            angle: 0.5,
                            child: Icon(
                              Icons.grain,
                              color: AppTheme.primaryGold,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Central content
            Column(
              children: [
                Text(
                  'No.1',
                  style: AppTypography.heading1.copyWith(
                    color: Colors.black,
                    fontWeight: AppTypography.extraBold,
                  ),
                ),
                const SizedBox(height: 8),
                // Five stars
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: AppTheme.primaryGold,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AI STYLIST',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.black,
                    fontWeight: AppTypography.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  'APP',
                  style: AppTypography.labelMedium.copyWith(
                    color: Colors.black,
                    fontWeight: AppTypography.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton({
    required BuildContext context,
    required IconData? icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    bool googleLogo = false,
    bool appleLogo = false,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (googleLogo)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Image.asset(
                  'assets/images/google_icon.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.g_mobiledata,
                    size: 24,
                    color: Colors.blue,
                  ),
                ),
              )
            else if (appleLogo)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Image.asset(
                  'assets/images/apple_icon.png',
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.apple,
                    size: 24,
                    color: textColor,
                  ),
                ),
              )
            else if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: Icon(
                  icon,
                  size: 24,
                  color: textColor,
                ),
              ),
            Text(
              text,
              style: AppTypography.labelMedium.copyWith(
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 