import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/onboarding_layout.dart';
import '../../widgets/gradient_button.dart';
import '../../core/themes.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final _nameController = TextEditingController();
  String _selectedGender = '';
  DateTime? _selectedDate;
  final List<String> _interests = [];

  final List<String> _availableInterests = [
    'Casual',
    'Formal',
    'Streetwear',
    'Vintage',
    'Minimalist',
    'Bohemian',
    'Athletic',
    'Business',
    'Party',
    'Beach',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AppTheme.primaryGold,
              onPrimary: AppTheme.darkPrimary,
              surface: AppTheme.darkSecondary,
              onSurface: AppTheme.lightText,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OnboardingLayout(
      title: 'Tell Us About You',
      subtitle: 'Help us personalize your styling experience',
      bottomWidget: GradientButton(
        text: 'Continue',
        onPressed: () {
          Navigator.pushNamed(context, '/style-quiz');
        },
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.darkSecondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.primaryGold,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      size: 50,
                      color: AppTheme.lightText,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryGold,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: AppTheme.darkPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Name Input
            TextField(
              controller: _nameController,
              style: const TextStyle(color: AppTheme.lightText),
              decoration: const InputDecoration(
                hintText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),
            const SizedBox(height: 24),
            // Gender Selection
            Text(
              'Gender',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _GenderOption(
                  icon: Icons.male,
                  label: 'Male',
                  isSelected: _selectedGender == 'Male',
                  onTap: () => setState(() => _selectedGender = 'Male'),
                ),
                const SizedBox(width: 16),
                _GenderOption(
                  icon: Icons.female,
                  label: 'Female',
                  isSelected: _selectedGender == 'Female',
                  onTap: () => setState(() => _selectedGender = 'Female'),
                ),
                const SizedBox(width: 16),
                _GenderOption(
                  icon: Icons.more_horiz,
                  label: 'Other',
                  isSelected: _selectedGender == 'Other',
                  onTap: () => setState(() => _selectedGender = 'Other'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Date of Birth
            Text(
              'Date of Birth',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.darkSecondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      color: AppTheme.lightText,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _selectedDate == null
                          ? 'Select Date'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightText,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Style Interests
            Text(
              'Style Interests',
              style: theme.textTheme.titleMedium?.copyWith(
                color: AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableInterests.map((interest) {
                final isSelected = _interests.contains(interest);
                return FilterChip(
                  label: Text(interest),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _interests.add(interest);
                      } else {
                        _interests.remove(interest);
                      }
                    });
                  },
                  backgroundColor: AppTheme.darkSecondary,
                  selectedColor: AppTheme.primaryGold,
                  checkmarkColor: AppTheme.darkPrimary,
                  labelStyle: TextStyle(
                    color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _GenderOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryGold : AppTheme.darkSecondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                size: 28,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 