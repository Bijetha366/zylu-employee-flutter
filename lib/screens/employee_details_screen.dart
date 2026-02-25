import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../app_colors.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final UserModel user;

  const EmployeeDetailsScreen({
    super.key,
    required this.user,
  });

  bool get _isVeteranEmployee =>
      user.getYearsWorked() > 5 && user.isActive;

  String _formatGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Male';
      case 'female':
        return 'Female';
      case 'other':
        return 'Other';
      default:
        return gender;
    }
  }

  @override
  Widget build(BuildContext context) {
    final yearsWorked = user.getYearsWorked();

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Employee Details',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
            child: Column(
              children: [
                // Profile Section
                Container(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      // Profile Image
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent,
                            width: 4,
                          ),
                        ),
                        child: ClipOval(
                          child: user.profile != null && user.profile!.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: user.profile!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    color: AppColors.gray700,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.accent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    color: AppColors.gray700,
                                    child: const Icon(
                                      Icons.person,
                                      color: AppColors.gray400,
                                      size: 80,
                                    ),
                                  ),
                                )
                              : Container(
                                  color: AppColors.gray700,
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.gray400,
                                    size: 80,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Name
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Employee ID
                      Text(
                        user.employeeId,
                        style: const TextStyle(
                          color: AppColors.gray400,
                          fontSize: 16,
                        ),
                      ),
                      if (_isVeteranEmployee) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.success.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.success,
                              width: 1.5,
                            ),
                          ),
                          child: const Text(
                            '5+ Years • Active',
                            style: TextStyle(
                              color: AppColors.success,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Details Section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.gray800,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      _buildDetailRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: user.email,
                      ),
                      const Divider(color: AppColors.gray700, height: 32),
                      
                      // Phone Number
                      _buildDetailRow(
                        icon: Icons.phone,
                        label: 'Phone Number',
                        value: user.phoneNumber,
                      ),
                      const Divider(color: AppColors.gray700, height: 32),
                      
                      // Gender
                      if (user.gender != null && user.gender!.isNotEmpty) ...[
                        _buildDetailRow(
                          icon: Icons.person,
                          label: 'Gender',
                          value: _formatGender(user.gender!),
                        ),
                        const Divider(color: AppColors.gray700, height: 32),
                      ],
                      
                      // Address
                      if (user.address != null && user.address!.isNotEmpty) ...[
                        _buildDetailRow(
                          icon: Icons.location_on,
                          label: 'Address',
                          value: user.address!,
                        ),
                        const Divider(color: AppColors.gray700, height: 32),
                      ],
                      
                      // Company Name
                      if (user.companyName != null && user.companyName!.isNotEmpty) ...[
                        _buildDetailRow(
                          icon: Icons.business,
                          label: 'Company',
                          value: user.companyName!,
                        ),
                        const Divider(color: AppColors.gray700, height: 32),
                      ],
                      
                      // Joining Date
                      if (user.joiningDate != null) ...[
                        _buildDetailRow(
                          icon: Icons.calendar_today,
                          label: 'Joining Date',
                          value: _formatDate(user.joiningDate!),
                        ),
                        const Divider(color: AppColors.gray700, height: 32),
                      ],
                      
                      // Years Worked
                      _buildDetailRow(
                        icon: Icons.work,
                        label: 'Years Worked',
                        value: yearsWorked > 0
                            ? '$yearsWorked ${yearsWorked == 1 ? 'year' : 'years'}'
                            : 'Less than 1 year',
                      ),
                      const Divider(color: AppColors.gray700, height: 32),
                      
                      // Rating
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/star.png',
                            width: 24,
                            height: 24,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 24,
                              );
                            },
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Rating',
                                  style: TextStyle(
                                    color: AppColors.gray400,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${user.rating}/10',
                                  style: const TextStyle(
                                    color: AppColors.accent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.accent, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.gray400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
