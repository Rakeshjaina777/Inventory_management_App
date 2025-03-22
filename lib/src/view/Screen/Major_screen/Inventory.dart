


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../Services/user_sheet_api.dart';

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
        lastSyncTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      });
    } catch (e) {
      print('Error fetching inventory: $e');
    }
    setState(() => isLoading = false);
  }

  Widget _buildInventoryChart() {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
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
                  color: item.quantity <= item.threshold
                      ? Colors.red
                      : Theme.of(context).colorScheme.primary,
                  width: 16,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            );
          }).toList(),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                getTitlesWidget: (value, meta) {
                  return Transform.rotate(
                    angle: -0.4,
                    child: Text(
                      inventory[value.toInt()].bicycleName,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 10,
                      ),
                      overflow: TextOverflow.ellipsis,
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
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _sortingButton(Icons.warning_amber_rounded, "Low Stock",
                Colors.red[800]!, () {
                  setState(() {
                    inventory.sort((a, b) =>
                        (a.quantity - a.threshold).compareTo(b.quantity - b.threshold));
                  });
                }),
            const SizedBox(width: 8),
            _sortingButton(Icons.attach_money, "Highest Price",
                Colors.green[700]!, () {
                  setState(() {
                    inventory.sort((a, b) => b.price.compareTo(a.price));
                  });
                }),
            const SizedBox(width: 8),
            _sortingButton(Icons.sort_by_alpha, "A-Z", Colors.blue[700]!, () {
              setState(() {
                inventory.sort((a, b) => a.bicycleName.compareTo(b.bicycleName));
              });
            }),
            const SizedBox(width: 8),
            _sortingButton(Icons.restore, "Reset", Colors.grey[700]!, loadInventory),
          ],
        ),
      ),
    );
  }

  Widget _sortingButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(backgroundColor: color),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/img.png',
                height: 50,
              ),
            ),
            Divider(color: Theme.of(context).dividerColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Inventory Management',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.sync,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                  onPressed: loadInventory,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _buildSyncStatus(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  _buildSummaryCards(),
                  const SizedBox(height: 10),
                  _buildSortingOptions(),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _buildInventoryTable(),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Inventory Chart',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildInventoryChart(),
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
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      color: Theme.of(context).colorScheme.surface,
      child: Text(
        "Last Sync: $lastSyncTime",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _summaryCard('Total Bicycles', '${inventory.length}'),
        _summaryCard(
            'Total Items', '${inventory.fold(0, (sum, item) => sum + item.quantity)}'),
        _summaryCard('Total Price', formatCurrency(_calculateTotalPrice())),
      ],
    );
  }

  Widget _summaryCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 15,
        headingRowColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).colorScheme.surface,
        ),
        columns: [
          _tableColumn('ID'),
          _tableColumn('Bicycle'),
          _tableColumn('Price'),
          _tableColumn('Qty'),
          _tableColumn('Threshold'),
          _tableColumn('Stock'),
        ],
        rows: inventory.map((item) {
          bool isLowStock = item.quantity < item.threshold && item.quantity > 0;
          bool isOutOfStock = item.quantity == 0;

          return DataRow(
            color: MaterialStateProperty.resolveWith(
                  (states) {
                if (isOutOfStock) {
                  return Colors.teal[300]!; // ✅ Teal for out of stock
                } else if (isLowStock) {
                  return Colors.red[900]!; // ✅ Red for low stock
                } else {
                  return Theme.of(context).colorScheme.surface; // ✅ Default for sufficient stock
                }
              },
            ),
            cells: [
              _tableCell(item.id),
              _tableCell(item.bicycleName),
              _tableCell('₹${item.price}'),
              _tableCell('${item.quantity}'),
              _tableCell('${item.threshold}'),
              _tableCell(item.stockStatus),
            ],
          );
        }).toList(),
      ),
    );
  }

  DataColumn _tableColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  DataCell _tableCell(String value) {
    return DataCell(
      Text(
        value,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }

  String formatCurrency(double value) {
    if (value >= 1e7) {
      return '₹${(value / 1e7).toStringAsFixed(2)} Cr';
    } else if (value >= 1e5) {
      return '₹${(value / 1e5).toStringAsFixed(2)} L';
    } else if (value >= 1e3) {
      return '₹${(value / 1e3).toStringAsFixed(1)} K';
    } else {
      return '₹${value.toStringAsFixed(2)}';
    }
  }

  double _calculateTotalPrice() {
    return inventory.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}
