import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixPressed;
  final bool showSuffixIcon;
  final IconData? suffixIcon;

  const AppTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.onSuffixPressed,
    this.showSuffixIcon = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double errorFontSize = MediaQuery.of(context).size.width > 600 ? 17 : 12;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
          decoration: InputDecoration(
            filled: true,
            fillColor: isDark ? Colors.grey[900] : Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            errorStyle: TextStyle(
              fontSize: errorFontSize,
              color: Colors.red,
            ),
            suffixIcon: showSuffixIcon && suffixIcon != null
                ? IconButton(
              icon: Icon(suffixIcon, color: isDark ? Colors.white : Colors.black),
              onPressed: onSuffixPressed,
            )
                : null,
          ),
        ),
      ],
    );
  }
}
