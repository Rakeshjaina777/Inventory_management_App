import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// **Reusable Elevated Button for Consistency**
class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ResponsiveButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 60 : 45,
              vertical: isTablet ? 20 : 16,
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: isTablet ? 20 : 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}

/// **Reusable Text Widget for Scaling Font Size**
class ResponsiveText extends StatelessWidget {
  final String text;
  final double mobileFontSize;
  final double tabletFontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  const ResponsiveText({
    super.key,
    required this.text,
    required this.mobileFontSize,
    required this.tabletFontSize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;
        return Text(
          text,
          textAlign: textAlign,
          style: TextStyle(
            fontSize: isTablet ? tabletFontSize : mobileFontSize,
            fontWeight: fontWeight,
            color: color,
          ),
        );
      },
    );
  }
}

/// **Reusable Text Button Widget for Scaling Font Size**
class ResponsiveTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ResponsiveTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isTablet = constraints.maxWidth > 600;
        return TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: isTablet ? 20 : 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}


/// **Reusable Social Image Widget for Scaling Font Size**
Widget socialLoginButton(IconData icon) {
  return Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Center(
      child: FaIcon(
        icon,
        size: 30,
        color: Colors.black,
      ),
    ),
  );
}