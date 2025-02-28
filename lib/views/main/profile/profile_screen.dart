import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stylinn/views/main/profile/edit_profile_screen.dart';
import 'help_support_screen.dart';
// Import separate screen files
import 'style_formula_screen.dart';
import 'user_information_screen.dart';
import 'change_password_screen.dart';
import 'feedback_screen.dart';
import 'say_thanks_screen.dart';
import 'contacts_screen.dart';
import 'subscription_screen.dart';
import 'terms_of_service_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        children: [
          _buildProfileAvatar(context),
          _buildPremiumButton(context),
          _buildStyleFormulaCard(context),

          // Account Settings
          const SectionHeader(title: 'Account'),
          _buildMenuItem(
            context: context,
            icon: Icons.person_outline,
            title: 'My Information',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserInformationScreen(),
              ),
            ),
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.lock_outline,
            title: 'Change Password',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChangePasswordScreen(),
              ),
            ),
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.chat_bubble_outline,
            title: 'Send us Feedback',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FeedbackScreen(),
              ),
            ),
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.star_border,
            title: 'Say Thanks',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SayThanksScreen(),
              ),
            ),
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.contact_phone_outlined,
            title: 'Contacts',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactsScreen(),
              ),
            ),
          ),

          // Subscription section
          const SectionHeader(title: 'Subscription'),
          _buildMenuItem(
            context: context,
            icon: Icons.diamond_outlined,
            title: 'Manage Subscription',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SubscriptionScreen(),
              ),
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'PREMIUM',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Legal section
          const SectionHeader(title: 'Legal'),
          _buildMenuItem(
            context: context,
            icon: Icons.security_outlined,
            title: 'Terms of Service',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsOfServiceScreen(),
              ),
            ),
          ),
          _buildMenuItem(
            context: context,
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ),
            ),
          ),

          // Help & Support
          const SectionHeader(title: 'Support'),
          _buildMenuItem(
            context: context,
            icon: Icons.help_outline,
            title: 'Help',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HelpSupportScreen(),
              ),
            ),
          ),

          // Sign out
          const SizedBox(height: 16),
          _buildMenuItem(
            context: context,
            icon: Icons.logout,
            title: 'Sign Out',
            onTap: () => _showLogoutConfirmation(context),
            isDestructive: true,
          ),

          const SizedBox(height: 24),
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Mansi Goel',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SubscriptionScreen(),
          ),
        ),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple[400]!,
                Colors.red[300]!,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Go Premium',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyleFormulaCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Style Formula',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Color Type
              _buildStyleAttribute(
                icon: Icons.palette_outlined,
                iconColor: Colors.amber,
                iconBgColor: Colors.amber[100]!,
                title: 'COLOR TYPE',
                value: 'Cold Winter',
              ),
              const SizedBox(height: 16),
              // Style Type
              _buildStyleAttribute(
                icon: Icons.diamond_outlined,
                iconColor: Colors.orange,
                iconBgColor: Colors.orange[100]!,
                title: 'STYLE TYPE',
                value: 'Classic Gamine',
              ),
              const SizedBox(height: 16),
              // Body Type
              _buildStyleAttribute(
                icon: Icons.accessibility_new_outlined,
                iconColor: Colors.purple,
                iconBgColor: Colors.purple[100]!,
                title: 'BODY TYPE',
                value: 'Triangle',
              ),
              const SizedBox(height: 20),
              // View Formula Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StyleFormulaScreen(),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'View Formula',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStyleAttribute({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: isDestructive ? Colors.red : Colors.black87,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: isDestructive ? Colors.red : Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              trailing ??
                  const Icon(
                    Icons.chevron_right,
                    size: 22,
                    color: Colors.grey,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle sign out logic
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.red[600]),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}
