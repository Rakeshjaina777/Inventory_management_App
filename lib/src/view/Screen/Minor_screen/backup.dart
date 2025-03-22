// import 'package:flutter/material.dart';
// import 'package:inventory_mangement/user_sheet_api.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await UserSheetApi.init(); // Initialize Google Sheets API
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Google Sheets Sync',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: UserListScreen(),
//     );
//   }
// }
//
// class UserListScreen extends StatefulWidget {
//   @override
//   _UserListScreenState createState() => _UserListScreenState();
// }
//
// class _UserListScreenState extends State<UserListScreen> {
//   List<Map<String, String>> users = [];
//   bool isLoading = true; // Show loader initially
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }
//
//   /// Fetch users from Google Sheets
//   Future<void> fetchUsers() async {
//     setState(() => isLoading = true);
//     try {
//       final fetchedUsers = await UserSheetApi.fetchUsers();
//       setState(() {
//         users = fetchedUsers;
//         isLoading = false;
//       });
//     } catch (e) {
//       print('-------------------------------------------------❌ Error fetching users: $e');
//       setState(() => isLoading = false);
//     }
//   }
//
//   /// Show add/update user form
//   void showUserForm({String? id, String? name, String? email}) {
//     TextEditingController idController = TextEditingController(text: id ?? '');
//     TextEditingController nameController = TextEditingController(text: name ?? '');
//     TextEditingController emailController = TextEditingController(text: email ?? '');
//
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(id == null ? 'Add User' : 'Update User'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(controller: idController, decoration: InputDecoration(labelText: 'ID')),
//             TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
//             TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               if (idController.text.trim().isEmpty ||
//                   nameController.text.trim().isEmpty ||
//                   emailController.text.trim().isEmpty) {
//                 return; // Prevent empty fields
//               }
//
//               if (id == null) {
//                 await UserSheetApi.addUser(idController.text, nameController.text, emailController.text);
//               } else {
//                 await UserSheetApi.updateUser(idController.text, nameController.text, emailController.text);
//               }
//               Navigator.pop(context);
//               fetchUsers(); // Refresh UI
//             },
//             child: Text(id == null ? 'Add' : 'Update'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Confirm user deletion
//   void confirmDelete(String id) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Delete User?'),
//         content: Text('Are you sure you want to delete this user?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await UserSheetApi.deleteUser(id);
//               Navigator.pop(context);
//               fetchUsers(); // Refresh UI
//             },
//             child: Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Google Sheets Users'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: fetchUsers, // Refresh the list
//           ),
//         ],
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : users.isEmpty
//           ? Center(child: Text('No users found'))
//           : ListView.builder(
//         itemCount: users.length,
//         itemBuilder: (context, index) {
//           final user = users[index];
//           return ListTile(
//             title: Text(user['name'] ?? 'Unknown'),
//             subtitle: Text(user['email'] ?? 'No email'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit, color: Colors.blue),
//                   onPressed: () => showUserForm(
//                     id: user['id'],
//                     name: user['name'],
//                     email: user['email'],
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete, color: Colors.red),
//                   onPressed: () => confirmDelete(user['id'] ?? ''),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => showUserForm(), // Add new user
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'package:inventory_mangement/user_sheet_api.dart';
//
// /// Fetch and print all users
// Future<void> getUsers() async {
//   try {
//     final users = await UserSheetApi.fetchUsers();
//     print('✅ Users fetched: $users');
//   } catch (e) {
//     print('❌ Error fetching users: $e');
//   }
// }
//
// /// Add a new user
// Future<void> addUser() async {
//   try {
//     bool success = await UserSheetApi.addUser('3', 'John Doe', 'john@example.com');
//     if (success) {
//       print('✅ User added successfully');
//     } else {
//       print('❌ Failed to add user');
//     }
//   } catch (e) {
//     print('❌ Error adding user: $e');
//   }
// }
//
// /// Update an existing user
// Future<void> updateUser() async {
//   try {
//     bool success = await UserSheetApi.updateUser('3', 'John Updated', 'john.updated@example.com');
//     if (success) {
//       print('✅ User updated successfully');
//     } else {
//       print('❌ Failed to update user');
//     }
//   } catch (e) {
//     print('❌ Error updating user: $e');
//   }
// }
//
// /// Delete a user
// Future<void> deleteUser() async {
//   try {
//     bool success = await UserSheetApi.deleteUser('3');
//     if (success) {
//       print('✅ User deleted successfully');
//     } else {
//       print('❌ Failed to delete user');
//     }
//   } catch (e) {
//     print('❌ Error deleting user: $e');
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:gsheets/gsheets.dart';
//
// class UserSheetApi {
//   static const _spreadsheetId = '1KG84-ReuwiUatfgkwRhOfR-fhKjHLtHE04Jj9xqkPqQ';
//   static const _worksheetTitle = 'Inventory_Mangement'; // Change if using another sheet
//
//   static late GSheets _gsheets;
//   static Worksheet? _worksheet;
//
//   /// Initialize Google Sheets API
//   static Future<void> init() async {
//     try {
//       // Load credentials from the JSON file
//       final String credentials = await rootBundle.loadString('assets/credentials.json');
//       final Map<String, dynamic> jsonCredentials = jsonDecode(credentials);
//
//       // Initialize GSheets API
//       _gsheets = GSheets(credentials);
//       final ss = await _gsheets.spreadsheet(_spreadsheetId);
//
//       // Get worksheet
//       _worksheet = ss.worksheetByTitle(_worksheetTitle) ??
//           await ss.addWorksheet(_worksheetTitle);
//
//       print('✅ Google Sheets API initialized successfully');
//     } catch (e) {
//       print('❌ Error initializing Google Sheets: $e');
//     }
//   }
//
//   /// Fetch all users from Google Sheets
//   /// Fetch all users from Google Sheets
//   /// Fetch all users from Google Sheets with correct headers
//   static Future<List<Map<String, String>>> fetchUsers() async {
//     if (_worksheet == null) {
//       print('❌ Worksheet is null. Make sure init() is called.');
//       return [];
//     }
//
//     try {
//       final rows = await _worksheet!.values.allRows(fromRow: 1);
//
//       if (rows == null || rows.isEmpty) {
//         print('ℹ️ No data found in Google Sheets.');
//         return [];
//       }
//
//       // Extract headers from the first row
//       final headers = rows.first;  // First row is headers
//       final userData = rows.skip(1); // Remaining rows are data
//
//       // Map each row to headers
//       final mappedData = userData.map((row) {
//         return {
//           for (int i = 0; i < headers.length; i++)
//             headers[i]: i < row.length ? row[i] : ''  // Ensure data is mapped correctly
//         };
//       }).toList();
//
//       print('✅ Corrected Users: $mappedData');
//       return mappedData;
//     } catch (e) {
//       print('❌ Error fetching users: $e');
//       return [];
//     }
//   }
//
//   /// Add a new user to Google Sheets
//   static Future<bool> addUser(String id, String name, String email) async {
//     if (_worksheet == null) return false;
//
//     try {
//       await _worksheet!.values.appendRow([id, name, email]);
//       print('✅ User added: $name');
//       return true;
//     } catch (e) {
//       print('❌ Error adding user: $e');
//       return false;
//     }
//   }
//
//   /// Update user details in Google Sheets
//   static Future<bool> updateUser(String id, String newName, String newEmail) async {
//     if (_worksheet == null) return false;
//
//     try {
//       final rows = await _worksheet!.values.allRows();
//       if (rows == null) return false;
//
//       for (int i = 0; i < rows.length; i++) {
//         if (rows[i][0] == id) {
//           await _worksheet!.values.insertRow(i + 1, [id, newName, newEmail]);
//           print('✅ User updated: $newName');
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       print('❌ Error updating user: $e');
//       return false;
//     }
//   }
//
//   /// Delete a user from Google Sheets
//   static Future<bool> deleteUser(String id) async {
//     if (_worksheet == null) return false;
//
//     try {
//       final rows = await _worksheet!.values.allRows();
//       if (rows == null) return false;
//
//       for (int i = 0; i < rows.length; i++) {
//         if (rows[i][0] == id) {
//           await _worksheet!.deleteRow(i + 1);
//           print('✅ User deleted: $id');
//           return true;
//         }
//       }
//       return false;
//     } catch (e) {
//       print('❌ Error deleting user: $e');
//       return false;
//     }
//   }
// }
//
//
//
//
//
