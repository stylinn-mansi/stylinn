import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/themes.dart';
import '../../core/google_fonts_typography.dart';
import '../../models/user_style_profile.dart';

class StylePreference {
  final String id;
  final String text;
  bool isSelected;

  StylePreference({
    required this.id,
    required this.text,
    this.isSelected = false,
  });
}

// Provider to store the current question index
final currentQuestionIndexProvider = StateProvider<int>((ref) => 0);

// Provider to store the user's style profile
final userStyleProfileProvider = StateProvider<UserStyleProfile?>((ref) => null);

// Provider for style goals
final styleGoalsProvider = StateProvider<List<StylePreference>>((ref) {
  return [
    StylePreference(id: 'natural_features', text: 'Learning how to complement my natural features'),
    StylePreference(id: 'chic', text: 'Looking chic and fashionable'),
    StylePreference(id: 'stand_out', text: 'Standing out from the crowd'),
    StylePreference(id: 'smart_shopping', text: 'Shopping smart and buying less'),
  ];
});

// Provider for body types
final bodyTypesProvider = StateProvider<List<StylePreference>>((ref) {
  return [
    StylePreference(id: 'hourglass', text: 'Hourglass'),
    StylePreference(id: 'pear', text: 'Pear'),
    StylePreference(id: 'apple', text: 'Apple'),
    StylePreference(id: 'rectangle', text: 'Rectangle'),
    StylePreference(id: 'inverted_triangle', text: 'Inverted Triangle'),
  ];
});

// Provider for color preferences
final colorPreferencesProvider = StateProvider<List<StylePreference>>((ref) {
  return [
    StylePreference(id: 'neutrals', text: 'Neutrals (Black, White, Gray, Beige)'),
    StylePreference(id: 'pastels', text: 'Pastels (Soft Pink, Baby Blue, Mint)'),
    StylePreference(id: 'bold', text: 'Bold (Red, Royal Blue, Purple)'),
    StylePreference(id: 'earthy', text: 'Earthy (Brown, Olive, Terracotta)'),
    StylePreference(id: 'jewel_tones', text: 'Jewel Tones (Emerald, Sapphire, Ruby)'),
  ];
});

// Provider for budget ranges
final budgetRangesProvider = StateProvider<List<StylePreference>>((ref) {
  return [
    StylePreference(id: 'budget', text: 'Budget-friendly (₹1,000-₹5,000)'),
    StylePreference(id: 'mid_range', text: 'Mid-range (₹5,000-₹15,000)'),
    StylePreference(id: 'premium', text: 'Premium (₹15,000-₹30,000)'),
    StylePreference(id: 'luxury', text: 'Luxury (₹30,000+)'),
  ];
});

class StylePreferencesScreen extends ConsumerWidget {
  const StylePreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuestionIndex = ref.watch(currentQuestionIndexProvider);
    
    // List of questions to ask
    final questions = [
      "What's your main style goal?",
      "What's your body type?",
      "What colors do you prefer?",
      "What's your budget range?",
    ];

    // Get the appropriate options based on the current question
    List<StylePreference> currentOptions;
    switch (currentQuestionIndex) {
      case 0:
        currentOptions = ref.watch(styleGoalsProvider);
        break;
      case 1:
        currentOptions = ref.watch(bodyTypesProvider);
        break;
      case 2:
        currentOptions = ref.watch(colorPreferencesProvider);
        break;
      case 3:
        currentOptions = ref.watch(budgetRangesProvider);
        break;
      default:
        currentOptions = [];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: List.generate(
                  questions.length,
                  (index) => Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index <= currentQuestionIndex
                            ? AppTheme.primaryGold
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Question
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                questions[currentQuestionIndex],
                style: AppTypography.heading2.copyWith(
                  color: Colors.black,
                  fontWeight: AppTypography.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Options
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                itemCount: currentOptions.length,
                itemBuilder: (context, index) {
                  final preference = currentOptions[index];
                  return GestureDetector(
                    onTap: () {
                      // For single-selection questions (body type and budget)
                      if (currentQuestionIndex == 1 || currentQuestionIndex == 3) {
                        // Deselect all other options
                        final updatedOptions = currentOptions.map((p) => 
                          StylePreference(
                            id: p.id, 
                            text: p.text, 
                            isSelected: p.id == preference.id
                          )
                        ).toList();
                        
                        switch (currentQuestionIndex) {
                          case 1:
                            ref.read(bodyTypesProvider.notifier).state = updatedOptions;
                            break;
                          case 3:
                            ref.read(budgetRangesProvider.notifier).state = updatedOptions;
                            break;
                        }
                      } else {
                        // For multi-selection questions (style goals and colors)
                        final updatedOptions = [...currentOptions];
                        updatedOptions[index] = StylePreference(
                          id: preference.id,
                          text: preference.text,
                          isSelected: !preference.isSelected,
                        );
                        
                        switch (currentQuestionIndex) {
                          case 0:
                            ref.read(styleGoalsProvider.notifier).state = updatedOptions;
                            break;
                          case 2:
                            ref.read(colorPreferencesProvider.notifier).state = updatedOptions;
                            break;
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: preference.isSelected
                              ? AppTheme.primaryGold
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              preference.text,
                              style: AppTypography.bodyLarge.copyWith(
                                color: Colors.black87,
                                fontWeight: preference.isSelected
                                    ? AppTypography.semiBold
                                    : AppTypography.regular,
                              ),
                            ),
                          ),
                          if (preference.isSelected)
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryGold,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Next button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Check if at least one option is selected
                    bool hasSelection = false;
                    
                    switch (currentQuestionIndex) {
                      case 0:
                        hasSelection = ref.read(styleGoalsProvider).any((p) => p.isSelected);
                        break;
                      case 1:
                        hasSelection = ref.read(bodyTypesProvider).any((p) => p.isSelected);
                        break;
                      case 2:
                        hasSelection = ref.read(colorPreferencesProvider).any((p) => p.isSelected);
                        break;
                      case 3:
                        hasSelection = ref.read(budgetRangesProvider).any((p) => p.isSelected);
                        break;
                    }
                    
                    if (!hasSelection) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select at least one option'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    
                    // Move to next question or finish
                    if (currentQuestionIndex < questions.length - 1) {
                      ref.read(currentQuestionIndexProvider.notifier).state++;
                    } else {
                      // Save the user's style profile
                      final styleGoals = ref.read(styleGoalsProvider)
                          .where((p) => p.isSelected)
                          .map((p) => p.id)
                          .toList();
                          
                      final bodyType = ref.read(bodyTypesProvider)
                          .firstWhere((p) => p.isSelected, orElse: () => StylePreference(id: '', text: ''))
                          .id;
                          
                      final colors = ref.read(colorPreferencesProvider)
                          .where((p) => p.isSelected)
                          .map((p) => p.id)
                          .toList();
                          
                      final budget = ref.read(budgetRangesProvider)
                          .firstWhere((p) => p.isSelected, orElse: () => StylePreference(id: '', text: ''))
                          .id;
                      
                      final userProfile = UserStyleProfile(
                        styleGoal: styleGoals.isNotEmpty ? styleGoals.first : '',
                        bodyType: bodyType,
                        preferredColors: colors,
                        budgetRange: budget,
                      );
                      
                      ref.read(userStyleProfileProvider.notifier).state = userProfile;
                      
                      // Navigate to the next screen
                      Navigator.pushNamed(context, '/main');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGold,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentQuestionIndex == questions.length - 1 ? 'FINISH' : 'NEXT',
                        style: AppTypography.buttonText.copyWith(
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 