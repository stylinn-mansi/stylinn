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
final postsProvider = StateProvider<List<Map<String, dynamic>>>((ref) {
  // List of 20 external clothing image URLs
  final List<String> imageUrls = [
    'https://images.unsplash.com/photo-1566174053879-31528523f8ae?w=800',
    'https://images.unsplash.com/photo-1542060748-10c28b62716f?w=800',
    'https://images.unsplash.com/photo-1617551307578-7232eea19bfa?w=800',
    'https://images.unsplash.com/photo-1560243563-062bfc001d68?w=800',
    'https://images.unsplash.com/photo-1584273143981-41c073dfe8f8?w=800',
    'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=800',
    'https://images.unsplash.com/photo-1583846783214-7229a932b2de?w=800',
    'https://images.unsplash.com/photo-1616150638538-ffb0679a3fc4?w=800',
    'https://images.unsplash.com/photo-1612412888843-9da41026ceca?w=800',
    'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=800',
    'https://images.unsplash.com/photo-1602573991155-21f0143d2473?w=800',
    'https://images.unsplash.com/photo-1573497620053-ea5300f94f21?w=800',
    'https://images.unsplash.com/photo-1603217192634-61068e4d4bf9?w=800',
    'https://images.unsplash.com/flagged/photo-1564468781192-f023d514222d?w=800',
    'https://images.unsplash.com/photo-1571908598087-cf33b05291e4?w=800',
    'https://images.unsplash.com/photo-1525507119028-ed4c629a60a3?w=800',
    'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=800',
    'https://images.unsplash.com/photo-1576663948870-2b5ba4ac16e7?w=800',
    'https://images.unsplash.com/photo-1601924381523-019b78541b22?w=800',
    'https://images.unsplash.com/photo-1556905055-8f358a7a47b2?w=800',
  ];

  // Sample usernames
  final List<String> usernames = [
    'sophia_styles', 'fashion_forward', 'trendsetter', 'style_guru',
    'fashion_enthusiast', 'clothes_heaven', 'runway_ready', 'chic_boutique',
    'vogue_vision', 'elegant_attire', 'casual_couture', 'trending_threads',
    'stylish_selection', 'fashion_finds', 'luxe_looks', 'designer_daily',
    'wardrobe_wonder', 'outfit_obsession', 'fashion_fusion', 'style_sensation'
  ];

  // Generate 20 posts with external images
  List<Map<String, dynamic>> posts = [];
  for (int i = 0; i < 20; i++) {
    posts.add({
      'id': (i + 1).toString(),
      'username': usernames[i],
      'userImage': 'https://i.pravatar.cc/150?img=${i + 10}',
      'image': imageUrls[i],
      'description': 'Fashion post #${i + 1}. #Style #Fashion #Trends',
      'likes': 50 + (i * 13),
      'comments': 5 + (i * 3),
      'timeAgo': '${i % 12 + 1}h',
      'isLiked': false,
      'isSaved': false,
    });
  }
  return posts;
});

