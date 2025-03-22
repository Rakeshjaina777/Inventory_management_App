import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const _spreadsheetId = '1KG84-ReuwiUatfgkwRhOfR-fhKjHLtHE04Jj9xqkPqQ';
  static const _worksheetTitle = 'Inventory_Mangement';

  static late GSheets _gsheets;
  static Worksheet? _worksheet;

  static Future<void> init() async {
    try {
      final String credentials = await rootBundle.loadString('assets/credentials.json');
      // final Map<String, dynamic> jsonCredentials = jsonDecode(credentials);

      _gsheets = GSheets(credentials);
      final ss = await _gsheets.spreadsheet(_spreadsheetId);
      _worksheet = ss.worksheetByTitle(_worksheetTitle) ?? await ss.addWorksheet(_worksheetTitle);
    } catch (e) {
      print('❌ Error initializing Google Sheets: $e');
    }
  }

  static Future<List<InventoryItem>> fetchInventory() async {
    if (_worksheet == null) throw Exception("Google Sheets not initialized!");

    final rows = await _worksheet!.values.allRows();
    if (rows == null || rows.isEmpty) return [];

    return rows.skip(1).map((row) {
      if (row.length < 6) return null;
      return InventoryItem.fromList(row);
    }).whereType<InventoryItem>().toList();
  }


  static Future<bool> addUser(String id, String name, String price, String quantity, String threshold, String stockStatus) async {
    if (_worksheet == null) return false;

    try {
      await _worksheet!.values.appendRow([id, name, price, quantity, threshold, stockStatus]);
      return true;
    } catch (e) {
      print('❌ Error adding new item: $e');
      return false;
    }
  }

  static Future<bool> updateUser(String id, String name, String price, String quantity, String threshold, String stockStatus) async {
    if (_worksheet == null) return false;

    final rows = await _worksheet!.values.allRows();
    if (rows == null) return false;

    for (int i = 0; i < rows.length; i++) {
      if (rows[i][0] == id) {
        await _worksheet!.values.insertRow(i + 1, [id, name, price, quantity, threshold, stockStatus]);
        return true;
      }
    }
    return false;
  }
}

class InventoryItem {
  final String id;
  final String bicycleName;
  final int price;
  final int quantity;
  final int threshold;
  final String stockStatus;

  InventoryItem({required this.id, required this.bicycleName, required this.price, required this.quantity, required this.threshold, required this.stockStatus});

  factory InventoryItem.fromList(List<dynamic> row) {
    return InventoryItem(id: row[0], bicycleName: row[1], price: int.parse(row[2]), quantity: int.parse(row[3]), threshold: int.parse(row[4]), stockStatus: row[5]);
  }
}
