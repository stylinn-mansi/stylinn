import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen> {
  String _selectedPlan = 'Pro';
  bool _yearly = false;

  final List<Map<String, dynamic>> _subscriptionPlans = [
    {
      'title': 'Basic',
      'monthlyPrice': '₹299',
      'yearlyPrice': '₹2,990',
      'yearlyDiscount': '15% off',
      'features': [
        'Outfit recommendation',
        '10 AI style suggestions per day',
        'Basic wardrobe management',
        'Color palette analysis',
      ],
      'color': Colors.blue,
      'isPopular': false,
    },
    {
      'title': 'Pro',
      'monthlyPrice': '₹799',
      'yearlyPrice': '₹7,990',
      'yearlyDiscount': '15% off',
      'features': [
        'Everything in Basic',
        'Virtual Try-on',
        'Unlimited style suggestions',
        'Advanced wardrobe analytics',
        'Personalized shopping recommendations',
      ],
      'color': Colors.purple,
      'isPopular': true,
    },
    {
      'title': 'Premium',
      'monthlyPrice': '₹1,499',
      'yearlyPrice': '₹14,990',
      'yearlyDiscount': '15% off',
      'features': [
        'Everything in Pro',
        'Augmented Reality',
        'Personal AI Stylist',
        'Exclusive designer collaborations',
        'Priority support',
        'Early access to new features',
      ],
      'color': Colors.deepPurple,
      'isPopular': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Subscription'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontFamily: 'Playfair Display',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose your Plan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Select the plan that works best for you and your styling needs.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Billing toggle
                  _buildBillingToggle(),
                  
                  const SizedBox(height: 24),
                  
                  // Subscription plans
                  ..._buildSubscriptionPlans(),
                  
                  const SizedBox(height: 32),
                  
                  // Features comparison
                  _buildFeaturesComparison(),
                  
                  const SizedBox(height: 32),
                  
                  // FAQ section
                  _buildFAQSection(),
                ],
              ),
            ),
          ),
          
          // Bottom action
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Billing Period',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                'Monthly',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: _yearly ? FontWeight.normal : FontWeight.bold,
                  color: _yearly ? Colors.grey[600] : Colors.black,
                ),
              ),
              Switch(
                value: _yearly,
                activeColor: Colors.purple,
                onChanged: (value) {
                  setState(() {
                    _yearly = value;
                  });
                },
              ),
              Text(
                'Yearly',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: _yearly ? FontWeight.bold : FontWeight.normal,
                  color: _yearly ? Colors.black : Colors.grey[600],
                ),
              ),
              if (_yearly)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Save 15%',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSubscriptionPlans() {
    return _subscriptionPlans.map((plan) {
      final bool isSelected = _selectedPlan == plan['title'];
      final Color primaryColor = plan['color'];
      
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedPlan = plan['title'];
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor.withOpacity(0.05) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? primaryColor : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: primaryColor.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor.withOpacity(0.1) : Colors.grey[50],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSelected ? primaryColor : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _yearly
                              ? '${plan['yearlyPrice']} / year'
                              : '${plan['monthlyPrice']} / month',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? primaryColor : Colors.black87,
                          ),
                        ),
                        if (_yearly)
                          Text(
                            plan['yearlyDiscount'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.green[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                    if (plan['isPopular'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'POPULAR',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    Radio<String>(
                      value: plan['title'],
                      groupValue: _selectedPlan,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedPlan = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(
                      plan['features'].length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 16,
                              color: isSelected ? primaryColor : Colors.green[700],
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                plan['features'][index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFeaturesComparison() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Features Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        // Here you could add a detailed features table
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Feature',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...List.generate(
                    _subscriptionPlans.length,
                    (index) => Expanded(
                      child: Center(
                        child: Text(
                          _subscriptionPlans[index]['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              _buildFeatureRow('AI Style Suggestions', [true, true, true]),
              _buildFeatureRow('Virtual Try-on', [false, true, true]),
              _buildFeatureRow('Advanced Analytics', [false, true, true]),
              _buildFeatureRow('Personal AI Stylist', [false, false, true]),
              _buildFeatureRow('Priority Support', [false, false, true]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow(String feature, List<bool> availability) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(feature),
          ),
          ...List.generate(
            availability.length,
            (index) => Expanded(
              child: Center(
                child: Icon(
                  availability[index] ? Icons.check_circle : Icons.cancel,
                  color: availability[index] ? Colors.green : Colors.red[300],
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      {
        'question': 'Can I cancel my subscription anytime?',
        'answer': 'Yes, you can cancel your subscription at any time. You will continue to have access to your premium features until the end of your billing period.',
      },
      {
        'question': 'How do I switch between plans?',
        'answer': 'You can upgrade your plan anytime, and the change will take effect immediately. If you downgrade, the change will apply at the start of your next billing cycle.',
      },
      {
        'question': 'Is there a free trial?',
        'answer': 'Yes, new users can try our Pro plan free for 7 days to experience all the premium features.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Frequently Asked Questions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...faqs.map((faq) => ExpansionTile(
          title: Text(
            faq['question']!,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
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
        )),
      ],
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            // Handle subscription purchase
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Subscribing to $_selectedPlan plan...'),
                backgroundColor: Colors.blue[700],
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Subscribe Now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
} 