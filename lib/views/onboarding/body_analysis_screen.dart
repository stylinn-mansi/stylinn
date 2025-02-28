import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/themes.dart';
import 'style_preferences_screen.dart';

// Provider to store user body analysis data
final bodyAnalysisProvider = StateProvider<Map<String, dynamic>>((ref) => {
  'bodyType': null,
  'skinTone': null,
  'eyeColor': null,
  'hairColor': null,
  'height': null,
  'weight': null,
});

class BodyAnalysisScreen extends ConsumerStatefulWidget {
  const BodyAnalysisScreen({super.key});

  @override
  ConsumerState<BodyAnalysisScreen> createState() => _BodyAnalysisScreenState();
}

class _BodyAnalysisScreenState extends ConsumerState<BodyAnalysisScreen> with SingleTickerProviderStateMixin {
  File? _imageFile;
  bool _isAnalyzing = false;
  bool _analysisComplete = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Mock analysis results
  final Map<String, dynamic> _analysisResults = {
    'bodyType': 'Hourglass',
    'skinTone': 'Medium',
    'eyeColor': 'Brown',
    'hairColor': 'Black',
    'height': '5\'6"',
    'weight': '130 lbs',
  };

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _isAnalyzing = false;
        _analysisComplete = false;
      });
    }
  }

  void _analyzeImage() {
    if (_imageFile == null) return;
    
    setState(() {
      _isAnalyzing = true;
    });
    
    // Simulate AI analysis with a delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
          _analysisComplete = true;
        });
        
        // Store the analysis results in the provider
        ref.read(bodyAnalysisProvider.notifier).state = _analysisResults;
        
        // Start the fade-in animation
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Body Analysis',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
              background: Container(
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
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's Analyze Your Body Type",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Upload a full-length mirror selfie and our AI will detect your body shape, skin tone, and more.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildImageSection(),
                  const SizedBox(height: 24),
                  if (_isAnalyzing) _buildAnalyzingIndicator(),
                  if (_analysisComplete) _buildAnalysisResults(),
                  if (!(_imageFile == null) && !_isAnalyzing && !_analysisComplete)
                    _buildInstructions(),
                  const SizedBox(height: 32),
                  _buildBottomButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return GestureDetector(
      onTap: () => _showImageSourceDialog(),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _imageFile != null 
                ? AppTheme.primaryGold 
                : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: _imageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_a_photo,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
            Text(
                    'Tap to upload a full-length photo',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyzingIndicator() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
        ),
        const SizedBox(height: 20),
        Text(
          'Analyzing your photo...',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Our AI is detecting your body shape, skin tone, and features',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisResults() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGold.withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.check_circle,
                color: AppTheme.primaryGold,
                size: 36,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Analysis Complete!',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildResultItem('Body Shape', _analysisResults['bodyType']),
          _buildResultItem('Skin Tone', _analysisResults['skinTone']),
          _buildResultItem('Eye Color', _analysisResults['eyeColor']),
          _buildResultItem('Hair Color', _analysisResults['hairColor']),
          _buildResultItem('Estimated Height', _analysisResults['height']),
          _buildResultItem('Estimated Weight', _analysisResults['weight']),
          const SizedBox(height: 16),
          Center(
            child: TextButton.icon(
              onPressed: () => _showImageSourceDialog(),
              icon: Icon(
                Icons.refresh,
                color: AppTheme.primaryGold,
                size: 18,
              ),
              label: Text(
                'Retake Photo',
                style: TextStyle(
                  color: AppTheme.primaryGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions() {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'How it works:',
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        _buildInstructionStep(
          '1',
          'Take a full-length mirror selfie in fitted clothing',
          Icons.photo_camera_outlined,
        ),
        _buildInstructionStep(
          '2',
          'Stand straight with arms slightly away from body',
          Icons.accessibility_new_outlined,
        ),
        _buildInstructionStep(
          '3',
          'Our AI will analyze your body shape and features',
          Icons.auto_awesome_outlined,
        ),
        _buildInstructionStep(
          '4',
          'Get personalized style recommendations',
          Icons.checkroom_outlined,
        ),
      ],
    );
  }

  Widget _buildInstructionStep(String number, String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                    style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                      ),
                    ),
                  ),
          const SizedBox(width: 16),
          Expanded(
                  child: Text(
              text,
                    style: TextStyle(
                color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
          Icon(
            icon,
            color: Colors.grey[500],
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    if (_imageFile == null) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () => _showImageSourceDialog(),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGold,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Upload Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else if (_isAnalyzing) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.grey[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Analyzing...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else if (_analysisComplete) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            // Navigate to next screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StylePreferencesScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGold,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _analyzeImage,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGold,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            'Analyze Photo',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Upload Photo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildImageSourceOption(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                _buildImageSourceOption(
                  icon: Icons.photo_library,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryGold,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 