// Simplified notifications provider - stores the count of unread notifications
final notificationsProvider = StateProvider<int>((ref) {
  // Calculate initial unread count from notificationItemsProvider
  // This ensures the count stays in sync with the actual notifications
  if (ref.exists(notificationItemsProvider)) {
    final notifications = ref.read(notificationItemsProvider);
    return notifications.where((n) => n['isRead'] == false).length;
  }
  return 3; // Default count if notificationItemsProvider doesn't exist yet
});

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showCreatePostSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreatePostSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(postsProvider);
    final unreadNotifications = ref.watch(notificationsProvider);
    
    return Scaffold(
      backgroundColor: Colors.white,
      // Simplified AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Explore',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Search icon
          IconButton(
            icon: Icon(Icons.search, color: Colors.black87),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StyleSearch(),
              );
            },
          ),
          // Notification icon with badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.black87),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationScreen(),
                    ),
                  );
                  ref.read(notificationsProvider.notifier).state = 0;
                },
              ),
              if (unreadNotifications > 0)
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
                      unreadNotifications.toString(),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostSheet,
        backgroundColor: AppTheme.primaryGold,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
          slivers: [
            // Header text
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  'Discover trending styles',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            
            // Pinterest-style staggered grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  // Calculate random height for variety (more Pinterest-like)
                  final aspectRatio = index % 2 == 0 ? 0.8 : 1.2;
                  return _buildGridItem(post, aspectRatio);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> post, double aspectRatio) {
    return GestureDetector(
      onTap: () => _showPostDetails(post),
      onLongPress: () {
        // Add haptic feedback
        HapticFeedback.mediumImpact();
        
        // Show share options or react
        _showQuickActions(post);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            AspectRatio(
              aspectRatio: aspectRatio,
              child: Image.network(
                post['image'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                      valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey[400]),
                    ),
                  );
                },
              ),
            ),
            
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(post['userImage']),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          post['username'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Like icon and count
                      Icon(Icons.favorite, size: 14, color: Colors.red),
                      SizedBox(width: 2),
                      Text(
                        post['likes'].toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActions(Map<String, dynamic> post) {
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
              'Quick Actions',
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
                _buildActionButton(
                  icon: Icons.favorite_border,
                  label: 'Like',
                  color: Colors.red[100]!,
                  onTap: () {
                    Navigator.pop(context);
                    _toggleLike(post);
                  },
                ),
                _buildActionButton(
                  icon: Icons.bookmark_border,
                  label: 'Save',
                  color: Colors.blue[100]!,
                  onTap: () {
                    Navigator.pop(context);
                    _toggleSave(post);
                  },
                ),
                _buildActionButton(
                  icon: Icons.share,
                  label: 'Share',
                  color: Colors.green[100]!,
                  onTap: () {
                    Navigator.pop(context);
                    // Show share dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Sharing post from ${post['username']}'))
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color.withOpacity(1),
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(Map<String, dynamic> post) {
    final posts = ref.read(postsProvider);
    final index = posts.indexWhere((p) => p['id'] == post['id']);
    
    if (index != -1) {
      final updatedPosts = [...posts];
      updatedPosts[index] = {
        ...updatedPosts[index],
        'isLiked': !updatedPosts[index]['isLiked'],
        'likes': updatedPosts[index]['isLiked'] 
            ? updatedPosts[index]['likes'] - 1 
            : updatedPosts[index]['likes'] + 1,
      };
      
      ref.read(postsProvider.notifier).state = updatedPosts;
    }
  }

  void _toggleSave(Map<String, dynamic> post) {
    final posts = ref.read(postsProvider);
    final index = posts.indexWhere((p) => p['id'] == post['id']);
    
    if (index != -1) {
      final updatedPosts = [...posts];
      updatedPosts[index] = {
        ...updatedPosts[index],
        'isSaved': !updatedPosts[index]['isSaved'],
      };
      
      ref.read(postsProvider.notifier).state = updatedPosts;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            updatedPosts[index]['isSaved'] 
                ? 'Post saved to collection' 
                : 'Post removed from collection'
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _showPostDetails(Map<String, dynamic> post) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(post: post),
      ),
    );
  }
}

// Search delegate for exploring styles
class StyleSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = [
      'Summer outfits',
      'Casual wear',
      'Business casual',
      'Evening dresses',
      'Vintage style',
    ];
    
    final filteredSuggestions = query.isEmpty
        ? suggestions
        : suggestions.where((s) => s.toLowerCase().contains(query.toLowerCase())).toList();
    
    return ListView.builder(
      itemCount: filteredSuggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.search),
          title: Text(filteredSuggestions[index]),
          onTap: () {
            query = filteredSuggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}

// Simple Post Detail Screen
class PostDetailScreen extends ConsumerWidget {
  final Map<String, dynamic> post;
  
  const PostDetailScreen({super.key, required this.post});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          post['username'],
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Image.network(
              post['image'],
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            
            // User info and actions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post['userImage']),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['username'],
                        style: TextStyle(
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
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      post['isLiked'] ? Icons.favorite : Icons.favorite_border,
                      color: post['isLiked'] ? Colors.red : null,
                    ),
                    onPressed: () {
                      // Logic to handle like
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      post['isSaved'] ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    onPressed: () {
                      // Logic to handle save
                    },
                  ),
                ],
              ),
            ),
            
            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                post['description'],
                style: TextStyle(fontSize: 16),
              ),
            ),
            
            // Stats
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.favorite, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    '${post['likes']} likes',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    '${post['comments']} comments',
                    style: TextStyle(
                      color: Colors.grey[600],
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
}

// Simplified Create Post Sheet
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _createPost() {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    // Simulate upload
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isUploading = false;
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post uploaded successfully!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'New Post',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _isUploading ? null : _createPost,
                  child: _isUploading
                    ? SizedBox(
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                ),
              ],
            ),
          ),
          
          // Image selection
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 200,
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
                        size: 50,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Tap to select a photo',
                        style: TextStyle(
                          color: Colors.grey[600],
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
              decoration: InputDecoration(
                hintText: 'Write a caption...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
} 