import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const _spreadsheetId = '1KG84-ReuwiUatfgkwRhOfR-fhKjHLtHE04Jj9xqkPqQ';
  static const _worksheetTitle = 'Inventory_Mangement'; // Change if using another sheet

  static late GSheets _gsheets;
  static Worksheet? _worksheet;

  /// Initialize Google Sheets API
  static Future<void> init() async {
    try {
      // Load credentials from the JSON file
      final String credentials = await rootBundle.loadString('assets/credentials.json');
      final Map<String, dynamic> jsonCredentials = jsonDecode(credentials);

      // Initialize GSheets API
      _gsheets = GSheets(credentials);
      final ss = await _gsheets.spreadsheet(_spreadsheetId);

      // Get worksheet
      _worksheet = ss.worksheetByTitle(_worksheetTitle) ??
          await ss.addWorksheet(_worksheetTitle);

      print('✅ Google Sheets API initialized successfully');
    } catch (e) {
      print('❌ Error initializing Google Sheets: $e');
    }
  }

  /// Fetch all users from Google Sheets
  /// Fetch all users from Google Sheets
  /// Fetch all users from Google Sheets with correct headers
  static Future<List<Map<String, String>>> fetchUsers() async {
    if (_worksheet == null) {
      print('❌ Worksheet is null. Make sure init() is called.');
      return [];
    }

    try {
      final rows = await _worksheet!.values.allRows(fromRow: 1);

      if (rows == null || rows.isEmpty) {
        print('ℹ️ No data found in Google Sheets.');
        return [];
      }

      // Extract headers from the first row
      final headers = rows.first;  // First row is headers
      final userData = rows.skip(1); // Remaining rows are data

      // Map each row to headers
      final mappedData = userData.map((row) {
        return {
          for (int i = 0; i < headers.length; i++)
            headers[i]: i < row.length ? row[i] : ''  // Ensure data is mapped correctly
        };
      }).toList();

      print('✅ Corrected Users: $mappedData');
      return mappedData;
    } catch (e) {
      print('❌ Error fetching users: $e');
      return [];
    }
  }

  /// Add a new user to Google Sheets
  static Future<bool> addUser(String id, String name, String email) async {
    if (_worksheet == null) return false;

    try {
      await _worksheet!.values.appendRow([id, name, email]);
      print('✅ User added: $name');
      return true;
    } catch (e) {
      print('❌ Error adding user: $e');
      return false;
    }
  }

  /// Update user details in Google Sheets
  static Future<bool> updateUser(String id, String newName, String newEmail) async {
    if (_worksheet == null) return false;

    try {
      final rows = await _worksheet!.values.allRows();
      if (rows == null) return false;

      for (int i = 0; i < rows.length; i++) {
        if (rows[i][0] == id) {
          await _worksheet!.values.insertRow(i + 1, [id, newName, newEmail]);
          print('✅ User updated: $newName');
          return true;
        }
      }
      return false;
    } catch (e) {
      print('❌ Error updating user: $e');
      return false;
    }
  }

  /// Delete a user from Google Sheets
  static Future<bool> deleteUser(String id) async {
    if (_worksheet == null) return false;

    try {
      final rows = await _worksheet!.values.allRows();
      if (rows == null) return false;

      for (int i = 0; i < rows.length; i++) {
        if (rows[i][0] == id) {
          await _worksheet!.deleteRow(i + 1);
          print('✅ User deleted: $id');
          return true;
        }
      }
      return false;
    } catch (e) {
      print('❌ Error deleting user: $e');
      return false;
    }
  }
}
