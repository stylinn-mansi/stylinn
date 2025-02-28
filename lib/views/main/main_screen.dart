import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/themes.dart';
import 'wardrobe/wardrobe_screen.dart';
import 'explore/explore_screen.dart';
import 'discover/discover_screen.dart';
import 'shop/shop_screen.dart';
import 'profile/profile_screen.dart';

final selectedTabProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Light grey background
      body: IndexedStack(
        index: selectedTab,
        children: const [
          WardrobeScreen(),
          ExploreScreen(),
          DiscoverScreen(),
          ShopScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Iconsax.shop,
                  selectedIcon: Iconsax.shop,
                  label: 'Wardrobe',
                  isSelected: selectedTab == 0,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 0,
                ),
                _NavBarItem(
                  icon: Iconsax.search_normal,
                  selectedIcon: Iconsax.search_normal,
                  label: 'Explore',
                  isSelected: selectedTab == 1,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 1,
                ),
                _AINavBarItem(
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 2,
                  isSelected: selectedTab == 2,
                ),
                _NavBarItem(
                  icon: Iconsax.shopping_bag,
                  selectedIcon: Iconsax.shopping_bag,
                  label: 'Shop',
                  isSelected: selectedTab == 3,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 3,
                ),
                _NavBarItem(
                  icon: Iconsax.user,
                  selectedIcon: Iconsax.user,
                  label: 'Profile',
                  isSelected: selectedTab == 4,
                  onTap: () => ref.read(selectedTabProvider.notifier).state = 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? AppTheme.primaryGold : Colors.black87,
              size: 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryGold : Colors.black87,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AINavBarItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;

  const _AINavBarItem({
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isSelected
                      ? [Color(0xFF8A2BE2), Color(0xFF9370DB)]
                      : [Colors.grey.shade300, Colors.grey.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: Color(0xFF8A2BE2).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Center(
                child: Icon(
                  Icons.auto_fix_high,
                  color: isSelected ? Colors.white : Colors.black54,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'AI Style',
              style: TextStyle(
                color: isSelected ? AppTheme.primaryGold : Colors.black87,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 