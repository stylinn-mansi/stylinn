import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsOfServiceScreen extends ConsumerWidget {
  const TermsOfServiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
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
              'Terms of Service',
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
              title: '1. Acceptance of Terms',
              content: 'By accessing or using the Stylinn mobile application ("App"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, please do not use the App. The App is operated by Stylinn Technologies Pvt. Ltd. ("we," "us," or "our"). We reserve the right to modify these Terms at any time without notice. Your continued use of the App after any such changes constitutes your acceptance of the new Terms.',
            ),
            _buildSection(
              title: '2. Description of Service',
              content: 'Stylinn is a digital styling and fashion recommendation platform that provides personalized style suggestions, outfit recommendations, and wardrobe management tools. The App uses artificial intelligence to analyze user preferences, body measurements, and fashion trends to deliver customized fashion advice.',
            ),
            _buildSection(
              title: '3. User Accounts',
              content: 'To use certain features of the App, you must register for an account. When you register, you agree to provide accurate and complete information. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.',
            ),
            _buildSection(
              title: '4. User Content',
              content: 'The App allows you to upload, share, and store content, including photos of your clothing items and personal style preferences ("User Content"). By uploading User Content, you grant us a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, and display such User Content for the purpose of providing and improving the App\'s services.\n\nYou represent and warrant that your User Content does not violate any third-party rights, including intellectual property rights and privacy rights, and that it complies with all applicable laws and regulations.',
            ),
            _buildSection(
              title: '5. Subscription Services',
              content: 'Certain features of the App require a paid subscription. Subscription fees are clearly displayed before purchase. By subscribing, you authorize us to charge the applicable subscription fee to your designated payment method. Subscriptions automatically renew unless cancelled at least 24 hours before the end of the current billing period.\n\nYou can cancel your subscription through your account settings or by contacting our customer support. No refunds or credits will be provided for partial subscription periods unless required by law.',
            ),
            _buildSection(
              title: '6. Privacy Policy',
              content: 'Your privacy is important to us. Our Privacy Policy, which is incorporated into these Terms by reference, explains how we collect, use, and protect your personal information. By using the App, you consent to the data practices described in our Privacy Policy.',
            ),
            _buildSection(
              title: '7. Intellectual Property',
              content: 'The App and its contents, features, and functionality (including but not limited to all information, software, text, displays, images, video, and audio, and the design, selection, and arrangement thereof) are owned by us, our licensors, or other providers and are protected by copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.',
            ),
            _buildSection(
              title: '8. Prohibited Conduct',
              content: 'You agree not to:\n• Use the App in any way that violates any applicable law or regulation.\n• Impersonate any person or entity, or falsely state or misrepresent your affiliation with a person or entity.\n• Engage in any conduct that restricts or inhibits anyone\'s use or enjoyment of the App.\n• Attempt to gain unauthorized access to the App, other user accounts, or computer systems.\n• Use any robot, spider, or other automatic device to access the App for any purpose.\n• Introduce any viruses, trojan horses, worms, or other material that is malicious or technologically harmful.',
            ),
            _buildSection(
              title: '9. Termination',
              content: 'We may terminate or suspend your account and access to the App immediately, without prior notice, for any reason, including if you breach these Terms. Upon termination, your right to use the App will immediately cease.',
            ),
            _buildSection(
              title: '10. Limitation of Liability',
              content: 'To the maximum extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages, including lost profits, arising out of or relating to your use of the App.\n\nIn no event shall our total liability to you for all damages, losses, or causes of action exceed the amount you have paid us in the last six months, or, if you have not paid us, one hundred dollars (\$100).',
            ),
            _buildSection(
              title: '11. Governing Law',
              content: 'These Terms shall be governed by and construed in accordance with the laws of India, without regard to its conflict of law principles. Any legal suit, action, or proceeding arising out of or related to these Terms or the App shall be instituted exclusively in the courts located in Mumbai, India.',
            ),
            _buildSection(
              title: '12. Contact Information',
              content: 'If you have any questions about these Terms, please contact us at legal@stylinn.com.',
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