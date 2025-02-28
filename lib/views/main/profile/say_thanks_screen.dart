import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SayThanksScreen extends ConsumerStatefulWidget {
  const SayThanksScreen({super.key});

  @override
  ConsumerState<SayThanksScreen> createState() => _SayThanksScreenState();
}

class _SayThanksScreenState extends ConsumerState<SayThanksScreen> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  String _selectedOption = 'Rate us on App Store';
  
  final List<Map<String, dynamic>> _thanksOptions = [
    {
      'title': 'Rate us on App Store',
      'icon': Icons.star_rate_outlined,
      'color': Colors.amber[700],
      'description': 'Leave a positive review on the App Store to help others discover our app.',
    },
    {
      'title': 'Share with friends',
      'icon': Icons.share_outlined,
      'color': Colors.blue[700],
      'description': 'Tell your friends about our app and how it has helped you improve your style.',
    },
    {
      'title': 'Send a testimonial',
      'icon': Icons.format_quote_outlined,
      'color': Colors.green[700],
      'description': 'Write a testimonial that we can share on our website and social media.',
    },
    {
      'title': 'Support our development',
      'icon': Icons.favorite_outline,
      'color': Colors.red[700],
      'description': 'Make a small donation to support the continued development of the app.',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Say Thanks'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Thanks for using Stylinn!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'We appreciate your support. There are several ways you can help us grow and improve:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              
              // Thanks options
              ..._buildThanksOptions(),
              
              const SizedBox(height: 32),
              
              // Message section
              _buildMessageSection(),
              
              const SizedBox(height: 32),
              
              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submitThanks,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildThanksOptions() {
    return _thanksOptions.map((option) {
      final bool isSelected = _selectedOption == option['title'];
      
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedOption = option['title'];
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? option['color'] : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? Color.fromARGB(30, option['color'].red, option['color'].green, option['color'].blue) : Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(50, option['color'].red, option['color'].green, option['color'].blue),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  option['icon'],
                  color: option['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      option['description'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Radio<String>(
                value: option['title'],
                groupValue: _selectedOption,
                activeColor: option['color'],
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add a personal message (optional)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _messageController,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Share your experience with us...',
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue[700]!),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  void _submitThanks() {
    if (_formKey.currentState!.validate()) {
      // In a real app, process the selected option and message
      String message = "Thank you for your support! ";
      
      switch (_selectedOption) {
        case 'Rate us on App Store':
          // Launch app store review
          message += "We're redirecting you to the App Store.";
          break;
        case 'Share with friends':
          // Open share dialog
          message += "We're opening the share dialog.";
          break;
        case 'Send a testimonial':
          // Process testimonial
          message += "Your testimonial has been submitted.";
          break;
        case 'Support our development':
          // Process donation
          message += "We're redirecting you to support options.";
          break;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
      
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }
} 