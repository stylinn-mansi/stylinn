import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _expandedIndex = -1;

  // Mock FAQs
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I add items to my wardrobe?',
      'answer': 'To add items to your wardrobe, go to the Wardrobe tab and tap the + button in the bottom right corner. You can then take a photo or select from your gallery, add details about the item, and save it to your wardrobe.'
    },
    {
      'question': 'How do I create an outfit?',
      'answer': 'To create an outfit, go to the Outfits tab and tap "Create New Outfit". You can then select items from your wardrobe to combine into an outfit. Save it with a name and optional tags for easy reference.'
    },
    {
      'question': 'Can I share my outfits with friends?',
      'answer': 'Yes! When viewing an outfit, tap the share icon to generate a link or image that you can share via social media, messaging apps, or email.'
    },
    {
      'question': 'How do I get style recommendations?',
      'answer': 'Style recommendations are automatically generated based on your wardrobe items, style preferences, and body measurements. Make sure to complete your profile and add items to your wardrobe for the best recommendations.'
    },
    {
      'question': 'How do I update my body measurements?',
      'answer': 'Go to your Profile tab, tap on "Body Measurements", and update your measurements as needed. You can switch between metric and imperial units as well.'
    },
    {
      'question': 'How do I delete my account?',
      'answer': 'To delete your account, go to Settings > Account > Delete Account. Please note that this action is permanent and all your data will be lost.'
    },
  ];

  // Mock contact methods
  final List<Map<String, dynamic>> _contactMethods = [
    {
      'icon': Icons.email_outlined,
      'title': 'Email Support',
      'subtitle': 'Get help via email',
      'action': 'support@stylinn.com',
    },
    {
      'icon': Icons.chat_outlined,
      'title': 'Live Chat',
      'subtitle': 'Chat with our support team',
      'action': 'Start Chat',
    },
    {
      'icon': Icons.phone_outlined,
      'title': 'Phone Support',
      'subtitle': 'Call our customer service',
      'action': '+1 (800) 123-4567',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredFaqs {
    if (_searchController.text.isEmpty) {
      return _faqs;
    }
    
    final query = _searchController.text.toLowerCase();
    return _faqs.where((faq) {
      return faq['question']!.toLowerCase().contains(query) ||
          faq['answer']!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Help & Support',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          bottom: TabBar(
            labelColor: AppTheme.primaryGold,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: AppTheme.primaryGold,
            tabs: const [
              Tab(text: 'FAQs'),
              Tab(text: 'Contact Us'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFaqTab(),
            _buildContactTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqTab() {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search FAQs',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
          ),
        ),
        
        // FAQ List
        Expanded(
          child: _filteredFaqs.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a different search term',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredFaqs.length,
                  itemBuilder: (context, index) {
                    return _buildFaqItem(_filteredFaqs[index], index);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFaqItem(Map<String, String> faq, int index) {
    final isExpanded = _expandedIndex == index;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _expandedIndex = expanded ? index : -1;
          });
        },
        title: Text(
          faq['question']!,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.remove : Icons.add,
          color: AppTheme.primaryGold,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              faq['answer']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact Methods
          ...List.generate(
            _contactMethods.length,
            (index) => _buildContactMethodItem(_contactMethods[index]),
          ),
          const SizedBox(height: 32),
          
          // Contact Form
          const Text(
            'Send us a message',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Name',
            hint: 'Enter your name',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Email',
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Subject',
            hint: 'What is this regarding?',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            label: 'Message',
            hint: 'How can we help you?',
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          
          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                // Submit form
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message sent successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          // Social Media
          const Text(
            'Follow us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(Icons.facebook, Colors.blue),
              const SizedBox(width: 24),
              _buildSocialButton(Icons.camera_alt_outlined, Colors.pink),
              const SizedBox(width: 24),
              _buildSocialButton(Icons.tiktok, Colors.black),
              const SizedBox(width: 24),
              _buildSocialButton(Icons.play_arrow, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactMethodItem(Map<String, dynamic> method) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryGold.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            method['icon'],
            color: AppTheme.primaryGold,
          ),
        ),
        title: Text(
          method['title'],
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              method['subtitle'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              method['action'],
              style: TextStyle(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        onTap: () {
          // Handle contact method tap
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        // Open social media
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
    );
  }
} 