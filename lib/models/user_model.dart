import 'dart:convert';
import '../constants.dart';

class UserModel {
  final int id;
  final String employeeId;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profile;
  final int rating;
  final String? joiningDate;
  final bool isActive;
  final String? companyName;
  final String? address;
  final String? gender;

  UserModel({
    required this.id,
    required this.employeeId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profile,
    required this.rating,
    this.joiningDate,
    required this.isActive,
    this.companyName,
    this.address,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String? profileUrl = json['profile'] as String?;
    // Convert relative profile path to full URL
    if (profileUrl != null && profileUrl.isNotEmpty) {
      if (!profileUrl.startsWith('http')) {
        profileUrl = '${AppConstants.baseUrl}storage/$profileUrl';
      }
    }

    return UserModel(
      id: json['id'] as int,
      employeeId: json['employee_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      profile: profileUrl,
      rating: (json['rating'] as int?) ?? 0,
      joiningDate: json['joining_date'] as String?,
      isActive: json['is_active'] as bool,
      companyName: json['company_name'] as String?,
      address: json['address'] as String?,
      gender: json['gender'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_id': employeeId,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'profile': profile,
      'rating': rating,
      'joining_date': joiningDate,
      'is_active': isActive,
      'company_name': companyName,
      'address': address,
      'gender': gender,
    };
  }

  // Calculate years worked
  int getYearsWorked() {
    if (joiningDate == null) return 0;
    try {
      final joinDate = DateTime.parse(joiningDate!);
      final now = DateTime.now();
      int years = now.year - joinDate.year;
      if (now.month < joinDate.month ||
          (now.month == joinDate.month && now.day < joinDate.day)) {
        years--;
      }
      return years;
    } catch (e) {
      return 0;
    }
  }
}
