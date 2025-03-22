

import 'package:flutter/material.dart';
import 'package:inventory_mangement/src/view/Screen/Major_screen/Inventory.dart';

import '../Major_screen/low_stock.dart';

import '../Major_screen/manage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  static const List<String> _titles = [
    "Manage",
    "Inventory",
    "Low Stock"

    // "Community",
    "",
  ];

  static List<Widget> _screens = [

    // AppointmentsScreen(),
    // const Screen(title: "Assistant"),
    StockManagementScreen (),
    InventoryScreen(),
    LowStockScreen(),
    // const Screen(title: "Community"),
    // DoctorProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Column(
        children: [
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.colorScheme.onBackground,
          iconSize: 28,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          backgroundColor: theme.colorScheme.background,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.manage_history), label: "Manage"),
            BottomNavigationBarItem(icon: Icon(Icons.inventory_2_sharp), label: "Inventory"),
            BottomNavigationBarItem(icon: Icon(Icons.privacy_tip_outlined), label: "Low Stock"),
            // BottomNavigationBarItem(icon: Icon(Icons.group), label: "Community"),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}

class Screen extends StatelessWidget {
  final String title;

  const Screen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        title,
        style: theme.textTheme.displaySmall,
      ),
    );
  }
}