import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';
import 'dart:math';

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  // User name - would typically come from a user profile provider
  final String _userName = "Emma";
  
  // Mock current weather data
  final Map<String, dynamic> _currentWeather = {
    'temp': 18, // in Celsius
    'condition': 'Partly Cloudy',
    'icon': Icons.cloud,
  };
  
  // Mock today's recommendation
  final Map<String, dynamic> _todayRecommendation = {
    'outfit': 'Smart Casual',
    'reason': 'Your meeting with marketing team and mild weather',
    'image': 'assets/images/top.png',
  };

  // Active demo feature 
  String? _activeDemo;

  // Mock outfits created by AI
  final List<Map<String, dynamic>> _myOutfits = [
    {
      'title': 'Cold Winter',
      'icon': Icons.ac_unit,
      'iconBgColor': const Color(0xFFFFF9C4), // Light yellow
      'iconColor': const Color(0xFFFFEB3B), // Yellow
    },
    {
      'title': 'Classic Gamine',
      'icons': [Icons.grid_3x3, Icons.crop_square],
      'iconBgColors': [const Color(0xFFFFCCBC), const Color(0xFFFCE4EC)], // Light orange, Light pink
      'iconColors': [const Color(0xFFFF5722), const Color(0xFFE91E63)], // Deep orange, Pink
    },
    {
      'title': 'Formal Event',
      'icon': Icons.diamond,
      'iconBgColor': const Color(0xFFE1F5FE), // Light blue
      'iconColor': const Color(0xFF03A9F4), // Blue
    },
  ];

  // Mock outfit items
  final List<Map<String, dynamic>> _outfitItems = [
    {
      'type': 'Winter Outfit',
      'items': [
        'assets/images/top.png', // Bag
        'assets/images/dress.png', // Red pants
        'assets/images/top1.png', // Red hoodie
        'assets/images/dress1.png', // Black shoes
      ],
      'tags': ['Everyday'],
      'hasLiked': false,
    },
    {
      'type': 'Evening Outfit',
      'items': [
        'assets/images/dress1.png', // Green bag
        'assets/images/top2.jpg', // Dark floral top
      ],
      'tags': ['Weekend'],
      'hasLiked': true,
    },
  ];

  // AI chat suggestions
  final List<Map<String, dynamic>> _aiChatSuggestions = [
    {
      'question': 'What to wear for a dinner date?',
      'icon': Icons.arrow_forward,
    },
    {
      'question': 'How to style a midi skirt?',
      'icon': Icons.arrow_forward,
    },
    {
      'question': 'What are current fashion trends?',
      'icon': Icons.arrow_forward,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Personalized Greeting Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade50, Colors.purple.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, $_userName!',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  _currentWeather['icon'],
                                  size: 16,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${_currentWeather['temp']}°C, ${_currentWeather['condition']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            color: Colors.purple[300],
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Today\'s Recommendation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              _todayRecommendation['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _todayRecommendation['outfit'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Based on: ${_todayRecommendation['reason']}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 42),
                        elevation: 0,
                      ),
                      child: const Text('See Complete Outfit'),
                    ),
                  ],
                ),
              ),
            ),
            
            // My Outfits Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Outfits',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to all outfits
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Outfit Categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _myOutfits.length,
                  itemBuilder: (context, index) {
                    final outfit = _myOutfits[index];
                    return _buildOutfitCategory(outfit);
                  },
                ),
              ),
            ),
            
            // Outfit Items
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  children: _outfitItems.map((outfit) => _buildOutfitItem(outfit)).toList(),
                ),
              ),
            ),
            
            // Chat with AI Stylist Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Chat with AI Stylist',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // AI Chat Suggestions
                    ...List.generate(
                      _aiChatSuggestions.length,
                      (index) => _buildChatSuggestion(_aiChatSuggestions[index]),
                    ),
                  ],
                ),
              ),
            ),
            
            // AI Features Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'AI Features',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Try them now',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Personalized AI recommendations just for you',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // AI Features Demo
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Weather Stylist Demo
                  _buildExpandableFeatureDemo(
                    title: 'Weather Stylist',
                    subtitle: 'Get outfit recommendations based on current weather',
                    icon: Icons.wb_sunny,
                    color: Colors.orange,
                    isActive: _activeDemo == 'Weather Stylist',
                    onTap: () {
                      setState(() {
                        _activeDemo = _activeDemo == 'Weather Stylist' ? null : 'Weather Stylist';
                      });
                    },
                    demoContent: _buildWeatherStylistDemo(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Virtual Try-On Demo
                  _buildExpandableFeatureDemo(
                    title: 'Virtual Try-On',
                    subtitle: 'See how clothes look on your photo',
                    icon: Icons.camera_alt,
                    color: Colors.red,
                    isActive: _activeDemo == 'Virtual Try-On',
                    onTap: () {
                      setState(() {
                        _activeDemo = _activeDemo == 'Virtual Try-On' ? null : 'Virtual Try-On';
                      });
                    },
                    demoContent: _buildVirtualTryOnDemo(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Style Generator
                  _buildExpandableFeatureDemo(
                    title: 'Style Generator',
                    subtitle: 'Create outfits based on your preferences',
                    icon: Icons.auto_awesome,
                    color: Colors.purple,
                    isActive: _activeDemo == 'Style Generator',
                    onTap: () {
                      setState(() {
                        _activeDemo = _activeDemo == 'Style Generator' ? null : 'Style Generator';
                      });
                    },
                    demoContent: _buildStyleGeneratorDemo(),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutfitCategory(Map<String, dynamic> outfit) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle outfit category tap
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (outfit.containsKey('icon'))
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: outfit['iconBgColor'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      outfit['icon'],
                      color: outfit['iconColor'],
                      size: 16,
                    ),
                  )
                else if (outfit.containsKey('icons'))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: outfit['iconBgColors'][0],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          outfit['icons'][0],
                          color: outfit['iconColors'][0],
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: outfit['iconBgColors'][1],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          outfit['icons'][1],
                          color: outfit['iconColors'][1],
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(width: 8),
                Text(
                  outfit['title'],
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutfitItem(Map<String, dynamic> outfit) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Outfit images
          Container(
            height: 240,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Left side - larger image
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            outfit['items'][0],
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              outfit['hasLiked'] ? Icons.favorite : Icons.favorite_border,
                              color: outfit['hasLiked'] ? Colors.red : Colors.grey,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Right side - smaller images stacked
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      for (int i = 1; i < outfit['items'].length; i++)
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: i < outfit['items'].length - 1 ? 8 : 0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                outfit['items'][i],
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      if (outfit['items'].length == 2)
                        const Expanded(child: SizedBox()), // Empty space if only 2 items
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Tags
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                ...outfit['tags'].map<Widget>((tag) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: tag == 'Everyday' 
                          ? const Color(0xFFE8F5E9) 
                          : const Color(0xFFF8BBD0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tag == 'Everyday' ? Icons.calendar_today : Icons.weekend,
                          size: 14,
                          color: tag == 'Everyday' 
                              ? const Color(0xFF388E3C) 
                              : const Color(0xFFD81B60),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: tag == 'Everyday' 
                                ? const Color(0xFF388E3C) 
                                : const Color(0xFFD81B60),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // Show items
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.list,
                        size: 14,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Items',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
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
    );
  }

  Widget _buildChatSuggestion(Map<String, dynamic> suggestion) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Handle chat suggestion tap
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    suggestion['question'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    suggestion['icon'],
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableFeatureDemo({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
    required Widget demoContent,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isActive ? color.withOpacity(0.5) : Colors.grey[200]!,
              width: isActive ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isActive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                  ),
                ],
              ),
              if (isActive) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                demoContent,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherStylistDemo() {
    // Mock weather-based outfit recommendations
    List<Map<String, dynamic>> weatherOutfits = [
      {
        'weather': 'Today: ${_currentWeather['temp']}°C, ${_currentWeather['condition']}',
        'description': 'Light jacket with jeans is perfect for today\'s weather',
        'items': [
          'assets/images/top.png',
          'assets/images/dress.png',
        ],
      },
      {
        'weather': 'Tomorrow: 22°C, Sunny',
        'description': 'Light cotton outfit recommended for tomorrow',
        'items': [
          'assets/images/top1.png',
          'assets/images/dress1.png',
        ],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Weather-based Recommendations',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ...weatherOutfits.map((outfit) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      outfit['weather'].contains('Sunny') ? Icons.wb_sunny : Icons.cloud,
                      color: Colors.orange[700],
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      outfit['weather'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  outfit['description'],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: outfit['items'].map<Widget>((item) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: AspectRatio(
                        aspectRatio: 0.8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        )),
        Center(
          child: ElevatedButton(
            onPressed: () {
              // Open complete weather stylist
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 0,
            ),
            child: const Text('See More Weather Recommendations'),
          ),
        ),
      ],
    );
  }

  Widget _buildVirtualTryOnDemo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'See How Outfits Look On You',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 350,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // Mockup of virtual try-on with overlay of clothing on a person
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 120,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Upload your photo to try on outfits',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'See how clothes look on you before buying',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Upload photo action
                      },
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text('Upload Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        elevation: 0,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Sample outfits to try on
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    children: [
                      'assets/images/top.png',
                      'assets/images/dress.png',
                      'assets/images/top1.png',
                      'assets/images/dress1.png',
                    ].map((item) => Container(
                      width: 48,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleGeneratorDemo() {
    // Mock style preferences
    List<String> stylePreferences = [
      'Casual', 'Minimalist', 'Bold Colors', 'Sustainable'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI-Generated Styles For You',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Based on $_userName\'s preferences',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 16),
        
        // Style preferences tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: stylePreferences.map((pref) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.purple.shade200),
            ),
            child: Text(
              pref,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.purple[700],
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 20),
        
        // Generated outfits preview
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.auto_awesome,
                        color: Colors.purple[700],
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Generated Outfit',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            'Tuesday, Apr 5 • Casual Work Day',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Regenerate outfit
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh, size: 14),
                          SizedBox(width: 4),
                          Text('Refresh', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 180,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/top.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/images/dress.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    // Save outfit
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 42),
                    elevation: 0,
                  ),
                  child: const Text('Save to My Outfits'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
} 