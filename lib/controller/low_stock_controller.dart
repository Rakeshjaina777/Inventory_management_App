//
// import 'package:url_launcher/url_launcher.dart';
//
// import '../sevices/user_sheet_api.dart';
//
// class LowStockController {
//   List<InventoryItem> lowStockItems = [];
//   List<InventoryItem> inactiveItems = [];
//
//   Future<void> fetchInventory() async {
//     final inventory = await UserSheetApi.fetchInventory();
//     lowStockItems = inventory.where((item) => item.quantity < item.threshold).toList();
//     inactiveItems = inventory.where((item) => item.stockStatus == "Inactive").toList();
//   }
//
//   Future<void> sendNotification() async {
//     final Uri emailUri = Uri.parse(
//         "mailto:rakeshjaina07@gmail.com?subject=Low%20Stock%20Alert&body=Check%20the%20inventory");
//     final Uri whatsappUri =
//     Uri.parse("https://wa.me/919021633960?text=Check%20the%20inventory%20for%20low%20stock");
//
//     if (await canLaunchUrl(emailUri)) {
//       await launchUrl(emailUri, mode: LaunchMode.externalApplication);
//     } else if (await canLaunchUrl(whatsappUri)) {
//       await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
//     } else {
//       print("Could not launch email or WhatsApp");
//     }
//   }
//
//   void scheduleReminder() {
//     print("Reminder scheduled");
//   }
// }
