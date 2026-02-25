import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../components/search_bar.dart';
import '../components/employee_card.dart';
import '../controllers/user_controller.dart';
import '../screens/employee_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final UserController userController = Get.find();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Focus on search field when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    userController.clearSearch();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (query.trim().isEmpty) {
      userController.clearSearch();
    } else {
      // Debounce search
      Future.delayed(const Duration(milliseconds: 500), () {
        if (_searchController.text == query) {
          userController.searchUsers(query);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.gray800,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.gray700),
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  style: const TextStyle(color: AppColors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search employees...',
                    hintStyle: TextStyle(color: AppColors.gray400),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.gray400,
                    ),
                  ),
                  onChanged: _onSearchChanged,
                  onSubmitted: (query) {
                    if (query.trim().isNotEmpty) {
                      userController.searchUsers(query);
                    }
                  },
                ),
              ),
            ),

            // Search Results
            Expanded(
              child: Obx(() {
                // Show loading indicator while searching
                if (userController.isSearching.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.accent),
                    ),
                  );
                }

                // Show initial state
                if (userController.searchQuery.value.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 80,
                          color: AppColors.gray400,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Search employees with their\nName and Employee ID',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.gray400,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                // Show no results
                if (userController.searchResults.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 80,
                          color: AppColors.gray400,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'No results found for "${userController.searchQuery.value}"',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.gray400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Try searching with different keywords',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.gray500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Show search results
                return ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: userController.searchResults.length,
                  itemBuilder: (context, index) {
                    final user = userController.searchResults[index];
                    return EmployeeCard(
                      user: user,
                      onTap: () {
                        Get.to(() => EmployeeDetailsScreen(user: user));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
