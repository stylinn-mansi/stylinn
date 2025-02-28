import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class ClothingDetailsScreen extends ConsumerWidget {
  final Map<String, dynamic> item;

  const ClothingDetailsScreen({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppTheme.darkSecondary,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image
                  Container(
                    color: AppTheme.darkTertiary,
                    child: const Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: AppTheme.lightText,
                        size: 64,
                      ),
                    ),
                  ),
                  // Gradient Overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.darkPrimary.withOpacity(0.5),
                          AppTheme.darkPrimary,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Toggle favorite
                },
                icon: const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {
                  // Show more options
                },
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Brand
                  const Text(
                    'Black Cotton T-Shirt',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Nike',
                    style: TextStyle(
                      color: AppTheme.lightText.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Categories
                  _DetailSection(
                    title: 'Category',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Tag(label: 'Tops'),
                        _Tag(label: 'T-Shirt'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Colors
                  _DetailSection(
                    title: 'Colors',
                    child: Row(
                      children: [
                        _ColorDot(color: Colors.black),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Occasions
                  _DetailSection(
                    title: 'Occasions',
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _Tag(label: 'Casual'),
                        _Tag(label: 'Sport'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Statistics
                  _DetailSection(
                    title: 'Statistics',
                    child: Row(
                      children: [
                        Expanded(
                          child: _StatItem(
                            icon: Icons.repeat,
                            value: '12',
                            label: 'Times Worn',
                          ),
                        ),
                        Expanded(
                          child: _StatItem(
                            icon: Icons.style,
                            value: '8',
                            label: 'Outfits',
                          ),
                        ),
                        Expanded(
                          child: _StatItem(
                            icon: Icons.favorite,
                            value: '4.5',
                            label: 'Rating',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            // Edit item
                          },
                          icon: const Icon(Icons.edit_outlined),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.lightText,
                            side: BorderSide(
                              color: AppTheme.lightText.withOpacity(0.2),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GradientButton(
                          text: 'Create Outfit',
                          onPressed: () {
                            // Navigate to create outfit
                          },
                          height: 44,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _DetailSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: AppTheme.lightText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;

  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.darkSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryGold.withOpacity(0.2),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppTheme.lightText,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _ColorDot extends StatelessWidget {
  final Color color;

  const _ColorDot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.lightText.withOpacity(0.1),
          width: 2,
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppTheme.primaryGold,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.lightText,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            color: AppTheme.lightText.withOpacity(0.7),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 