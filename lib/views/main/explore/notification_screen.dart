import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import 'explore_screen.dart';

// Create a new provider for notification items
final notificationItemsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {
    'id': '1',
    'type': 'friend_request',
    'username': 'fashion_forward',
    'userImage': 'https://i.pravatar.cc/150?img=11',
    'timeAgo': '2h',
    'isRead': false,
  },
  {
    'id': '2',
    'type': 'reaction',
    'username': 'trendsetter',
    'userImage': 'https://i.pravatar.cc/150?img=12',
    'reaction': '❤️',
    'postId': '1',
    'timeAgo': '5h',
    'isRead': false,
  },
  {
    'id': '3',
    'type': 'comment',
    'username': 'style_guru',
    'userImage': 'https://i.pravatar.cc/150?img=13',
    'comment': 'Love this look! Where did you get that top?',
    'postId': '2',
    'timeAgo': '1d',
    'isRead': true,
  },
  {
    'id': '4',
    'type': 'share',
    'username': 'fashion_enthusiast',
    'userImage': 'https://i.pravatar.cc/150?img=14',
    'postId': '3',
    'timeAgo': '2d',
    'isRead': true,
  },
]);

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get notifications from provider
    final notifications = ref.watch(notificationItemsProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
              final updatedNotifications = notifications.map((notification) {
                return {...notification, 'isRead': true};
              }).toList();
              
              ref.read(notificationItemsProvider.notifier).state = updatedNotifications;
              
              // Update the unread count to 0
              ref.read(notificationsProvider.notifier).state = 0;
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: AppTheme.primaryGold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return _buildNotificationItem(context, notification, ref);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When you get notifications, they\'ll appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    Map<String, dynamic> notification,
    WidgetRef ref,
  ) {
    final bool isRead = notification['isRead'] as bool;
    
    // Define icon and text based on notification type
    IconData icon;
    String text;
    Color iconColor;
    
    switch (notification['type']) {
      case 'friend_request':
        icon = Icons.person_add;
        text = '${notification['username']} sent you a friend request';
        iconColor = Colors.blue;
        break;
      case 'reaction':
        icon = Icons.favorite;
        text = '${notification['username']} reacted with ${notification['reaction']} to your post';
        iconColor = Colors.red;
        break;
      case 'comment':
        icon = Icons.chat_bubble;
        text = '${notification['username']} commented: "${notification['comment']}"';
        iconColor = Colors.green;
        break;
      case 'share':
        icon = Icons.share;
        text = '${notification['username']} shared your post';
        iconColor = AppTheme.primaryGold;
        break;
      default:
        icon = Icons.notifications;
        text = 'New notification';
        iconColor = Colors.grey;
    }
    
    return InkWell(
      onTap: () {
        // Mark as read when tapped
        if (!isRead) {
          final notifications = ref.read(notificationItemsProvider);
          final index = notifications.indexWhere((n) => n['id'] == notification['id']);
          
          if (index != -1) {
            final updatedNotifications = [...notifications];
            updatedNotifications[index] = {
              ...updatedNotifications[index],
              'isRead': true,
            };
            
            ref.read(notificationItemsProvider.notifier).state = updatedNotifications;
            
            // Update the unread count
            final unreadCount = updatedNotifications.where((n) => n['isRead'] == false).length;
            ref.read(notificationsProvider.notifier).state = unreadCount;
          }
        }
        
        // Navigate to the relevant screen based on notification type
        // For now, just show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigating to ${notification['type']} details'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : AppTheme.primaryGold.withOpacity(0.05),
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(notification['userImage']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification['timeAgo'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (notification['type'] == 'friend_request')
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Accept friend request
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Friend request accepted'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGold,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(80, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Accept'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton(
                            onPressed: () {
                              // Decline friend request
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Friend request declined'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.black87,
                              side: BorderSide(color: Colors.grey[300]!),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              minimumSize: const Size(80, 36),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Decline'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 