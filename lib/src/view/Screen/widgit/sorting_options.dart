// import 'package:flutter/material.dart';
// import '../../../../controller/inventory_controller.dart dart Copy Edit.dart';
//
// class SortingOptions extends StatelessWidget {
//   final InventoryController controller;
//   final Function(Function) onSort;
//
//   const SortingOptions({required this.controller, required this.onSort});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _sortingButton(
//             Icons.warning_amber_rounded, "Low Stock", Colors.red, controller.sortByLowStock),
//         _sortingButton(
//             Icons.attach_money, "Highest Price", Colors.green, controller.sortByPrice),
//         _sortingButton(Icons.sort_by_alpha, "A-Z", Colors.blue, controller.sortByName),
//       ],
//     );
//   }
//
//   Widget _sortingButton(IconData icon, String label, Color color, Function sortFunction) {
//     return ElevatedButton.icon(
//       icon: Icon(icon, color: Colors.white),
//       label: Text(label, style: const TextStyle(color: Colors.white)),
//       style: ElevatedButton.styleFrom(backgroundColor: color),
//       onPressed: () => onSort(sortFunction),
//     );
//   }
// }
