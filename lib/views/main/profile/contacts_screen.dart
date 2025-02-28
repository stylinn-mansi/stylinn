import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactsScreen extends ConsumerWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddContactDialog(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListView(
          children: [
            _buildContactSection(
              title: 'Customer Support',
              contacts: [
                _buildContactItem(
                  name: 'Stylinn Help Center',
                  role: 'General Inquiries',
                  email: 'help@stylinn.com',
                  phone: '+91 800-123-4567',
                  avatarColor: Colors.purple[100]!,
                  avatarText: 'SH',
                ),
                _buildContactItem(
                  name: 'Technical Support',
                  role: 'App & Account Issues',
                  email: 'tech@stylinn.com',
                  phone: '+91 800-123-4568',
                  avatarColor: Colors.blue[100]!,
                  avatarText: 'TS',
                ),
              ],
            ),
            _buildContactSection(
              title: 'Styling Team',
              contacts: [
                _buildContactItem(
                  name: 'Personal Stylist',
                  role: 'Style Recommendations',
                  email: 'stylist@stylinn.com',
                  phone: '+91 800-123-4570',
                  avatarColor: Colors.pink[100]!,
                  avatarText: 'PS',
                ),
                _buildContactItem(
                  name: 'Wardrobe Consultant',
                  role: 'Closet Organization',
                  email: 'wardrobe@stylinn.com',
                  phone: '+91 800-123-4571',
                  avatarColor: Colors.orange[100]!,
                  avatarText: 'WC',
                ),
              ],
            ),
            _buildContactSection(
              title: 'Business Team',
              contacts: [
                _buildContactItem(
                  name: 'Partnerships',
                  role: 'Collaboration Inquiries',
                  email: 'partners@stylinn.com',
                  phone: '+91 800-123-4575',
                  avatarColor: Colors.green[100]!,
                  avatarText: 'PT',
                ),
                _buildContactItem(
                  name: 'Media Relations',
                  role: 'Press & Media',
                  email: 'media@stylinn.com',
                  phone: '+91 800-123-4576',
                  avatarColor: Colors.amber[100]!,
                  avatarText: 'MR',
                ),
              ],
            ),
            _buildContactSection(
              title: 'My Contacts',
              contacts: [
                _buildContactItem(
                  name: 'Add your personal contacts',
                  role: 'Save contact information for your favorite stores or stylists',
                  isPlaceholder: true,
                  onTap: () => _showAddContactDialog(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection({
    required String title,
    required List<Widget> contacts,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const Divider(height: 1),
        ...contacts,
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildContactItem({
    required String name,
    required String role,
    String? email,
    String? phone,
    Color? avatarColor,
    String? avatarText,
    bool isPlaceholder = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            if (!isPlaceholder)
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: avatarColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    avatarText ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              )
            else
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.grey,
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (!isPlaceholder && (email != null || phone != null))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        if (email != null)
                          Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                email,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        if (phone != null)
                          Row(
                            children: [
                              Icon(
                                Icons.phone_outlined,
                                size: 14,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                phone,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            ),
            if (!isPlaceholder)
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.email_outlined,
                      color: Colors.blue[700],
                    ),
                    onPressed: () {
                      // Handle email action
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.phone_outlined,
                      color: Colors.green[700],
                    ),
                    onPressed: () {
                      // Handle call action
                    },
                  ),
                ],
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final nameController = TextEditingController();
    final roleController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Contact'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(
                  labelText: 'Role or Description',
                  prefixIcon: Icon(Icons.work_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Save contact functionality would go here
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contact added successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    ).then((_) {
      // Clean up controllers
      nameController.dispose();
      roleController.dispose();
      emailController.dispose();
      phoneController.dispose();
    });
  }
} 