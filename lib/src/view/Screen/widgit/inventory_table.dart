import 'package:flutter/material.dart';
import '../../../../controller/inventory_controller.dart dart Copy Edit.dart';


class InventoryTable extends StatelessWidget {
  final InventoryController controller;

  const InventoryTable({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 15,
        headingRowColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).colorScheme.surface,
        ),
        columns: _createColumns(context),
        rows: _createRows(context),
      ),
    );
  }

  List<DataColumn> _createColumns(BuildContext context) {
    return [
      _tableColumn('ID', context),
      _tableColumn('Bicycle', context),
      _tableColumn('Price', context),
      _tableColumn('Qty', context),
      _tableColumn('Threshold', context),
      _tableColumn('Stock', context),
    ];
  }

  List<DataRow> _createRows(BuildContext context) {
    return controller.inventory.map((item) {
      bool isLowStock = item.quantity < item.threshold && item.quantity > 0;
      bool isOutOfStock = item.quantity == 0;

      return DataRow(
        color: MaterialStateProperty.resolveWith(
              (states) {
            if (isOutOfStock) {
              return Colors.teal[300]!; // ✅ Teal for out-of-stock items
            } else if (isLowStock) {
              return Colors.red[900]!; // ✅ Red for low stock
            } else {
              return Theme.of(context).colorScheme.surface; // ✅ Default for sufficient stock
            }
          },
        ),
        cells: [
          _tableCell(item.id, context),
          _tableCell(item.bicycleName, context),
          _tableCell('₹${item.price.toStringAsFixed(2)}', context),
          _tableCell('${item.quantity}', context),
          _tableCell('${item.threshold}', context),
          _tableCell(item.stockStatus, context),
        ],
      );
    }).toList();
  }

  DataColumn _tableColumn(String label, BuildContext context) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  DataCell _tableCell(String value, BuildContext context) {
    return DataCell(
      Text(
        value,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium?.color,
        ),
      ),
    );
  }
}
