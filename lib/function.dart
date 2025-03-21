import 'package:inventory_mangement/user_sheet_api.dart';

/// Fetch and print all users
Future<void> getUsers() async {
  try {
    final users = await UserSheetApi.fetchUsers();
    print('✅ Users fetched: $users');
  } catch (e) {
    print('❌ Error fetching users: $e');
  }
}

/// Add a new user
Future<void> addUser() async {
  try {
    bool success = await UserSheetApi.addUser('3', 'John Doe', 'john@example.com');
    if (success) {
      print('✅ User added successfully');
    } else {
      print('❌ Failed to add user');
    }
  } catch (e) {
    print('❌ Error adding user: $e');
  }
}

/// Update an existing user
Future<void> updateUser() async {
  try {
    bool success = await UserSheetApi.updateUser('3', 'John Updated', 'john.updated@example.com');
    if (success) {
      print('✅ User updated successfully');
    } else {
      print('❌ Failed to update user');
    }
  } catch (e) {
    print('❌ Error updating user: $e');
  }
}

/// Delete a user
Future<void> deleteUser() async {
  try {
    bool success = await UserSheetApi.deleteUser('3');
    if (success) {
      print('✅ User deleted successfully');
    } else {
      print('❌ Failed to delete user');
    }
  } catch (e) {
    print('❌ Error deleting user: $e');
  }
}
