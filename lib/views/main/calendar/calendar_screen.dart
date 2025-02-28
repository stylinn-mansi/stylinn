import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/themes.dart';
import '../../../widgets/gradient_button.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedView = 'Month';
  final List<String> _viewOptions = ['Month', 'Week', 'Day'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkPrimary,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Text(
                    'Calendar',
                    style: TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  // View Toggle
                  SegmentedButton<String>(
                    segments: _viewOptions.map((view) {
                      return ButtonSegment<String>(
                        value: view,
                        label: Text(view),
                      );
                    }).toList(),
                    selected: {_selectedView},
                    onSelectionChanged: (Set<String> selection) {
                      setState(() {
                        _selectedView = selection.first;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppTheme.primaryGold;
                          }
                          return AppTheme.darkSecondary;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Calendar Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      // Previous month/week/day
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: AppTheme.lightText,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'September 2023', // Replace with actual date
                    style: const TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      // Next month/week/day
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      color: AppTheme.lightText,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Calendar Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 35, // 5 weeks * 7 days
                itemBuilder: (context, index) {
                  return _CalendarDay(
                    date: index + 1,
                    isSelected: index + 1 == _selectedDate.day,
                    hasEvent: index % 3 == 0,
                    onTap: () {
                      setState(() {
                        _selectedDate = DateTime(
                          _selectedDate.year,
                          _selectedDate.month,
                          index + 1,
                        );
                      });
                    },
                  );
                },
              ),
            ),
            // Events List
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.darkSecondary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Events for ${_selectedDate.day}',
                    style: const TextStyle(
                      color: AppTheme.lightText,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 3,
                      separatorBuilder: (context, index) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return _EventCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GradientButton(
        text: 'Add Event',
        onPressed: () {
          // Navigate to add event screen
        },
        width: 120,
        height: 44,
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final int date;
  final bool isSelected;
  final bool hasEvent;
  final VoidCallback onTap;

  const _CalendarDay({
    required this.date,
    required this.isSelected,
    required this.hasEvent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryGold : AppTheme.darkSecondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                date.toString(),
                style: TextStyle(
                  color: isSelected ? AppTheme.darkPrimary : AppTheme.lightText,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            if (hasEvent)
              Positioned(
                bottom: 4,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.darkPrimary : AppTheme.primaryGold,
                      shape: BoxShape.circle,
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

class _EventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.darkTertiary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryGold,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Casual Outfit',
                  style: TextStyle(
                    color: AppTheme.lightText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '9:00 AM - Work',
                  style: TextStyle(
                    color: AppTheme.lightText.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.style,
            color: AppTheme.lightText.withOpacity(0.7),
          ),
        ],
      ),
    );
  }
} 