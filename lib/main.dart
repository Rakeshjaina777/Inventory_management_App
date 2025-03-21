import 'package:flutter/material.dart';
import 'package:inventory_mangement/user_sheet_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSheetApi.init(); // Initialize Google Sheets API
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Sheets Sync',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserListScreen(),
    );
  }
}

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<Map<String, String>> users = [];
  bool isLoading = true; // Show loader initially

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  /// Fetch users from Google Sheets
  Future<void> fetchUsers() async {
    setState(() => isLoading = true);
    try {
      final fetchedUsers = await UserSheetApi.fetchUsers();
      setState(() {
        users = fetchedUsers;
        isLoading = false;
      });
    } catch (e) {
      print('-------------------------------------------------❌ Error fetching users: $e');
      setState(() => isLoading = false);
    }
  }

  /// Show add/update user form
  void showUserForm({String? id, String? name, String? email}) {
    TextEditingController idController = TextEditingController(text: id ?? '');
    TextEditingController nameController = TextEditingController(text: name ?? '');
    TextEditingController emailController = TextEditingController(text: email ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add User' : 'Update User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: idController, decoration: InputDecoration(labelText: 'ID')),
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (idController.text.trim().isEmpty ||
                  nameController.text.trim().isEmpty ||
                  emailController.text.trim().isEmpty) {
                return; // Prevent empty fields
              }

              if (id == null) {
                await UserSheetApi.addUser(idController.text, nameController.text, emailController.text);
              } else {
                await UserSheetApi.updateUser(idController.text, nameController.text, emailController.text);
              }
              Navigator.pop(context);
              fetchUsers(); // Refresh UI
            },
            child: Text(id == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  /// Confirm user deletion
  void confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete User?'),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await UserSheetApi.deleteUser(id);
              Navigator.pop(context);
              fetchUsers(); // Refresh UI
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sheets Users'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchUsers, // Refresh the list
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : users.isEmpty
          ? Center(child: Text('No users found'))
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['name'] ?? 'Unknown'),
            subtitle: Text(user['email'] ?? 'No email'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => showUserForm(
                    id: user['id'],
                    name: user['name'],
                    email: user['email'],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => confirmDelete(user['id'] ?? ''),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showUserForm(), // Add new user
      ),
    );
  }
}
