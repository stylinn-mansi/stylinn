import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpSupportScreen extends ConsumerStatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  ConsumerState<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends ConsumerState<HelpSupportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search help topics...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
                style: const TextStyle(color: Colors.black),
                autofocus: true,
                onSubmitted: (_) {
                  setState(() {
                    _isSearching = false;
                  });
                  // Implement search functionality
                },
              )
            : const Text('Help & Support'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: _isSearching ? false : true,
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                }
              });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const [
            Tab(text: 'FAQs'),
            Tab(text: 'Support'),
            Tab(text: 'Guides'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQsTab(),
          _buildSupportTab(),
          _buildGuidesTab(),
        ],
      ),
    );
  }

  Widget _buildFAQsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFAQCategory(
            title: 'Account & Profile',
            faqs: [
              {
                'question': 'How do I change my email address?',
                'answer': 'You can change your email address by going to "My Information" in your profile settings. Tap on the email field, enter your new email address, and save your changes. A verification email will be sent to your new address.'
              },
              {
                'question': 'How do I reset my password?',
                'answer': 'To reset your password, go to the login screen and tap on "Forgot Password". Enter your email address, and we\'ll send you a link to create a new password.'
              },
              {
                'question': 'How can I delete my account?',
                'answer': 'To delete your account, go to "My Information" in your profile settings and scroll to the bottom. Tap on "Delete Account" and follow the instructions. Please note that this action is irreversible and all your data will be permanently deleted.'
              },
            ],
          ),
          _buildFAQCategory(
            title: 'Style Formula',
            faqs: [
              {
                'question': 'What is a Style Formula?',
                'answer': 'Your Style Formula is a personalized summary of your fashion preferences, body type, and color analysis. It helps our app provide tailored recommendations that match your unique style and physical characteristics.'
              },
              {
                'question': 'How can I update my Style Formula?',
                'answer': 'You can update your Style Formula by going to "My Style Formula" in your profile and tapping on "Update Formula". You\'ll be guided through a series of questions to refresh your style preferences.'
              },
              {
                'question': 'Why is my Style Formula important?',
                'answer': 'Your Style Formula ensures that all recommendations and outfit suggestions are personalized for you. The more accurate your Style Formula, the better our recommendations will be.'
              },
            ],
          ),
          _buildFAQCategory(
            title: 'Subscription',
            faqs: [
              {
                'question': 'How do I manage my subscription?',
                'answer': 'You can manage your subscription by going to "Manage Subscription" in your profile. There, you can view your current plan, change your subscription, or cancel it.'
              },
              {
                'question': 'What happens if I cancel my subscription?',
                'answer': 'If you cancel your subscription, you ll continue to have access to premium features until the end of your current billing period. After that, your account will revert to the free plan.'
              },
              {
                'question': 'How do I apply a promo code?',
                'answer': 'To apply a promo code, go to "Promo Codes" in your profile, enter your code in the input field, and tap "Apply". If valid, the discount will be applied to your next billing cycle.'
              },
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCategory({required String title, required List<Map<String, String>> faqs}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...faqs.map((faq) => _buildFAQItem(faq['question']!, faq['answer']!)),
        const Divider(height: 32),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSupportTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Our support team is here to help you with any questions or issues. Please fill out the form below, and we\'ll get back to you as soon as possible.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          _buildSupportForm(),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 24),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildSupportForm() {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Topic',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'account', child: Text('Account Issues')),
              DropdownMenuItem(value: 'subscription', child: Text('Subscription Issues')),
              DropdownMenuItem(value: 'app', child: Text('App Functionality')),
              DropdownMenuItem(value: 'feedback', child: Text('Feature Feedback')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Submit support request
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Support request submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              _messageController.clear();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text('Submit Request'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Other Ways to Reach Us',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactMethod(
          icon: Icons.email_outlined,
          title: 'Email',
          detail: 'support@stylinn.com',
          onTap: () {
            // Open email app
          },
        ),
        _buildContactMethod(
          icon: Icons.phone_outlined,
          title: 'Phone',
          detail: '+1 (800) 555-0123',
          onTap: () {
            // Open phone dialer
          },
        ),
        _buildContactMethod(
          icon: Icons.chat_bubble_outline,
          title: 'Live Chat',
          detail: 'Available 9 AM - 5 PM EST, Monday to Friday',
          onTap: () {
            // Open live chat
          },
        ),
      ],
    );
  }

  Widget _buildContactMethod({
    required IconData icon,
    required String title,
    required String detail,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Theme.of(context).primaryColor),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    detail,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidesTab() {
    final List<Map<String, dynamic>> guides = [
      {
        'title': 'Getting Started with Stylinn',
        'icon': Icons.star_outline,
        'color': Colors.amber,
        'description': 'Learn the basics of the app and how to set up your profile for the best experience.',
      },
      {
        'title': 'Understanding Your Style Formula',
        'icon': Icons.science_outlined,
        'color': Colors.purple,
        'description': 'Deep dive into what your Style Formula means and how it affects recommendations.',
      },
      {
        'title': 'Creating a Digital Wardrobe',
        'icon': Icons.checkroom_outlined,
        'color': Colors.blue,
        'description': 'Step-by-step guide to adding and organizing your clothing items in the app.',
      },
      {
        'title': 'Getting Outfit Recommendations',
        'icon': Icons.auto_awesome_outlined,
        'color': Colors.green,
        'description': 'How to use the app to get personalized outfit recommendations for any occasion.',
      },
      {
        'title': 'Shopping Suggestions',
        'icon': Icons.shopping_bag_outlined,
        'color': Colors.red,
        'description': 'How to use the app to discover new clothing items that match your style.',
      },
      {
        'title': 'Seasonal Wardrobe Transition',
        'icon': Icons.wb_sunny_outlined,
        'color': Colors.orange,
        'description': 'Tips on how to update your wardrobe for different seasons using the app.',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: guides.length,
      itemBuilder: (context, index) {
        final guide = guides[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              // Navigate to guide detail page
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: guide['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      guide['icon'],
                      color: guide['color'],
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guide['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guide['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              'Read Guide',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
} 