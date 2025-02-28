import 'package:flutter/material.dart';
import '../../../core/themes.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wardrobe Insights',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monthly Usage Card
            _buildInsightCard(
              title: 'Monthly Usage',
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Most Worn Items',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: Row(
                          children: [
                            _buildUsageBar('Tops', 0.8, Colors.blue),
                            const SizedBox(width: 12),
                            _buildUsageBar('Bottoms', 0.6, Colors.green),
                            const SizedBox(width: 12),
                            _buildUsageBar('Dresses', 0.4, Colors.purple),
                            const SizedBox(width: 12),
                            _buildUsageBar('Shoes', 0.3, Colors.orange),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Style Analysis
            _buildInsightCard(
              title: 'Style Analysis',
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildStyleItem(
                      'Casual',
                      0.7,
                      AppTheme.primaryGold,
                    ),
                    const SizedBox(height: 12),
                    _buildStyleItem(
                      'Formal',
                      0.4,
                      Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildStyleItem(
                      'Party',
                      0.3,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Color Palette
            _buildInsightCard(
              title: 'Your Color Palette',
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildColorChip(Colors.black, 'Black (25%)'),
                  _buildColorChip(Colors.blue, 'Blue (20%)'),
                  _buildColorChip(Colors.white, 'White (15%)'),
                  _buildColorChip(Colors.red, 'Red (10%)'),
                  _buildColorChip(Colors.green, 'Green (10%)'),
                  _buildColorChip(Colors.purple, 'Purple (10%)'),
                  _buildColorChip(Colors.yellow, 'Yellow (5%)'),
                  _buildColorChip(Colors.pink, 'Pink (5%)'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recommendations
            _buildInsightCard(
              title: 'Recommendations',
              child: Column(
                children: [
                  _buildRecommendation(
                    icon: Icons.add_circle_outline,
                    title: 'Add more bottoms',
                    description: 'Your wardrobe could use more variety in pants and skirts.',
                  ),
                  const SizedBox(height: 16),
                  _buildRecommendation(
                    icon: Icons.color_lens_outlined,
                    title: 'Expand your color palette',
                    description: 'Try adding more colorful pieces to create diverse looks.',
                  ),
                  const SizedBox(height: 16),
                  _buildRecommendation(
                    icon: Icons.style_outlined,
                    title: 'Mix and match',
                    description: 'Create more outfit combinations with your existing items.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }

  Widget _buildUsageBar(String label, double percentage, Color color) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 30,
                    height: 150 * percentage,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '${(percentage * 100).toInt()}%',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyleItem(String label, double percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildColorChip(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: color == Colors.white
                  ? Border.all(color: Colors.grey[300]!)
                  : null,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendation({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryGold,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 