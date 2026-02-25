import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_colors.dart';
import '../components/search_bar.dart';
import '../components/employee_card.dart';
import '../controllers/user_controller.dart';
import '../screens/employee_details_screen.dart';
import '../screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          // // Background image
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/bg.png',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // Content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomSearchBar(
                    placeholder: 'Search for a employee',
                    onPressed: () {
                      Get.to(() => const SearchScreen());
                    },
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Employee List
                Expanded(
                  child: Obx(() {
                    if (userController.isLoading.value &&
                        userController.users.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.accent,
                          ),
                        ),
                      );
                    }

                    if (userController.errorMessage.value.isNotEmpty &&
                        userController.users.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: AppColors.error,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              userController.errorMessage.value,
                              style: const TextStyle(color: AppColors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => userController.refreshUsers(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (userController.users.isEmpty) {
                      return const Center(
                        child: Text(
                          'No employees found',
                          style: TextStyle(color: AppColors.white),
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () => userController.refreshUsers(),
                      color: AppColors.accent,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: userController.users.length +
                            (userController.hasMore.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == userController.users.length) {
                            // Load more indicator - defer loadMore to avoid setState during build
                            if (userController.hasMore.value) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                userController.loadMore();
                              });
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.accent,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }

                          final user = userController.users[index];
                          return EmployeeCard(
                            user: user,
                            onTap: () {
                              Get.to(() => EmployeeDetailsScreen(user: user));
                            },
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
