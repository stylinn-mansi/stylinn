import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import 'product_details_screen.dart';

class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key});

  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen>
    with SingleTickerProviderStateMixin {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSearching = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'logo': null},
    {'name': 'Nike', 'logo': 'assets/images/brands/nike.png'},
    {'name': 'Adidas', 'logo': 'assets/images/brands/adidas.png'},
    {'name': 'Zara', 'logo': 'assets/images/brands/zara.png'},
    {'name': 'H&M', 'logo': 'assets/images/brands/h&m.png'},
    {'name': 'Fila', 'logo': 'assets/images/brands/fila.png'},
  ];

  // Mock products data
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Premium Cotton T-Shirt',
      'brand': 'Nike',
      'price': 2499,
      'rating': 4.5,
      'reviews': 128,
      'image': 'assets/images/top.png',
      'description': 'Premium quality cotton t-shirt with a comfortable fit.',
      'sizes': ['S', 'M', 'L', 'XL'],
      'colors': ['White', 'Black', 'Gray'],
      'isFavorite': false,
      'isNew': true,
      'discount': 0,
      'category': 'Tops',
      'isTrending': true,
    },
    {
      'name': 'Floral Summer Dress',
      'brand': 'Zara',
      'price': 5999,
      'rating': 4.8,
      'reviews': 256,
      'image': 'assets/images/dress.png',
      'description': 'Beautiful floral dress perfect for summer occasions.',
      'sizes': ['XS', 'S', 'M', 'L'],
      'colors': ['Blue', 'Pink', 'Yellow'],
      'isFavorite': true,
      'isNew': false,
      'discount': 15,
      'category': 'Dresses',
      'isTrending': false,
    },
    {
      'name': 'Classic Denim Jeans',
      'brand': 'H&M',
      'price': 3999,
      'rating': 4.3,
      'reviews': 189,
      'image': 'assets/images/top1.png',
      'description': 'Classic denim jeans with a comfortable fit.',
      'sizes': ['28', '30', '32', '34'],
      'colors': ['Blue', 'Black'],
      'isFavorite': false,
      'isNew': false,
      'discount': 0,
      'category': 'Bottoms',
      'isTrending': false,
    },
    {
      'name': 'Casual Sneakers',
      'brand': 'Adidas',
      'price': 7999,
      'rating': 4.6,
      'reviews': 210,
      'image': 'assets/images/dress1.png',
      'description': 'Comfortable casual sneakers for everyday wear.',
      'sizes': ['7', '8', '9', '10', '11'],
      'colors': ['White', 'Black', 'Gray', 'Red'],
      'isFavorite': false,
      'isNew': true,
      'discount': 10,
      'category': 'Footwear',
      'isTrending': true,
    },
    {
      'name': 'Sport Track Pants',
      'brand': 'Fila',
      'price': 3499,
      'rating': 4.2,
      'reviews': 156,
      'image': 'assets/images/top.png',
      'description': 'Comfortable track pants for sports and casual wear.',
      'sizes': ['S', 'M', 'L', 'XL'],
      'colors': ['Black', 'Navy', 'Gray'],
      'isFavorite': false,
      'isNew': false,
      'discount': 5,
      'category': 'Activewear',
      'isTrending': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredProducts {
    List<Map<String, dynamic>> result = _products;

    // Filter by category
    if (_selectedCategory != 'All') {
      result = result
          .where((product) => product['brand'] == _selectedCategory)
          .toList();
    }

    // Filter by search query
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      result = result
          .where((product) =>
              product['name'].toLowerCase().contains(query) ||
              product['brand'].toLowerCase().contains(query))
          .toList();
    }

    return result;
  }

  void _toggleFavorite(int index) {
    final productName = _filteredProducts[index]['name'];
    final productIndex = _products.indexWhere((p) => p['name'] == productName);

    if (productIndex != -1) {
      setState(() {
        _products[productIndex]['isFavorite'] =
            !_products[productIndex]['isFavorite'];
      });

      // Show a snackbar
      final isFavorite = _products[productIndex]['isFavorite'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isFavorite ? 'Added to favorites' : 'Removed from favorites',
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              // Navigate to favorites
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                floating: true,
                snap: true,
                pinned: false,
                backgroundColor: Colors.white,
                elevation: 0,
                title: _isSearching
                    ? TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        style: const TextStyle(color: Colors.black),
                        onChanged: (_) => setState(() {}),
                        autofocus: true,
                      )
                    : Row(
                        children: [
                          Text(
                            'Stylinn',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                actions: [
                  IconButton(
                    icon: Icon(
                      _isSearching ? Icons.close : Icons.search,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        if (!_isSearching) {
                          _searchController.clear();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Navigate to cart
                    },
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // AI Stylist Banner
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Message AI Stylist to get outfit you\'re dreaming of',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red[400],
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 10,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text('GET OUTFIT'),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      width: 40,
                                      height: 60,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[400],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Top Trends Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Top Trends for You',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'View all',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category['name'] == _selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category['name'];
                              _animationController.reset();
                              _animationController.forward();
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.primaryGold.withOpacity(0.1)
                                      : Colors.grey[100],
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.primaryGold
                                        : Colors.transparent,
                                    width: 1,
                                  ),
                                ),
                                child: category['logo'] != null
                                    ? Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Image.asset(
                                          category['logo'],
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : Icon(
                                        Icons.apps,
                                        color: isSelected
                                            ? AppTheme.primaryGold
                                            : Colors.grey[600],
                                        size: 24,
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category['name'],
                                style: TextStyle(
                                  color: isSelected
                                      ? AppTheme.primaryGold
                                      : Colors.black87,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ];
          },
          body: _filteredProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No products found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try a different search or category',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedCategory = 'All';
                            _searchController.clear();
                            _isSearching = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGold,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Clear Filters'),
                      ),
                    ],
                  ),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.56,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(product, index);
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner({
    required String title,
    required String subtitle,
    required String image,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
      ),
      child: Stack(
        children: [
          Positioned(
            right: 16,
            bottom: 16,
            top: 16,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryGold,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, int index) {
    final bool hasDiscount = product['discount'] > 0;
    final double discountedPrice =
        product['price'] * (1 - product['discount'] / 100);
    final bool isTrending = product['isTrending'] ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 0.80,
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100],
                    image: DecorationImage(
                      image: AssetImage(
                        product['image'],
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => _toggleFavorite(index),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      product['isFavorite']
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product['isFavorite'] ? Colors.red : Colors.black,
                      size: 16,
                    ),
                  ),
                ),
              ),
              if (product['isTrending'])
                Positioned(
                  bottom: 8,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.red[400],
                          size: 16,
                        ),
                        const SizedBox(width: 2),
                        const Text(
                          'In Trend',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          // Brand
          Text(
            product['brand'],
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black38,
            ),
          ),
          const SizedBox(height: 4),
          //Product Name
          Text(
            product['name'],
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Price
          Text(
            hasDiscount
                ? '₹${discountedPrice.toInt()}'
                : '₹${product['price']}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: hasDiscount ? Colors.red[400] : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
