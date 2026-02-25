import 'package:flutter/material.dart';
import '../app_colors.dart';

class CustomSearchBar extends StatelessWidget {
  final VoidCallback? onPressed;
  final String placeholder;

  const CustomSearchBar({
    super.key,
    this.onPressed,
    this.placeholder = 'Search for a movie',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.secondary.withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.accent.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Image.asset(
              'assets/images/search.png',
              width: 20,
              height: 20,
              color: AppColors.accent,
            ),
            const SizedBox(width: 15),
            Text(
              placeholder,
              style: TextStyle(
                color: AppColors.accent.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
