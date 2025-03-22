import 'package:flutter/material.dart';
import 'package:inventory_mangement/summaryclass.dart';
import 'user_sheet_api.dart';

class StockManagementScreen extends StatefulWidget {
  @override
  _StockManagementScreenState createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  List<InventoryItem> _inventory = [];

  @override
  void initState() {
    super.initState();
    _fetchInventory();
  }

  Future<void> _fetchInventory() async {
    final inventory = await UserSheetApi.fetchInventory();
    setState(() {
      _inventory = inventory;
    });
  }

  void _addItem() {
    _showItemDialog();
  }

  void _editItem(InventoryItem item) {
    _showItemDialog(editItem: item);
  }

  void _showItemDialog({InventoryItem? editItem}) {
    TextEditingController nameController = TextEditingController(text: editItem?.bicycleName ?? "");
    TextEditingController priceController = TextEditingController(text: editItem?.price.toString() ?? "");
    TextEditingController qtyController = TextEditingController(text: editItem?.quantity.toString() ?? "");
    TextEditingController thresholdController = TextEditingController(text: editItem?.threshold.toString() ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          editItem == null ? "Add New Item" : "Edit Item",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(nameController, "Bicycle Name"),
            _buildTextField(priceController, "Price", isNumber: true),
            _buildTextField(qtyController, "Quantity", isNumber: true),
            _buildTextField(thresholdController, "Threshold Level", isNumber: true),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              String id = editItem?.id ?? (_inventory.length + 1).toString();
              String name = nameController.text;
              int price = int.tryParse(priceController.text) ?? 0;
              int qty = int.tryParse(qtyController.text) ?? 0;
              int threshold = int.tryParse(thresholdController.text) ?? 0;
              String stockStatus = qty > threshold ? "Available" : "Low Stock";

              if (name.isEmpty || price <= 0 || qty < 0 || threshold < 0) {
                _showError("Please enter valid details!");
                return;
              }

              InventoryItem newItem = InventoryItem(
                id: id,
                bicycleName: name,
                price: price,
                quantity: qty,
                threshold: threshold,
                stockStatus: stockStatus,
              );

              bool success;
              if (editItem == null) {
                success = await UserSheetApi.addUser(
                  newItem.id,
                  name,
                  price.toString(),
                  qty.toString(),
                  threshold.toString(),
                  stockStatus,
                );

                if (success) {
                  setState(() {
                    _inventory.add(newItem);
                  });
                }
              } else {
                int index = _inventory.indexWhere((i) => i.id == editItem.id);
                if (index != -1) {
                  setState(() {
                    _inventory[index] = newItem;
                  });
                }
                success = await UserSheetApi.updateUser(
                  newItem.id,
                  name,
                  price.toString(),
                  qty.toString(),
                  threshold.toString(),
                  stockStatus,
                );
              }

              if (success) {
                Navigator.pop(context);
              } else {
                _showError("Failed to save item.");
              }
            },
            child: Text(editItem == null ? "Add" : "Save"),
          ),
        ],
      ),
    );
  }

  void _deleteItem(InventoryItem item) async {
    int index = _inventory.indexWhere((element) => element.id == item.id);
    if (index == -1) return;

    InventoryItem updatedItem = InventoryItem(
      id: item.id,
      bicycleName: item.bicycleName,
      price: item.price,
      quantity: 0,
      threshold: 0,
      stockStatus: "Inactive",
    );

    setState(() {
      _inventory[index] = updatedItem;
    });

    bool success = await UserSheetApi.updateUser(
      updatedItem.id,
      updatedItem.bicycleName,
      updatedItem.price.toString(),
      "0",
      "0",
      "Inactive",
    );

    if (!success) {
      _showError("Failed to update item.");
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Management'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Data Analytics Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SummaryCards(
                  totalBicycles: _inventory.length,
                  totalItems: _inventory.fold(0, (sum, item) => sum + item.quantity),
                  totalPrice: formatCurrency(_calculateTotalPrice()),
                ),

              ],
            ),

            SizedBox(
              height: 25,
            ),

            // Inventory Table
            Expanded(
              child: _inventory.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _inventory.length,
                itemBuilder: (context, index) {
                  final item = _inventory[index];
                  return Card(
                    child: ListTile(
                      title: Text(" Bicycle : ${item.bicycleName}"),
                      subtitle: Text(
                        "Price: ₹${item.price}, Qty: ${item.quantity}, Status: ${item.stockStatus}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => _editItem(item)),
                          IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => _deleteItem(item)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildDashboardCard(String title, String value, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
            Text(value, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
  double _calculateTotalPrice() {
    return _inventory.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

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

