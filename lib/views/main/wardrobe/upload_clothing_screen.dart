import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class UploadClothingScreen extends ConsumerStatefulWidget {
  const UploadClothingScreen({super.key});

  @override
  ConsumerState<UploadClothingScreen> createState() => _UploadClothingScreenState();
}

class _UploadClothingScreenState extends ConsumerState<UploadClothingScreen> {
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  String _selectedCategory = '';
  String _selectedSubCategory = '';
  final List<String> _selectedColors = [];
  final List<String> _selectedOccasions = [];

  final Map<String, List<String>> _categoryMap = {
    'Tops': ['T-Shirt', 'Shirt', 'Sweater', 'Blouse', 'Tank Top'],
    'Bottoms': ['Jeans', 'Pants', 'Shorts', 'Skirts'],
    'Dresses': ['Mini', 'Midi', 'Maxi', 'Formal'],
    'Outerwear': ['Jacket', 'Coat', 'Blazer', 'Hoodie'],
    'Shoes': ['Sneakers', 'Boots', 'Heels', 'Sandals'],
    'Accessories': ['Bags', 'Jewelry', 'Belts', 'Scarves'],
  };

  final List<Color> _availableColors = [
    Colors.black,
    Colors.white,
    Colors.grey,
    Colors.brown,
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  final List<String> _occasions = [
    'Casual',
    'Formal',
    'Business',
    'Party',
    'Sport',
    'Beach',
    'Travel',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      appBar: AppBar(
        title: const Text('Add Clothing Item'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Upload
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryGold.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 48,
                      color: AppTheme.lightText.withOpacity(0.7),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to add photo',
                      style: TextStyle(
                        color: AppTheme.lightText.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Basic Info
            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppTheme.lightText),
              decoration: const InputDecoration(
                labelText: 'Item Name',
                hintText: 'e.g., Black Cotton T-Shirt',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _brandController,
              style: const TextStyle(color: AppTheme.lightText),
              decoration: const InputDecoration(
                labelText: 'Brand (Optional)',
                hintText: 'e.g., Nike',
              ),
            ),
            const SizedBox(height: 24),
            // Category Selection
            const Text(
              'Category',
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categoryMap.keys.map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : '';
                      _selectedSubCategory = '';
                    });
                  },
                  backgroundColor: AppTheme.darkSecondary,
                  selectedColor: AppTheme.primaryGold,
                  labelStyle: TextStyle(
                    color: _selectedCategory == category
                        ? AppTheme.darkPrimary
                        : AppTheme.lightText,
                  ),
                );
              }).toList(),
            ),
            if (_selectedCategory.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text(
                'Subcategory',
                style: TextStyle(
                  color: AppTheme.lightText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _categoryMap[_selectedCategory]!.map((subCategory) {
                  return ChoiceChip(
                    label: Text(subCategory),
                    selected: _selectedSubCategory == subCategory,
                    onSelected: (selected) {
                      setState(() {
                        _selectedSubCategory = selected ? subCategory : '';
                      });
                    },
                    backgroundColor: AppTheme.darkSecondary,
                    selectedColor: AppTheme.primaryGold,
                    labelStyle: TextStyle(
                      color: _selectedSubCategory == subCategory
                          ? AppTheme.darkPrimary
                          : AppTheme.lightText,
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 24),
            // Color Selection
            const Text(
              'Colors',
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableColors.map((color) {
                return _ColorOption(
                  color: color,
                  isSelected: _selectedColors.contains(color.value.toString()),
                  onTap: () {
                    setState(() {
                      final colorString = color.value.toString();
                      if (_selectedColors.contains(colorString)) {
                        _selectedColors.remove(colorString);
                      } else {
                        _selectedColors.add(colorString);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            // Occasions
            const Text(
              'Occasions',
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _occasions.map((occasion) {
                return FilterChip(
                  label: Text(occasion),
                  selected: _selectedOccasions.contains(occasion),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedOccasions.add(occasion);
                      } else {
                        _selectedOccasions.remove(occasion);
                      }
                    });
                  },
                  backgroundColor: AppTheme.darkSecondary,
                  selectedColor: AppTheme.primaryGold,
                  checkmarkColor: AppTheme.darkPrimary,
                  labelStyle: TextStyle(
                    color: _selectedOccasions.contains(occasion)
                        ? AppTheme.darkPrimary
                        : AppTheme.lightText,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: 'Save Item',
              onPressed: () {
                // Save item logic
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorOption({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppTheme.primaryGold : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              )
            : null,
      ),
    );
  }
} 