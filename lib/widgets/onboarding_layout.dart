import 'package:flutter/material.dart';
import '../core/themes.dart';

class OnboardingLayout extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Widget? bottomWidget;

  const OnboardingLayout({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showBackButton = true,
    this.onBack,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      body: Stack(
        children: [
        //content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (showBackButton)
                        IconButton(
                          onPressed: onBack ?? () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppTheme.lightText,
                          ),
                        ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Skip onboarding
                        },
                        child: Text(
                          'Skip',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.lightText.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (title != null) ...[
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      title!,
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: AppTheme.lightText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                if (subtitle != null) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      subtitle!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightText.withOpacity(0.7),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                // Main Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: child,
                  ),
                ),
                // Bottom Widget
                if (bottomWidget != null)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: bottomWidget!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 