import 'dart:async';
import 'package:flutter/material.dart';

enum ToastType { success, failure, warning }

class CustomToast {
  static void show(BuildContext context, String title, ToastType type) {
    // Determine the background color and icon based on the type.
    Color backgroundColor;
    Icon icon;

    switch (type) {
      case ToastType.success:
        backgroundColor = Colors.green;
        icon = const Icon(Icons.check_circle_outlined, color: Colors.white);
        break;
      case ToastType.failure:
        backgroundColor = Colors.red;
        icon = const Icon(Icons.error_outline, color: Colors.white);
        break;
      case ToastType.warning:
        backgroundColor = Colors.amber;
        icon = const Icon(Icons.warning_amber_outlined, color: Colors.white);
        break;
    }

    // Create the overlay entry that contains our custom toast widget.
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // Position the toast near the bottom of the screen.
        bottom: 50.0,
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: backgroundColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 12.0),
                Flexible(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry and remove it after 3 seconds.
    Overlay.of(context)!.insert(overlayEntry);
    Timer(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
