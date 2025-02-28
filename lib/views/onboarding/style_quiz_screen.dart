import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/onboarding_layout.dart';
import '../../core/themes.dart';

class StyleQuizScreen extends ConsumerStatefulWidget {
  const StyleQuizScreen({super.key});

  @override
  ConsumerState<StyleQuizScreen> createState() => _StyleQuizScreenState();
}

class _StyleQuizScreenState extends ConsumerState<StyleQuizScreen> {
  int _currentQuestionIndex = 0;
  final List<Map<String, dynamic>> _answers = [];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What\'s your preferred style?',
      'type': 'single_choice',
      'options': [
        {
          'title': 'Casual Chic',
          'icon': Icons.weekend_outlined,
          'description': 'Comfortable yet stylish everyday wear',
        },
        {
          'title': 'Professional',
          'icon': Icons.business_center_outlined,
          'description': 'Polished and sophisticated workwear',
        },
        {
          'title': 'Trendy',
          'icon': Icons.trending_up,
          'description': 'Latest fashion trends and statements',
        },
        {
          'title': 'Classic',
          'icon': Icons.watch_outlined,
          'description': 'Timeless and elegant pieces',
        },
      ],
    },
    {
      'question': 'What colors do you prefer?',
      'type': 'multiple_choice',
      'options': [
        {
          'title': 'Neutrals',
          'icon': Icons.circle_outlined,
          'color': Colors.brown[200],
        },
        {
          'title': 'Pastels',
          'icon': Icons.circle_outlined,
          'color': Colors.pink[100],
        },
        {
          'title': 'Bold',
          'icon': Icons.circle_outlined,
          'color': Colors.red,
        },
        {
          'title': 'Monochrome',
          'icon': Icons.circle_outlined,
          'color': Colors.grey,
        },
      ],
    },
    {
      'question': 'What\'s your budget per item?',
      'type': 'single_choice',
      'options': [
        {
          'title': 'Budget',
          'icon': Icons.attach_money,
          'description': '\$25-\$50',
        },
        {
          'title': 'Mid-Range',
          'icon': Icons.attach_money,
          'description': '\$50-\$150',
        },
        {
          'title': 'Premium',
          'icon': Icons.attach_money,
          'description': '\$150-\$300',
        },
        {
          'title': 'Luxury',
          'icon': Icons.attach_money,
          'description': '\$300+',
        },
      ],
    },
  ];

  void _handleAnswer(Map<String, dynamic> answer) {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        if (_answers.length > _currentQuestionIndex) {
          _answers[_currentQuestionIndex] = answer;
        } else {
          _answers.add(answer);
        }
        _currentQuestionIndex++;
      });
    } else {
      // Last question
      if (_answers.length > _currentQuestionIndex) {
        _answers[_currentQuestionIndex] = answer;
      } else {
        _answers.add(answer);
      }
      // Navigate to body analysis
      Navigator.pushNamed(context, '/body-analysis');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentQuestion = _questions[_currentQuestionIndex];

    return OnboardingLayout(
      title: 'Style Quiz',
      subtitle: 'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Progress Indicator
          LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
            backgroundColor: AppTheme.darkSecondary,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryGold),
          ),
          const SizedBox(height: 32),
          // Question
          Text(
            currentQuestion['question'],
            style: theme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.lightText,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          // Options
          Expanded(
            child: ListView.separated(
              itemCount: currentQuestion['options'].length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final option = currentQuestion['options'][index];
                return _QuizOption(
                  title: option['title'],
                  icon: option['icon'],
                  description: option['description'],
                  color: option['color'],
                  onTap: () => _handleAnswer({
                    'question': currentQuestion['question'],
                    'answer': option['title'],
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _QuizOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final String? description;
  final Color? color;
  final VoidCallback onTap;

  const _QuizOption({
    required this.title,
    required this.icon,
    this.description,
    this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.darkSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.primaryGold.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color ?? AppTheme.darkPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color == null ? AppTheme.primaryGold : Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: TextStyle(
                        color: AppTheme.lightText.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.primaryGold,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
} 