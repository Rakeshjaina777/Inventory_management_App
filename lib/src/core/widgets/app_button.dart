import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to set a responsive button height.
    final double buttonHeight = MediaQuery.of(context).size.height * 0.06;
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        child: isLoading
            ? SizedBox(
          width: 24,
          height: 24,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        )
            : Text(label),

      ),
    );
  }
}
