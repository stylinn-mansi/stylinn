import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  String _selectedSize = '';
  String _selectedColor = '';
  int _quantity = 1;

  // Mock similar products
  final List<Map<String, dynamic>> _similarProducts = [
    {
      'name': 'V-Neck T-Shirt',
      'brand': 'Nike',
      'price': 24.99,
      'rating': 4.3,
      'image': 'assets/images/top1.png',
    },
    {
      'name': 'Sport T-Shirt',
      'brand': 'Adidas',
      'price': 29.99,
      'rating': 4.6,
      'image': 'assets/images/top.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    if (widget.product['sizes'].isNotEmpty) {
      _selectedSize = widget.product['sizes'][0];
    }
    if (widget.product['colors'].isNotEmpty) {
      _selectedColor = widget.product['colors'][0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      body: CustomScrollView(
        slivers: [
          // Product Image with App Bar
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.product['image'],
                fit: BoxFit.cover,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Toggle favorite
                },
                icon: const Icon(
                  Icons.favorite_border,
                  color: AppTheme.darkPrimary,
                ),
              ),
              IconButton(
                onPressed: () {
                  // Share product
                },
                icon: const Icon(
                  Icons.share,
                  color: AppTheme.darkPrimary,
                ),
              ),
            ],
          ),
          // Product Details
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand and Name
                  Text(
                    widget.product['brand'],
                    style: const TextStyle(
                      color: AppTheme.primaryGold,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.product['name'],
                    style: const TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Rating and Reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppTheme.primaryGold,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.product['rating'].toString(),
                        style: const TextStyle(
                          color: AppTheme.lightText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${widget.product['reviews']} Reviews)',
                        style: TextStyle(
                          color: AppTheme.lightText.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${widget.product['price']}',
                        style: const TextStyle(
                          color: AppTheme.primaryGold,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.darkSecondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                              icon: const Icon(Icons.remove),
                              color: AppTheme.lightText,
                            ),
                            Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                color: AppTheme.lightText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() => _quantity++);
                              },
                              icon: const Icon(Icons.add),
                              color: AppTheme.lightText,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Size Selection
                  const Text(
                    'Select Size',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.product['sizes'].map<Widget>((size) {
                      final isSelected = size == _selectedSize;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryGold : AppTheme.darkSecondary,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryGold : AppTheme.lightText.withOpacity(0.2),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Color Selection
                  const Text(
                    'Select Color',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.product['colors'].map<Widget>((color) {
                      final isSelected = color == _selectedColor;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? AppTheme.primaryGold : AppTheme.darkSecondary,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isSelected ? AppTheme.primaryGold : AppTheme.lightText.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            color,
                            style: TextStyle(
                              color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.product['description'],
                    style: TextStyle(
                      color: AppTheme.lightText.withOpacity(0.7),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Similar Products
                  const Text(
                    'You May Also Like',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _similarProducts.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final product = _similarProducts[index];
                        return _SimilarProductCard(product: product);
                      },
                    ),
                  ),
                  const SizedBox(height: 100), // Bottom padding for FAB
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GradientButton(
          text: 'Add to Cart - \$${(widget.product['price'] * _quantity).toStringAsFixed(2)}',
          onPressed: () {
            // Add to cart logic
          },
          width: double.infinity,
          height: 56,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _SimilarProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const _SimilarProductCard({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppTheme.darkSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(product['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Product Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['brand'],
                  style: const TextStyle(
                    color: AppTheme.primaryGold,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product['name'],
                  style: const TextStyle(
                    color: AppTheme.lightText,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(
                    color: AppTheme.primaryGold,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 