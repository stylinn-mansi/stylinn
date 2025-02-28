import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StyleFormulaScreen extends ConsumerWidget {
  const StyleFormulaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Style Formula'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Personalized Style Formula',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Based on your body type, preferences, and style quiz results, we\'ve created a personalized formula for your best looks.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            
            // Color Type Section
            _buildSectionCard(
              title: 'Color Type Analysis',
              icon: Icons.palette_outlined,
              iconColor: Colors.amber,
              iconBgColor: Colors.amber[100]!,
              content: _buildColorTypeContent(),
            ),
            
            const SizedBox(height: 20),
            
            // Style Type Section
            _buildSectionCard(
              title: 'Style Type Analysis',
              icon: Icons.diamond_outlined,
              iconColor: Colors.orange,
              iconBgColor: Colors.orange[100]!,
              content: _buildStyleTypeContent(),
            ),
            
            const SizedBox(height: 20),
            
            // Body Type Section
            _buildSectionCard(
              title: 'Body Type Analysis',
              icon: Icons.accessibility_new_outlined,
              iconColor: Colors.purple,
              iconBgColor: Colors.purple[100]!,
              content: _buildBodyTypeContent(),
            ),
            
            const SizedBox(height: 30),
            
            // Recommended clothing items section
            const Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecommendationGrid(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          content,
        ],
      ),
    );
  }
  
  Widget _buildColorTypeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cold Winter',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your color palette consists of cool, deep, and vibrant tones. These colors complement your natural coloring, creating a harmonious and flattering appearance.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Best Colors For You:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildColorPalette([
            Color(0xFF000000), // Black
            Color(0xFF0C1E3E), // Navy
            Color(0xFF0047AB), // Cobalt Blue
            Color(0xFF800020), // Burgundy
            Color(0xFFF0F8FF), // Alice Blue
            Color(0xFFE0115F), // Ruby
            Color(0xFF008080), // Teal
            Color(0xFF800080), // Purple
          ]),
          const SizedBox(height: 20),
          const Text(
            'Colors To Avoid:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildColorPalette([
            Color(0xFFF4A460), // Sandy Brown
            Color(0xFFEEE8AA), // Pale Goldenrod
            Color(0xFFD2B48C), // Tan
            Color(0xFF8B4513), // Saddle Brown
            Color(0xFFBC8F8F), // Rosy Brown
            Color(0xFFDAA520), // Goldenrod
            Color(0xFFF5DEB3), // Wheat
            Color(0xFFCD5C5C), // Indian Red
          ]),
        ],
      ),
    );
  }
  
  Widget _buildColorPalette(List<Color> colors) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: colors.map((color) => _buildColorSwatch(color)).toList(),
    );
  }
  
  Widget _buildColorSwatch(Color color) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStyleTypeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Classic Gamine',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your style type combines the timeless elegance of Classic with the playful charm of Gamine. This blend creates a sophisticated yet youthful appearance that\'s both polished and approachable.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildStyleAttributes(),
        ],
      ),
    );
  }
  
  Widget _buildStyleAttributes() {
    final List<Map<String, String>> attributes = [
      {
        'title': 'Silhouettes',
        'description': 'Structured, tailored pieces with playful details'
      },
      {
        'title': 'Fabrics',
        'description': 'High-quality materials with some textural interest'
      },
      {
        'title': 'Patterns',
        'description': 'Classic patterns with a twist, like updated checks or polka dots'
      },
      {
        'title': 'Details',
        'description': 'Clean lines with occasional unexpected elements'
      },
      {
        'title': 'Accessories',
        'description': 'Refined yet distinctive accessories that add personality'
      },
    ];
    
    return Column(
      children: attributes.map((attribute) => Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                attribute['title']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                attribute['description']!,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
  
  Widget _buildBodyTypeContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Triangle',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Your body type is characterized by narrower shoulders and a wider hip area. The goal is to create balance by emphasizing your upper body while creating a smooth silhouette through the lower body.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Styling Recommendations:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildBodyTypeRecommendations(),
        ],
      ),
    );
  }
  
  Widget _buildBodyTypeRecommendations() {
    final recommendations = [
      {
        'icon': Icons.thumb_up_outlined,
        'title': 'Tops',
        'content': 'Boat necks, off-shoulder tops, statement shoulders, structured jackets',
      },
      {
        'icon': Icons.thumb_up_outlined,
        'title': 'Bottoms',
        'content': 'A-line skirts, dark slim-fit pants, straight leg jeans',
      },
      {
        'icon': Icons.thumb_up_outlined,
        'title': 'Dresses',
        'content': 'Fit-and-flare shapes, A-line dresses, wrap dresses',
      },
      {
        'icon': Icons.thumb_down_outlined,
        'title': 'Avoid',
        'content': 'Pencil skirts, tight pants with tucked-in tops, overly voluminous skirts',
      },
    ];
    
    return Column(
      children: recommendations.map((rec) {
        // Ensure that the keys exist and are not null
        final icon = rec['icon'] as IconData? ?? Icons.help; // Default icon if null
        final title = rec['title'] as String? ?? 'Unknown Title';
        final content = rec['content'] as String? ?? 'No description available.';

        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 18,
                color: icon == Icons.thumb_up_outlined ? Colors.green : Colors.red[400],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildRecommendationGrid() {
    final recommendations = [
      {
        'title': 'Structured Blazer',
        'image': 'assets/images/blazer.jpg',
        'price': '₹2,999',
      },
      {
        'title': 'Boat Neck Top',
        'image': 'assets/images/boat_neck.jpg',
        'price': '₹1,499',
      },
      {
        'title': 'A-line Skirt',
        'image': 'assets/images/skirt.jpg',
        'price': '₹1,899',
      },
      {
        'title': 'Straight Leg Jeans',
        'image': 'assets/images/jeans.jpg',
        'price': '₹2,499',
      },
    ];
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: recommendations.length,
      itemBuilder: (context, index) {
        final item = recommendations[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item['price']!,
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 