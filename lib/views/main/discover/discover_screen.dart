import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  final List<Map<String, dynamic>> _aiFeatures = [
    {
      'title': 'General AI Styling',
      'description': 'Get AI-powered outfit recommendations',
      'icon': Icons.auto_awesome,
      'route': '/ai-styling',
      'color': Colors.purple,
    },
    {
      'title': 'Occasion Stylist',
      'description': 'Perfect outfits for every event',
      'icon': Icons.event,
      'route': '/occasion-styling',
      'color': Colors.blue,
    },
    {
      'title': 'Weather Stylist',
      'description': 'Weather-appropriate outfit suggestions',
      'icon': Icons.wb_sunny,
      'route': '/weather-styling',
      'color': Colors.orange,
    },
   
    {
      'title': 'Virtual Try-On',
      'description': 'Try outfits on your photo',
      'icon': Icons.camera_alt,
      'route': '/virtual-try-on',
      'color': Colors.red,
    },
  ];

  final List<Map<String, dynamic>> _savedOutfits = [
    {
      'title': 'Summer Casual',
      'occasion': 'Casual Day Out',
      'confidence': 0.95,
      'image': 'assets/images/top.png',
    },
    {
      'title': 'Office Look',
      'occasion': 'Work',
      'confidence': 0.92,
      'image': 'assets/images/dress.png',
    },
    {
      'title': 'Evening Style',
      'occasion': 'Party',
      'confidence': 0.88,
      'image': 'assets/images/dress1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header
            SliverAppBar(
            //  floating: true,
              backgroundColor: AppTheme.darkPrimary,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: AppTheme.primaryGold,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'AI Stylist',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            // Welcome Message
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Fashion Enthusiast!',
                      style: TextStyle(
                        color: AppTheme.lightText.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Let AI enhance your style today',
                      style: TextStyle(
                        color: AppTheme.lightText,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // AI Features Grid
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final feature = _aiFeatures[index];
                    return _FeatureCard(
                      title: feature['title'],
                      description: feature['description'],
                      icon: feature['icon'],
                      color: feature['color'],
                      onTap: () {
                        // Navigate to feature screen
                        Navigator.pushNamed(context, feature['route']);
                      },
                    );
                  },
                  childCount: _aiFeatures.length,
                ),
              ),
            ),
            // Saved Outfits Section
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text(
                  'Saved AI Suggestions',
                  style: TextStyle(
                    color: AppTheme.lightText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Saved Outfits List
            SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _savedOutfits.length,
                  itemBuilder: (context, index) {
                    final outfit = _savedOutfits[index];
                    return _SavedOutfitCard(
                      title: outfit['title'],
                      occasion: outfit['occasion'],
                      confidence: outfit['confidence'],
                      image: outfit['image'],
                      onTap: () {
                        // Navigate to outfit details
                      },
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.darkSecondary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.lightText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: AppTheme.lightText.withOpacity(0.7),
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedOutfitCard extends StatelessWidget {
  final String title;
  final String occasion;
  final double confidence;
  final String image;
  final VoidCallback onTap;

  const _SavedOutfitCard({
    required this.title,
    required this.occasion,
    required this.confidence,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.primaryGold.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppTheme.lightText,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      occasion,
                      style: TextStyle(
                        color: AppTheme.lightText.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGold.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: AppTheme.primaryGold,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(confidence * 100).toInt()}% Match',
                            style: const TextStyle(
                              color: AppTheme.primaryGold,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 