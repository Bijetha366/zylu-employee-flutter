import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../constants.dart';

class UserController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<UserModel> searchResults = <UserModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;
  final RxBool hasMore = true.obs;
  final RxInt currentPage = 1.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final int perPage = 10;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers({bool refresh = false}) async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      if (refresh) {
        currentPage.value = 1;
        users.clear();
        hasMore.value = true;
      }

      final response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}api/mobile/users?page=${currentPage.value}&per_page=$perPage',
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          final List<dynamic> userList = data['data'];
          final pagination = data['pagination'];

          final newUsers = userList
              .map((user) => UserModel.fromJson(user))
              .toList();

          if (refresh) {
            users.value = newUsers;
          } else {
            users.addAll(newUsers);
          }

          hasMore.value = pagination['has_more'] ?? false;
          currentPage.value = pagination['current_page'] ?? 1;
        } else {
          errorMessage.value = 'Failed to load users';
        }
      } else {
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore.value || isLoading.value) return;
    final nextPage = currentPage.value + 1;
    currentPage.value = nextPage;
    await fetchUsers();
  }

  Future<void> refreshUsers() async {
    await fetchUsers(refresh: true);
  }

  Future<UserModel?> fetchUserById(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}api/mobile/users/$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          return UserModel.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchUsers(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      searchQuery.value = '';
      return;
    }

    try {
      isSearching.value = true;
      errorMessage.value = '';
      searchQuery.value = query;

      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl}api/mobile/search?q=${Uri.encodeComponent(query)}'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          final List<dynamic> userList = data['data'];
          searchResults.value = userList
              .map((user) => UserModel.fromJson(user))
              .toList();
        } else {
          searchResults.clear();
          errorMessage.value = 'Search failed';
        }
      } else {
        searchResults.clear();
        errorMessage.value = 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      searchResults.clear();
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isSearching.value = false;
    }
  }

  void clearSearch() {
    searchResults.clear();
    searchQuery.value = '';
    errorMessage.value = '';
  }
}
