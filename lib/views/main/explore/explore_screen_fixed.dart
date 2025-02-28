import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../core/themes.dart';
import 'notification_screen.dart';

// Provider to store posts
final postsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {
    'id': '1',
    'username': 'sophia_styles',
    'userImage': 'assets/images/profile.png',
    'image': 'assets/images/dress.png',
    'description': 'Loving this new summer outfit! Perfect for beach days ☀️ #SummerVibes #BeachOutfit',
    'likes': 245,
    'comments': 32,
    'timeAgo': '2h',
    'reactions': {
      '❤️': 120,
      '🔥': 85,
      '😍': 40,
      '😲': 0,
      '👍': 0,
    },
    'isLiked': false,
    'isSaved': false,
  },
  {
    'id': '2',
    'username': 'fashion_forward',
    'userImage': 'assets/images/profile.png',
    'image': 'assets/images/top1.png',
    'description': 'Business casual done right. What do you think of this combination? #WorkWear #StyleTips',
    'likes': 189,
    'comments': 24,
    'timeAgo': '5h',
    'reactions': {
      '❤️': 89,
      '🔥': 45,
      '😍': 30,
      '😲': 15,
      '👍': 10,
    },
    'isLiked': false,
    'isSaved': false,
  },
  {
    'id': '3',
    'username': 'trendsetter',
    'userImage': 'assets/images/profile.png',
    'image': 'assets/images/dress1.png',
    'description': 'Experimenting with layers today. Autumn is the perfect season for creative styling! #FallFashion #LayeredLook',
    'likes': 312,
    'comments': 47,
    'timeAgo': '1d',
    'reactions': {
      '❤️': 150,
      '🔥': 102,
      '😍': 45,
      '😲': 10,
      '👍': 5,
    },
    'isLiked': false,
    'isSaved': false,
  },
]);

// Provider to store notifications
final notificationsProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
  {
    'id': '1',
    'type': 'friend_request',
    'username': 'fashion_forward',
    'userImage': 'assets/images/profile.png',
    'timeAgo': '2h',
    'isRead': false,
  },
  {
    'id': '2',
    'type': 'reaction',
    'username': 'trendsetter',
    'userImage': 'assets/images/profile.png',
    'reaction': '❤️',
    'postId': '1',
    'timeAgo': '5h',
    'isRead': false,
  },
  {
    'id': '3',
    'type': 'comment',
    'username': 'style_guru',
    'userImage': 'assets/images/profile.png',
    'comment': 'Love this look! Where did you get that top?',
    'postId': '2',
    'timeAgo': '1d',
    'isRead': true,
  },
]);

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  final int _unreadNotifications = 3;
  
  // Track the position of the long press for the reaction popup
  Offset? _longPressPosition;
  String? _selectedPostId;
  OverlayEntry? _overlayEntry;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _onScroll() {
    final isCollapsed = _scrollController.offset > 100;
    if (isCollapsed != _isCollapsed) {
      setState(() {
        _isCollapsed = isCollapsed;
      });
    }
    
    // Remove reaction overlay when scrolling
    _removeOverlay();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  // Show reaction popup at the long press position
  void _showReactionPopup(String postId, Offset position) {
    // Remove any existing overlay
    _removeOverlay();
    
    // Add haptic feedback
    HapticFeedback.mediumImpact();
    
    // Create the overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              // Transparent overlay to capture taps outside popup
              Positioned.fill(
                child: GestureDetector(
                  onTap: _removeOverlay,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
              ),
              // Reaction popup
              Positioned(
                left: position.dx - 120,
                top: position.dy - 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildReactionButtonSmall('❤️', postId, Colors.red[100]!),
                      _buildReactionButtonSmall('🔥', postId, Colors.orange[100]!),
                      _buildReactionButtonSmall('😍', postId, Colors.pink[100]!),
                      _buildReactionButtonSmall('😲', postId, Colors.blue[100]!),
                      _buildReactionButtonSmall('👍', postId, Colors.green[100]!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    
    Overlay.of(context).insert(_overlayEntry!);
  }

  Widget _buildReactionButtonSmall(String emoji, String postId, Color bgColor) {
    return GestureDetector(
      onTap: () {
        final posts = ref.read(postsProvider);
        final postIndex = posts.indexWhere((post) => post['id'] == postId);
        
        if (postIndex != -1) {
          final updatedPosts = [...posts];
          updatedPosts[postIndex]['reactions'][emoji] = 
              updatedPosts[postIndex]['reactions'][emoji] + 1;
          
          // Add notification for the reaction
          final notifications = [...ref.read(notificationsProvider)];
          notifications.insert(0, {
            'id': DateTime.now().millisecondsSinceEpoch.toString(),
            'type': 'reaction',
            'username': 'you',
            'userImage': 'assets/images/profile.png',
            'reaction': emoji,
            'postId': postId,
            'timeAgo': 'just now',
            'isRead': true,
          });
          
          ref.read(postsProvider.notifier).state = updatedPosts;
          ref.read(notificationsProvider.notifier).state = notifications;
          
          // Add haptic feedback
          HapticFeedback.lightImpact();
          
          _removeOverlay();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: bgColor.withOpacity(0.3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App bar
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: _isCollapsed
                      ? const Text(
                          'Explore',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                  actions: [
                    IconButton(
                      icon: Stack(
                        children: [
                          const Icon(Icons.notifications_outlined, color: Colors.black),
                          if (_unreadNotifications > 0)
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  _unreadNotifications.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                
                // Header and search
                SliverToBoxAdapter(
                  child: !_isCollapsed
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Explore',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Search styles, users, or tags',
                                    hintStyle: TextStyle(color: Colors.grey[500]),
                                    prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
                
                // Grid of posts
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return _buildGridItem(post);
                    },
                  ),
                ),
              ],
            ),
            
            // Floating action button
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () {
                  _showCreatePostSheet();
                },
                backgroundColor: AppTheme.primaryGold,
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> post) {
    // Random height for staggered effect
    final height = 200.0 + (post['id'].hashCode % 100);
    
    return GestureDetector(
      onLongPress: () {
        // Get the position of the long press in the global coordinate system
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset position = box.localToGlobal(Offset.zero);
        
        // Calculate center position of the screen
        final screenSize = MediaQuery.of(context).size;
        final center = Offset(
          position.dx + screenSize.width / 2,
          position.dy + screenSize.height / 3
        );
        
        // Show the reaction popup
        _showReactionPopup(post['id'], center);
      },
      onTap: () {
        // Show post details
        _showPostDetails(post);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  post['image'],
                  fit: BoxFit.cover,
                ),
              ),
              
              // User info and reactions
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User info
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage(post['userImage']),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            post['username'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Description
                    Text(
                      post['description'],
                      style: const TextStyle(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _showPostDetails(Map<String, dynamic> post) {
    // Implementation for showing post details
  }
  
  void _showCreatePostSheet() {
    // Implementation for showing create post sheet
  }
} 