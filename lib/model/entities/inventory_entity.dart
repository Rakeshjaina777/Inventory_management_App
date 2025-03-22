// class InventoryItem {
//   final String id;
//   final String bicycleName;
//   final double price;
//   final int quantity;
//   final int threshold;
//
//   InventoryItem({
//     required this.id,
//     required this.bicycleName,
//     required this.price,
//     required this.quantity,
//     required this.threshold,
//   });
//
//   // Calculate stock status based on threshold
//   String get stockStatus {
//     if (quantity == 0) {
//       return "Out of Stock";
//     } else if (quantity <= threshold) {
//       return "Low Stock";
//     } else {
//       return "In Stock";
//     }
//   }
//
//   // Factory to convert from JSON
//   factory InventoryItem.fromJson(Map<String, dynamic> json) {
//     return InventoryItem(
//       id: json['id'].toString(),
//       bicycleName: json['bicycleName'],
//       price: json['price'].toDouble(),
//       quantity: json['quantity'],
//       threshold: json['threshold'],
//     );
//   }
// }
