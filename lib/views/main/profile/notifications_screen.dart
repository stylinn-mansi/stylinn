import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  // Notification settings
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _newArrivals = true;
  bool _orderUpdates = true;
  bool _promotions = false;
  bool _styleRecommendations = true;
  bool _outfitSuggestions = true;
  bool _eventReminders = true;

  // Mock notifications
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Summer Collection',
      'message': 'Check out our latest summer collection with exciting new styles!',
      'time': '2 hours ago',
      'isRead': false,
      'type': 'promotion',
      'icon': Icons.local_offer,
    },
    {
      'title': 'Order Shipped',
      'message': 'Your order #12345 has been shipped and will arrive in 2-3 days.',
      'time': '1 day ago',
      'isRead': true,
      'type': 'order',
      'icon': Icons.local_shipping,
    },
    {
      'title': 'Style Recommendation',
      'message': 'Based on your preferences, we think you\'ll love these new items.',
      'time': '3 days ago',
      'isRead': true,
      'type': 'recommendation',
      'icon': Icons.style,
    },
    {
      'title': 'Outfit of the Day',
      'message': 'Create a perfect look for today\'s weather with items from your wardrobe.',
      'time': '5 days ago',
      'isRead': true,
      'type': 'outfit',
      'icon': Icons.checkroom,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Notifications',
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
              Tab(text: 'Notifications'),
              Tab(text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationsTab(),
            _buildSettingsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsTab() {
    return _notifications.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_off_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  'No notifications yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We\'ll notify you when something arrives',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notification = _notifications[index];
              return _buildNotificationItem(notification, index);
            },
          );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    Color iconColor;
    switch (notification['type']) {
      case 'promotion':
        iconColor = Colors.purple;
        break;
      case 'order':
        iconColor = Colors.blue;
        break;
      case 'recommendation':
        iconColor = Colors.orange;
        break;
      case 'outfit':
        iconColor = AppTheme.primaryGold;
        break;
      default:
        iconColor = Colors.grey;
    }

    return Dismissible(
      key: Key('notification_$index'),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _notifications.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notification dismissed')),
        );
      },
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            notification['icon'],
            color: iconColor,
          ),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(
            fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification['message'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              notification['time'],
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: notification['isRead']
            ? null
            : Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGold,
                  shape: BoxShape.circle,
                ),
              ),
        onTap: () {
          // Mark as read and navigate to detail
          setState(() {
            _notifications[index]['isRead'] = true;
          });
        },
      ),
    );
  }

  Widget _buildSettingsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // General Notification Settings
          const Text(
            'General',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'Push Notifications',
            subtitle: 'Receive notifications on your device',
            value: _pushNotifications,
            onChanged: (value) {
              setState(() {
                _pushNotifications = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Email Notifications',
            subtitle: 'Receive notifications via email',
            value: _emailNotifications,
            onChanged: (value) {
              setState(() {
                _emailNotifications = value;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Notification Types
          const Text(
            'Notification Types',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSwitchTile(
            title: 'New Arrivals',
            subtitle: 'Be notified about new products',
            value: _newArrivals,
            onChanged: (value) {
              setState(() {
                _newArrivals = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Order Updates',
            subtitle: 'Track your orders and get delivery updates',
            value: _orderUpdates,
            onChanged: (value) {
              setState(() {
                _orderUpdates = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Promotions & Discounts',
            subtitle: 'Get notified about sales and special offers',
            value: _promotions,
            onChanged: (value) {
              setState(() {
                _promotions = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Style Recommendations',
            subtitle: 'Personalized style suggestions based on your preferences',
            value: _styleRecommendations,
            onChanged: (value) {
              setState(() {
                _styleRecommendations = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Outfit Suggestions',
            subtitle: 'Daily outfit ideas from your wardrobe',
            value: _outfitSuggestions,
            onChanged: (value) {
              setState(() {
                _outfitSuggestions = value;
              });
            },
          ),
          _buildSwitchTile(
            title: 'Event Reminders',
            subtitle: 'Get reminded about upcoming events',
            value: _eventReminders,
            onChanged: (value) {
              setState(() {
                _eventReminders = value;
              });
            },
          ),
          const SizedBox(height: 24),
          
          // Clear All Button
          Center(
            child: OutlinedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Clear All Notifications'),
                    content: const Text(
                      'Are you sure you want to clear all notifications? This action cannot be undone.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _notifications.clear();
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('All notifications cleared'),
                            ),
                          );
                        },
                        child: Text(
                          'Clear All',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ),
                    ],
                  ),
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red[300]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: Text(
                'Clear All Notifications',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppTheme.primaryGold,
          ),
        ],
      ),
    );
  }
} 