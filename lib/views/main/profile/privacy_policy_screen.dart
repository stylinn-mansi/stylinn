import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
              'Privacy Policy',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: May 15, 2023',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '1. Introduction',
              content: 'At Stylinn ("we," "our," or "us"), we respect your privacy and are committed to protecting your personal data. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application Stylinn (the "App"). Please read this Privacy Policy carefully. By using the App, you consent to the practices described in this Privacy Policy.',
            ),
            _buildSection(
              title: '2. Information We Collect',
              content: 'We collect several types of information from and about users of our App, including:\n\n'
                  '• Personal Information: This includes your name, email address, phone number, date of birth, gender, and body measurements that you provide when creating an account or updating your profile.\n\n'
                  '• Style Preferences: Information about your fashion preferences, favorite colors, styles, and brands, as well as your clothing items that you upload to the App.\n\n'
                  '• Usage Data: Information about how you use the App, including the features you access, the time spent on the App, and your interaction with recommendations.\n\n'
                  '• Device Information: Device identifiers, IP address, operating system, browser type, and other technical information about the device you use to access the App.',
            ),
            _buildSection(
              title: '3. How We Collect Information',
              content: 'We collect information through:\n\n'
                  '• Direct Interactions: Information you provide when you register, update your profile, upload photos, or communicate with our customer support.\n\n'
                  '• Automated Technologies: When you use the App, we may use cookies, web beacons, and similar technologies to collect usage data.\n\n'
                  '• Third-Party Sources: We may receive information about you from third parties, such as social media platforms, if you choose to link your social media account to the App.',
            ),
            _buildSection(
              title: '4. How We Use Your Information',
              content: 'We use your information for various purposes, including to:\n\n'
                  '• Provide, maintain, and improve the App and its features.\n'
                  '• Generate personalized style recommendations based on your preferences and body measurements.\n'
                  '• Process transactions and manage your account.\n'
                  '• Communicate with you, including sending updates, security alerts, and support messages.\n'
                  '• Analyze usage patterns to improve our App\'s functionality and user experience.\n'
                  '• Protect the App and our users from fraudulent, abusive, or unlawful use.',
            ),
            _buildSection(
              title: '5. Disclosure of Your Information',
              content: 'We may disclose your information to:\n\n'
                  '• Service Providers: Third-party vendors who perform services on our behalf, such as hosting, data analysis, payment processing, and customer service.\n\n'
                  '• Business Partners: Companies with whom we partner to offer joint promotional offers or co-branded services.\n\n'
                  '• Legal Compliance: When required by law or in response to valid requests by public authorities.\n\n'
                  '• Business Transfers: In connection with any merger, sale of company assets, financing, or acquisition of all or a portion of our business by another company.',
            ),
            _buildSection(
              title: '6. Data Security',
              content: 'We have implemented appropriate technical and organizational measures to protect your personal information from accidental loss, unauthorized access, use, disclosure, or destruction. However, no electronic transmission or storage of information can be entirely secure, so please use caution when submitting any personal information to us.',
            ),
            _buildSection(
              title: '7. Your Data Rights',
              content: 'Depending on your location, you may have certain rights regarding your personal information, which may include:\n\n'
                  '• Access: The right to request access to your personal information.\n'
                  '• Correction: The right to request that we correct incomplete or inaccurate information.\n'
                  '• Deletion: The right to request that we delete your personal information.\n'
                  '• Restriction: The right to request that we restrict the processing of your information.\n'
                  '• Data Portability: The right to receive your personal information in a structured, commonly used format.\n\n'
                  'To exercise these rights, please contact us using the information provided in the "Contact Us" section.',
            ),
            _buildSection(
              title: '8. Children\'s Privacy',
              content: 'The App is not intended for children under 13 years of age, and we do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us so that we can delete the information.',
            ),
            _buildSection(
              title: '9. Changes to Our Privacy Policy',
              content: 'We may update our Privacy Policy from time to time. If we make material changes, we will notify you through the App or by other means, such as email. Your continued use of the App after such notice constitutes your acceptance of the changes.',
            ),
            _buildSection(
              title: '10. Contact Us',
              content: 'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at:\n\n'
                  'Stylinn Technologies Pvt. Ltd.\n'
                  'Email: privacy@stylinn.com\n'
                  'Address: 123 Tech Park, Mumbai - 400001, India',
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                '© 2023 Stylinn Technologies Pvt. Ltd. All rights reserved.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
} 