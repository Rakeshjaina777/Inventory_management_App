import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_mangement/src/navigation_screen.dart';
import 'package:inventory_mangement/user_sheet_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      title: 'Inventory Management',
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<InventoryItem> inventory = [];
  bool isLoading = false;
  String lastSyncTime = "Never";

  @override
  void initState() {
    super.initState();
    loadInventory();
  }

  Future<void> loadInventory() async {
    setState(() => isLoading = true);
    try {
      final fetchedData = await UserSheetApi.fetchInventory();
      setState(() {
        inventory = fetchedData;
        lastSyncTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()); // Update sync time
      });
    } catch (e) {
      print('Error fetching inventory: $e');
    }
    setState(() => isLoading = false);



  }


  Widget _buildInventoryChart() {
    return Container(
      height: 250,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background for contrast
        borderRadius: BorderRadius.circular(10),
      ),
      child: BarChart(
        BarChartData(
          barGroups: inventory.map((item) {
            return BarChartGroupData(
              x: inventory.indexOf(item),
              barRods: [
                BarChartRodData(
                  toY: item.quantity.toDouble(),
                  color: item.quantity <= item.threshold ? Colors.red : Colors.blue,
                  width: 16, // ✅ Increase bar width for better visibility
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            );
          }).toList(),

          // ✅ Show grid lines to make values clearer
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.white24,
              strokeWidth: 1,
            ),
          ),

          // ✅ Format Axis Titles for better visibility
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40, // More space for labels
                interval: 5, // ✅ Adjust interval if needed
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35, // More space for labels
                getTitlesWidget: (value, meta) {
                  return Transform.rotate(
                    angle: -0.4, // ✅ Rotate labels if needed
                    child: Text(
                      inventory[value.toInt()].bicycleName,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                      overflow: TextOverflow.ellipsis, // ✅ Prevent label cutting
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSortingOptions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // ✅ Enable horizontal scrolling
        child: Row(
          children: [
            _sortingButton(Icons.warning_amber_rounded, "Low Stock", Colors.red[800]!, () {
              setState(() {
                inventory.sort((a, b) => (a.quantity - a.threshold).compareTo(b.quantity - b.threshold));
              });
            }),
            SizedBox(width: 8),
            _sortingButton(Icons.attach_money, "Highest Price", Colors.green[700]!, () {
              setState(() {
                inventory.sort((a, b) => b.price.compareTo(a.price));
              });
            }),
            SizedBox(width: 8),
            _sortingButton(Icons.sort_by_alpha, "A-Z", Colors.blue[700]!, () {
              setState(() {
                inventory.sort((a, b) => a.bicycleName.compareTo(b.bicycleName));
              });
            }),
            SizedBox(width: 8),
            _sortingButton(Icons.restore, "Reset", Colors.grey[700]!, loadInventory),
          ],
        ),
      ),
    );
  }

// ✅ Reusable Sorting Button Widget
  Widget _sortingButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SingleChildScrollView( // ✅ Wrap entire content in SingleChildScrollView
        child: Column(
          children: [
            SizedBox(height: 35),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/img.png', // Replace with your actual image
                height: 50,
              ),
            ),

            Divider(color: Colors.white70),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Inventory Management',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.sync, color: Colors.white, size: 28),
                  onPressed: loadInventory, // Function to refresh inventory
                ),
              ],
            ),

            SizedBox(height: 10),
            _buildSyncStatus(), // Sync status section

            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildSummaryCards(),
                  SizedBox(height: 10),
                  _buildSortingOptions(), // ✅ Sorting Buttons
                  SizedBox(height: 10),

                  // ✅ Wrap table inside horizontal scrollable view
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildInventoryTable(),
                  ),

                  SizedBox(height: 30),

                  Text(
                    'InventoryChart',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildInventoryChart()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatus() {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      color: Colors.grey[900],
      child: Text(
        "Last Sync: $lastSyncTime",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.white70, fontSize: 14),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _summaryCard('Total Bicycles', '${inventory.length}'),
        _summaryCard('Total Items', '${inventory.fold(0, (sum, item) => sum + item.quantity)}'),
        _summaryCard('Total Price', formatCurrency(_calculateTotalPrice())),


      ],
    );
  }

  Widget _summaryCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: GoogleFonts.poppins(color: Colors.white70)),
          SizedBox(height: 5),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }



  Widget _buildInventoryTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 15,
        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[900]!),
        columns: [
          DataColumn(label: Text('ID', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Bicycle', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Price', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Qty', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Threshold', style: TextStyle(color: Colors.white))),
          DataColumn(label: Text('Stock', style: TextStyle(color: Colors.white))),
        ],
        rows: inventory.map((item) {
          bool isLowStock = item.quantity <= item.threshold;
          return DataRow(
            color: MaterialStateProperty.resolveWith(
                    (states) => isLowStock ? Colors.red[900]! : Colors.grey[850]!),
            cells: [
              DataCell(Text(item.id, style: TextStyle(color: Colors.white))),
              DataCell(Text(item.bicycleName, style: TextStyle(color: Colors.white))),
              DataCell(Text('₹${item.price}', style: TextStyle(color: Colors.white))),
              DataCell(Text('${item.quantity}', style: TextStyle(color: Colors.white))),
              DataCell(Text('${item.threshold}', style: TextStyle(color: Colors.white))),
              DataCell(Text(item.stockStatus, style: TextStyle(color: Colors.white))),
            ],
          );
        }).toList(),
      ),
    );
  }

  String formatCurrency(double value) {
    if (value >= 1e7) {
      return '₹${(value / 1e7).toStringAsFixed(2)} Cr'; // Crores
    }
    else if (value >= 1e9) {
      return '₹${(value / 1e9).toStringAsFixed(2)} B'; // Lakhs
    }

    else if (value >= 1e5) {
      return '₹${(value / 1e5).toStringAsFixed(2)} L'; // Lakhs
    } else if (value >= 1e3) {
      return '₹${(value / 1e3).toStringAsFixed(1)} K'; // Thousands
    } else {
      return '₹${value.toStringAsFixed(2)}'; // Normal format
    }
  }

  double _calculateTotalPrice() {
    return inventory.fold(0, (sum, item) => sum + item.price * item.quantity);
  }




}


