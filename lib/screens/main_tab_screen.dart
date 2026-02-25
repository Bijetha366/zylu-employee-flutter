import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Container(
            height: 65,
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 40,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.95),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, -5),
                ),
              ],
              border: Border.all(
                color: AppColors.accent.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, 'home.png', 'Home'),
                _buildNavItem(1, 'search.png', 'Search'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconName, String label) {
    bool isActive = _currentIndex == index;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: isActive ? 100 : 60,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: isActive
              ? AppColors.accent.withOpacity(0.2)
              : Colors.transparent,
          border: isActive
              ? Border.all(
                  color: AppColors.accent.withOpacity(0.5),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.all(isActive ? 6 : 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: isActive
                    ? AppColors.accent.withOpacity(0.3)
                    : Colors.transparent,
              ),
              child: Image.asset(
                'assets/images/$iconName',
                width: isActive ? 16 : 14,
                height: isActive ? 16 : 14,
                fit: BoxFit.contain,
                color: isActive
                    ? AppColors.accent
                    : const Color(0xFFA8B5DB),
              ),
            ),
            if (isActive) ...[
              const SizedBox(width: 4),
              Flexible(
                child: AnimatedOpacity(
                  opacity: isActive ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
