import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors
  static const Color primaryColor = Color(0xFF01327E);
  static const Color secondaryColor = Color(0xFF00BF62);
  static const Color accentColor = Color(0xFF6366F1); // Indigo color for active elements
  static const Color lightAccentColor = Color(0xFFEEF2FF); // Light indigo for backgrounds

  // Dynamic Theme Helpers
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF121212)
        : Colors.white;
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;
  }

  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : const Color(0xFF01327E);
  }

  static Color getSubtitleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white70
        : Colors.grey;
  }

  static Color getDotColor(BuildContext context, bool isActive) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return isActive ? secondaryColor : Colors.white24;
    } else {
      return isActive ? primaryColor : primaryColor.withOpacity(0.3);
    }
  }

  // Chips & Rating Colors
  static Color getActiveChipBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? accentColor.withOpacity(0.2)
        : lightAccentColor;
  }

  static Color getActiveChipText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : accentColor;
  }

  static Color getInactiveChipBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF2C2C2C)
        : Colors.transparent;
  }

  static Color getInactiveChipBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.transparent
        : const Color(0xFFE0E0E0);
  }

  static Color getRatingBg(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1B5E20).withOpacity(0.3)
        : const Color(0xFFE8F5E9);
  }

  static Color getRatingText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF81C784)
        : const Color(0xFF2E7D32);
  }

  // Dimensions
  static const double splashLogoSize = 300.0;

  // Text Styles
  static TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: getTextColor(context),
    );
  }

  static TextStyle getSubtitleStyle(BuildContext context) {
    return TextStyle(
      fontSize: 16,
      color: getSubtitleColor(context),
      height: 1.5,
    );
  }

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static TextStyle getSkipButtonStyle(BuildContext context) {
    return TextStyle(
      color: getTextColor(context).withOpacity(0.8),
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }
}
