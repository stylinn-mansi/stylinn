import 'package:flutter/material.dart';
import '../core/themes.dart';
import '../core/google_fonts_typography.dart';

class StyleGuideScreen extends StatelessWidget {
  const StyleGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Typography System'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Display Styles'),
            _buildTypographyItem('Display 1 (36px)', AppTypography.display1),
            _buildTypographyItem('Display 2 (32px)', AppTypography.display2),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Heading Styles'),
            _buildTypographyItem('Heading 1 (28px)', AppTypography.heading1),
            _buildTypographyItem('Heading 2 (27px)', AppTypography.heading2),
            _buildTypographyItem('Heading 3 (24px)', AppTypography.heading3),
            _buildTypographyItem('Heading 4 (20px)', AppTypography.heading4),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Body Styles'),
            _buildTypographyItem('Body Large (18px)', AppTypography.bodyLarge),
            _buildTypographyItem('Body Medium (16px)', AppTypography.bodyMedium),
            _buildTypographyItem('Body Small (14px)', AppTypography.bodySmall),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Label Styles'),
            _buildTypographyItem('Label Large (18px)', AppTypography.labelLarge),
            _buildTypographyItem('Label Medium (16px)', AppTypography.labelMedium),
            _buildTypographyItem('Label Small (14px)', AppTypography.labelSmall),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Caption Styles'),
            _buildTypographyItem('Caption (12px)', AppTypography.caption),
            _buildTypographyItem('Caption Bold (12px)', AppTypography.captionBold),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Utility Styles'),
            _buildTypographyItem('Button Text (16px)', AppTypography.buttonText),
            _buildTypographyItem('Link Text', AppTypography.linkText),
            _buildTypographyItem(
              'Overline (10px)', 
              AppTypography.overline,
              text: 'OVERLINE TEXT EXAMPLE',
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Helper Methods'),
            _buildTypographyItem(
              'With Color', 
              AppTypography.withColor(AppTypography.bodyLarge, AppTheme.primaryGold),
            ),
            _buildTypographyItem(
              'With Letter Spacing', 
              AppTypography.withLetterSpacing(AppTypography.bodyLarge, 2.0),
            ),
            _buildTypographyItem(
              'With Line Height', 
              AppTypography.withLineHeight(AppTypography.bodyLarge, 2.0),
            ),
            _buildTypographyItem(
              'With Weight', 
              AppTypography.withWeight(AppTypography.bodyLarge, FontWeight.bold),
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Design Elements'),
            
            const SizedBox(height: 16),
            Text('Button Example', style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryGold,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  'Discover your Color Palette',
                  style: AppTypography.withColor(AppTypography.buttonText, Colors.white),
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            Text('Scaffold Background Color', style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.darkPrimary,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text('#FFECF3', style: AppTypography.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.withColor(AppTypography.heading3, AppTheme.primaryGold),
        ),
        const Divider(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTypographyItem(String label, TextStyle style, {String? text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text ?? 'The quick brown fox jumps over the lazy dog',
            style: style,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  label,
                  style: AppTypography.caption,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${style.fontSize?.toInt() ?? 'inherit'}px',
                  style: AppTypography.caption,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getFontWeightName(style.fontWeight),
                  style: AppTypography.caption,
                ),
              ),
              if (style.letterSpacing != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'LS: ${style.letterSpacing?.toStringAsFixed(1)}',
                    style: AppTypography.caption,
                  ),
                ),
              ],
              if (style.height != null) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'LH: ${style.height?.toStringAsFixed(2)}',
                    style: AppTypography.caption,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getFontWeightName(FontWeight? weight) {
    switch (weight) {
      case FontWeight.w100:
        return 'Thin';
      case FontWeight.w200:
        return 'ExtraLight';
      case FontWeight.w300:
        return 'Light';
      case FontWeight.w400:
        return 'Regular';
      case FontWeight.w500:
        return 'Medium';
      case FontWeight.w600:
        return 'SemiBold';
      case FontWeight.w700:
        return 'Bold';
      case FontWeight.w800:
        return 'ExtraBold';
      case FontWeight.w900:
        return 'Black';
      default:
        return 'Regular';
    }
  }
} 