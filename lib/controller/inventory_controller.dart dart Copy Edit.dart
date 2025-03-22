


import 'package:intl/intl.dart';

import '../Services/user_sheet_api.dart';


class InventoryController {
  List<InventoryItem> inventory = [];
  String lastSyncTime = "Never";

  // Load inventory data from API
  Future<void> loadInventory() async {
    try {
      inventory = await UserSheetApi.fetchInventory();
      lastSyncTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    } catch (e) {
      print('Error fetching inventory: $e');
    }
  }

  // Sort inventory by different criteria
  void sortByLowStock() {
    inventory.sort((a, b) =>
        (a.quantity - a.threshold).compareTo(b.quantity - b.threshold));
  }

  void sortByPrice() {
    inventory.sort((a, b) => b.price.compareTo(a.price));
  }

  void sortByName() {
    inventory.sort((a, b) => a.bicycleName.compareTo(b.bicycleName));
  }

  double calculateTotalPrice() {
    return inventory.fold(0, (sum, item) => sum + item.price * item.quantity);
  }
}
