import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'user_sheet_api.dart';
import 'package:url_launcher/url_launcher.dart';

class LowStockScreen extends StatefulWidget {
  @override
  _LowStockScreenState createState() => _LowStockScreenState();
}

class _LowStockScreenState extends State<LowStockScreen> {
  List<InventoryItem> _lowStockItems = [];
  List<InventoryItem> _inactiveItems = [];

  @override
  void initState() {
    super.initState();
    _fetchInventory();
  }

  Future<void> _fetchInventory() async {
    final inventory = await UserSheetApi.fetchInventory();
    setState(() {
      _lowStockItems = inventory.where((item) => item.quantity < item.threshold).toList();
      _inactiveItems = inventory.where((item) => item.stockStatus == "Inactive").toList();
    });
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(title, style: GoogleFonts.poppins(color: Colors.white)),
            SizedBox(height: 5),
            Text(value, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTable(List<InventoryItem> items, String title) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: 20,
              columns: [
                DataColumn(label: Text('Bicycle Name')),
                DataColumn(label: Text('Quantity')),
                DataColumn(label: Text('Threshold')),
                DataColumn(label: Text('Status')),
              ],
              rows: items.map((item) {
                return DataRow(cells: [
                  DataCell(Text(item.bicycleName, overflow: TextOverflow.ellipsis)),
                  DataCell(Text(item.quantity.toString())),
                  DataCell(Text(item.threshold.toString())),
                  DataCell(Text(item.stockStatus)),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _sendNotification() async {
    final Uri emailUri = Uri.parse("mailto:rakeshjaina07@gmail.com?subject=Low%20Stock%20Alert&body=Check%20the%20inventory");
    final Uri whatsappUri = Uri.parse("https://wa.me/919021633960?text=Check%20the%20inventory%20for%20low%20stock");

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch email or WhatsApp");
    }
  }

  void _scheduleReminder() {
    print("Reminder scheduled");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Low Stock & Inactive Items')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSummaryCard('Low Stock Bicycles', '${_lowStockItems.length}', Colors.orange),
                  _buildSummaryCard('Inactive Bicycles', '${_inactiveItems.length}', Colors.red),
                ],
              ),
            ),
            SizedBox(height: 10),
            _lowStockItems.isEmpty && _inactiveItems.isEmpty
                ? Center(child: Text("No low stock or inactive items", style: GoogleFonts.poppins(fontSize: 16)))
                : Column(
              children: [
                _buildTable(_lowStockItems, 'Low Stock Items'),
                _buildTable(_inactiveItems, 'Inactive Items'),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _sendNotification,
                    child: Text('Send Notification'),
                  ),
                  ElevatedButton(
                    onPressed: _scheduleReminder,
                    child: Text('Schedule Reminder'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
