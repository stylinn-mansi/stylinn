import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class TryOnScreen extends ConsumerStatefulWidget {
  const TryOnScreen({super.key});

  @override
  ConsumerState<TryOnScreen> createState() => _TryOnScreenState();
}

class _TryOnScreenState extends ConsumerState<TryOnScreen> {
  // Mock model photo - replace with actual photo selection logic
  final String _modelPhoto = 'assets/images/model_placeholder.png';
  bool _isModelSelected = false;

  // Selected clothing item to try on
  Map<String, dynamic>? _selectedItem;

  // Mock clothing items
  final List<Map<String, dynamic>> _clothingItems = [
    {
      'name': 'Casual White Top',
      'category': 'Tops',
      'image': 'assets/images/top.png',
      'offset': const Offset(0, 100), // Default position on model
      'scale': 1.0,
    },
    {
      'name': 'Floral Dress',
      'category': 'Dresses',
      'image': 'assets/images/dress.png',
      'offset': const Offset(0, 80),
      'scale': 1.0,
    },
    {
      'name': 'Evening Dress',
      'category': 'Dresses',
      'image': 'assets/images/dress1.png',
      'offset': const Offset(0, 80),
      'scale': 1.0,
    },
  ];

  // Current position and scale of the selected item
  Offset _currentOffset = Offset.zero;
  double _currentScale = 1.0;
  Offset? _lastFocalPoint;

  void _onScaleStart(ScaleStartDetails details) {
    _lastFocalPoint = details.focalPoint;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (_selectedItem != null) {
      setState(() {
        // Handle scaling
        _currentScale = (_currentScale * details.scale).clamp(0.5, 2.0);
        
        // Handle translation
        if (_lastFocalPoint != null) {
          _currentOffset += details.focalPoint - _lastFocalPoint!;
          _lastFocalPoint = details.focalPoint;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Virtual Try-On',
          style: TextStyle(
            color: AppTheme.lightText,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Save the current try-on
            },
            icon: const Icon(
              Icons.save_outlined,
              color: AppTheme.lightText,
            ),
          ),
          IconButton(
            onPressed: () {
              // Share the current try-on
            },
            icon: const Icon(
              Icons.share_outlined,
              color: AppTheme.lightText,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Try-On Area
          Expanded(
            flex: 3,
            child: GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.darkSecondary,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.primaryGold.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Model Photo or Upload Prompt
                    if (!_isModelSelected)
                      _UploadPrompt(
                        onTap: () {
                          // Handle model photo upload
                          setState(() {
                            _isModelSelected = true;
                          });
                        },
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          _modelPhoto,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    // Selected Clothing Item
                    if (_selectedItem != null)
                      Positioned(
                        left: _currentOffset.dx,
                        top: _currentOffset.dy,
                        child: Transform.scale(
                          scale: _currentScale,
                          child: Image.asset(
                            _selectedItem!['image'],
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    // Instructions Overlay
                    if (_selectedItem != null)
                      Positioned(
                        top: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.darkPrimary.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.touch_app,
                                color: AppTheme.lightText,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Drag to position • Pinch to resize',
                                style: TextStyle(
                                  color: AppTheme.lightText,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Clothing Items Selection
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppTheme.darkSecondary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Text(
                        'Select Item to Try On',
                        style: TextStyle(
                          color: AppTheme.lightText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      if (_selectedItem != null)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedItem = null;
                              _currentOffset = Offset.zero;
                              _currentScale = 1.0;
                            });
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 16,
                          ),
                          label: const Text('Reset'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primaryGold,
                          ),
                        ),
                    ],
                  ),
                ),
                // Items List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _clothingItems.length,
                    itemBuilder: (context, index) {
                      final item = _clothingItems[index];
                      final isSelected = _selectedItem == item;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedItem = item;
                            _currentOffset = item['offset'];
                            _currentScale = item['scale'];
                          });
                        },
                        child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryGold
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    item['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primaryGold,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadPrompt extends StatelessWidget {
  final VoidCallback onTap;

  const _UploadPrompt({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.darkTertiary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryGold.withOpacity(0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_a_photo,
              color: AppTheme.primaryGold,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Upload Your Photo',
              style: TextStyle(
                color: AppTheme.lightText,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'For best results, use a full-body photo\nwith a neutral background',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppTheme.lightText.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 