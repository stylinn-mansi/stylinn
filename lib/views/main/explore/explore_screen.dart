import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../core/themes.dart';
import 'notification_screen.dart';
import 'reaction_popup.dart';

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
  {
    'id': '4',
    'type': 'share',
    'username': 'fashion_enthusiast',
    'userImage': 'assets/images/profile.png',
    'postId': '3',
    'timeAgo': '2d',
    'isRead': true,
  },
]);

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;
  int _unreadNotifications = 3;
  
  // Reaction popup manager
  late ReactionPopupManager _reactionPopupManager;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize the reaction popup manager with the current context
    _reactionPopupManager = ReactionPopupManager(context);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _reactionPopupManager.removeOverlay();
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
    _reactionPopupManager.removeOverlay();
  }

  void _showCreatePostSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreatePostSheet(),
    );
  }

  void _showCommentScreen(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: post['comments'] > 0
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: 5, // Placeholder for actual comments
                      itemBuilder: (context, index) {
                        // Placeholder comment data
                        final commenters = ['fashion_forward', 'style_guru', 'trendsetter', 'fashion_enthusiast', 'sophia_styles'];
                        final commentTexts = [
                          'Love this look! Where did you get that top?',
                          'This is absolutely stunning! 😍',
                          'The color combination is perfect!',
                          'I need this in my wardrobe ASAP!',
                          'You always have the best style inspiration!'
                        ];
                        
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundImage: const AssetImage('assets/images/profile.png'),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          commenters[index],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${index + 1}h ago',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      commentTexts[index],
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          'Reply',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Icon(
                                          Icons.favorite_border,
                                          size: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No comments yet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Be the first to comment on this post',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareScreen(String postId) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Share with',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildShareOption(Icons.message, 'Direct', Colors.blue[100]!),
                _buildShareOption(Icons.link, 'Copy Link', Colors.purple[100]!),
                _buildShareOption(Icons.share, 'Other Apps', Colors.green[100]!),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                final friends = ['fashion_forward', 'style_guru', 'trendsetter', 'fashion_enthusiast'];
                
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  title: Text(friends[index]),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGold,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onTap: () {
                    // Add notification for the share
                    final notifications = [...ref.read(notificationsProvider)];
                    notifications.insert(0, {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'type': 'share',
                      'username': 'you',
                      'userImage': 'assets/images/profile.png',
                      'postId': postId,
                      'timeAgo': 'just now',
                      'isRead': true,
                    });
                    
                    ref.read(notificationsProvider.notifier).state = notifications;
                    
                    Navigator.pop(context);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Post shared with ${friends[index]}!'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color bgColor) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Color.fromARGB(
              255,
              (bgColor.red * 0.6).round(),
              (bgColor.green * 0.6).round(),
              (bgColor.blue * 0.6).round(),
            ),
            size: 28,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showReactionSelector(String postId) {
    final posts = ref.read(postsProvider);
    final postIndex = posts.indexWhere((post) => post['id'] == postId);
    
    if (postIndex == -1) return;
    
    // Add haptic feedback
    HapticFeedback.mediumImpact();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'React to this post',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildReactionButton('❤️', 'Love', postId, Colors.red[100]!),
                  _buildReactionButton('🔥', 'Fire', postId, Colors.orange[100]!),
                  _buildReactionButton('😍', 'Adore', postId, Colors.pink[100]!),
                  _buildReactionButton('😲', 'Wow', postId, Colors.blue[100]!),
                  _buildReactionButton('👍', 'Like', postId, Colors.green[100]!),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReactionButton(String emoji, String label, String postId, Color bgColor) {
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
          
          Navigator.pop(context);
        }
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.5, end: 1.0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.elasticOut,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: bgColor.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostSheet,
        backgroundColor: AppTheme.primaryGold,
        heroTag: 'exploreScreenFAB',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GestureDetector(
        onTap: () => _reactionPopupManager.removeOverlay(),
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 120,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: innerBoxIsScrolled ? 2 : 0,
                title: AnimatedOpacity(
                  opacity: _isCollapsed ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: const Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        color: Colors.black87,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                          setState(() {
                            _unreadNotifications = 0;
                          });
                        },
                      ),
                      if (_unreadNotifications > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              _unreadNotifications.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppTheme.primaryGold.withOpacity(0.1),
                          Colors.white,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explore',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search styles, users, or tags...',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: InputBorder.none,
                              icon: Icon(Icons.search, color: Colors.grey[500]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              // Hint for long press
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Long press on any item to react',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    // Simulate refresh
                    await Future.delayed(const Duration(seconds: 1));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return _buildGridItem(post);
                      },
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
        
        // Show the reaction popup using the manager
        _reactionPopupManager.showReactionPopup(
          position: center,
          onEmojiSelected: (emoji) {
            _handleEmojiSelected(emoji, post['id']);
          },
          emojis: [
            const EmojiReaction(emoji: '❤️', label: 'Love', color: Colors.red),
            const EmojiReaction(emoji: '🔥', label: 'Fire', color: Colors.orange),
            const EmojiReaction(emoji: '😍', label: 'Adore', color: Colors.pink),
            const EmojiReaction(emoji: '😲', label: 'Wow', color: Colors.blue),
            const EmojiReaction(emoji: '👍', label: 'Like', color: Colors.green),
          ],
        );
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
              // Post image
              Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      post['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 30,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                    ),
                    // Gradient overlay at the bottom for text readability
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // User info and reactions
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(post['userImage']),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                post['username'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                post['likes'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Save button
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          // Save post
                          final posts = ref.read(postsProvider);
                          final postIndex = posts.indexWhere((p) => p['id'] == post['id']);
                          
                          if (postIndex != -1) {
                            final updatedPosts = [...posts];
                            updatedPosts[postIndex]['isSaved'] = !updatedPosts[postIndex]['isSaved'];
                            
                            // Add haptic feedback
                            HapticFeedback.lightImpact();
                            
                            ref.read(postsProvider.notifier).state = updatedPosts;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            post['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
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

  void _handleEmojiSelected(String emoji, String postId) {
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
    }
  }

  void _showPostDetails(Map<String, dynamic> post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Post Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Post image
                    Image.asset(
                      post['image'],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    
                    // Post header
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(post['userImage']),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['username'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  post['timeAgo'],
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {
                              // Show post options
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    // Caption
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        post['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    
                    // Reaction bar
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _showReactionSelector(post['id']);
                                },
                                child: Icon(
                                  post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                                  color: post['isLiked'] ? Colors.red : Colors.black87,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  _showCommentScreen(post);
                                },
                                child: const Icon(
                                  Icons.chat_bubble_outline,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  _showShareScreen(post['id']);
                                },
                                child: const Icon(
                                  Icons.send,
                                  size: 26,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              // Save post
                              final posts = ref.read(postsProvider);
                              final postIndex = posts.indexWhere((p) => p['id'] == post['id']);
                              
                              if (postIndex != -1) {
                                final updatedPosts = [...posts];
                                updatedPosts[postIndex]['isSaved'] = !updatedPosts[postIndex]['isSaved'];
                                
                                // Add haptic feedback
                                HapticFeedback.lightImpact();
                                
                                ref.read(postsProvider.notifier).state = updatedPosts;
                              }
                            },
                            child: Icon(
                              post['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Reactions summary
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        children: _buildReactionWidgets(post['reactions'] as Map<dynamic, dynamic>),
                      ),
                    ),
                    
                    // Likes count
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text(
                        '${post['likes']} likes',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    
                    // Comments count
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Text(
                        'View all ${post['comments']} comments',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
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
    );
  }

  List<Widget> _buildReactionWidgets(Map<dynamic, dynamic> reactions) {
    List<Widget> widgets = [];
    
    reactions.forEach((emoji, count) {
      if (count > 0) {
        widgets.add(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji.toString(), style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
    
    return widgets;
  }
}

class CreatePostSheet extends ConsumerStatefulWidget {
  const CreatePostSheet({super.key});

  @override
  ConsumerState<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends ConsumerState<CreatePostSheet> {
  final TextEditingController _captionController = TextEditingController();
  File? _imageFile;
  bool _isUploading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
    
    if (source == ImageSource.camera) {
      Navigator.pop(context); // Close the image source dialog
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _createPost() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image for your post'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    // Simulate upload delay
    Future.delayed(const Duration(seconds: 2), () {
      final posts = ref.read(postsProvider);
      final newPost = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'username': 'you',
        'userImage': 'assets/images/profile.png',
        'image': 'assets/images/top.png', // Using placeholder since we can't actually save the file
        'description': _captionController.text,
        'likes': 0,
        'comments': 0,
        'timeAgo': 'just now',
        'reactions': {
          '❤️': 0,
          '🔥': 0,
          '😍': 0,
          '😲': 0,
          '👍': 0,
        },
        'isLiked': false,
        'isSaved': false,
      };
      
      ref.read(postsProvider.notifier).state = [newPost, ...posts];
      
      setState(() {
        _isUploading = false;
      });
      
      Navigator.pop(context);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post created successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
                const Text(
                  'New Post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _isUploading ? null : _createPost,
                  child: _isUploading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                          ),
                        )
                      : Text(
                          'Share',
                          style: TextStyle(
                            color: AppTheme.primaryGold,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
          
          // Image selection
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _showImageSourceDialog,
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey[100],
                      child: _imageFile != null
                          ? Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Tap to add a photo',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  
                  // Caption
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _captionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
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
                          borderSide: BorderSide(color: AppTheme.primaryGold),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),
                  
                  // Tags and location
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.tag),
                          title: const Text('Tag People'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Show tag people screen
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.location_on_outlined),
                          title: const Text('Add Location'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Show location picker
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.local_offer_outlined),
                          title: const Text('Add Hashtags'),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            // Show hashtag picker
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 