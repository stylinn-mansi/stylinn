import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PromoCodesScreen extends ConsumerStatefulWidget {
  const PromoCodesScreen({super.key});

  @override
  ConsumerState<PromoCodesScreen> createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends ConsumerState<PromoCodesScreen> {
  final _promoController = TextEditingController();
  bool _isApplying = false;

  // Example promo codes (in a real app, this would come from an API)
  final List<Map<String, dynamic>> _promoCodes = [
    {
      'code': 'WELCOME25',
      'discount': '25% off',
      'description': 'Welcome discount for new users',
      'validUntil': '2023-06-30',
      'isUsed': false,
    },
    {
      'code': 'SUMMER2023',
      'discount': '₹500 off',
      'description': 'Summer collection special offer',
      'validUntil': '2023-08-31',
      'isUsed': false,
    },
    {
      'code': 'REFER10',
      'discount': '10% off',
      'description': 'Discount for referring a friend',
      'validUntil': '2023-12-31',
      'isUsed': true,
    },
  ];

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo Codes'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPromoCodeInput(),
              const SizedBox(height: 32),
              _buildAvailablePromoCodes(),
              const SizedBox(height: 32),
              _buildUsedPromoCodes(),
              const SizedBox(height: 32),
              _buildReferralSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoCodeInput() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Got a Promo Code?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isApplying ? null : _applyPromoCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isApplying
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('APPLY'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailablePromoCodes() {
    final availableCodes = _promoCodes.where((code) => !code['isUsed']).toList();
    
    if (availableCodes.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'No available promo codes',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Promo Codes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...availableCodes.map(_buildPromoCodeCard),
      ],
    );
  }

  Widget _buildUsedPromoCodes() {
    final usedCodes = _promoCodes.where((code) => code['isUsed']).toList();
    
    if (usedCodes.isEmpty) {
      return const SizedBox();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Used Promo Codes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...usedCodes.map((code) => _buildPromoCodeCard(code, isUsed: true)),
      ],
    );
  }

  Widget _buildPromoCodeCard(Map<String, dynamic> code, {bool isUsed = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isUsed ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUsed ? Colors.grey[300]! : Colors.purple[100]!,
        ),
        boxShadow: isUsed
            ? null
            : [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isUsed ? Colors.grey[200] : Colors.purple[50],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      code['code'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isUsed ? Colors.grey[700] : Colors.purple[800],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      code['discount'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isUsed ? Colors.grey[600] : Colors.purple[600],
                      ),
                    ),
                  ],
                ),
                if (!isUsed)
                  InkWell(
                    onTap: () => _copyToClipboard(code['code']),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.copy,
                            size: 16,
                            color: Colors.purple[700],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'COPY',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'USED',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: isUsed ? Colors.grey[600] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Valid until: ${code['validUntil']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isUsed ? Colors.grey[500] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  color: Colors.blue[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Refer & Earn',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Invite your friends to Stylinn and earn ₹200 in credits when they make their first purchase.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue[900],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'FRIEND200',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _shareReferralCode('FRIEND200'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('SHARE'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyPromoCode() {
    final code = _promoController.text.trim();
    if (code.isEmpty) {
      _showSnackBar('Please enter a promo code');
      return;
    }

    setState(() {
      _isApplying = true;
    });

    // Simulate network request
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isApplying = false;
      });

      final existingCode = _promoCodes.any((promo) => 
        promo['code'] == code && !promo['isUsed']);

      if (existingCode) {
        _showSnackBar('Promo code applied successfully!', isSuccess: true);
        _promoController.clear();
      } else {
        _showSnackBar('Invalid or expired promo code');
      }
    });
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    _showSnackBar('Promo code copied to clipboard', isSuccess: true);
  }

  void _shareReferralCode(String code) {
    // In a real app, implement sharing functionality
    _showSnackBar('Sharing referral code: $code', isSuccess: true);
  }

  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      ),
    );
  }
} 