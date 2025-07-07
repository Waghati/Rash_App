import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors from your design
  static const Color primary = Color(0xFF6366F1); // Purple from your design
  static const Color secondary = Color(0xFF06B6D4); // Cyan from your design
  static const Color accent = Color(0xFF10B981); // Green from your design

  // Background colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBackground = Colors.white;
  static const Color lightBackground = Color(0xFFE0F2FE);

  // Text colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Subject colors (matching your curriculum cards)
  static const Color mathematics = Color(0xFF374151); // Dark gray
  static const Color science = Color(0xFF059669); // Green
  static const Color languages = Color(0xFF0284C7); // Blue
  static const Color computer = Color(0xFF5B21B6); // Purple
  static const Color lifeSkills = Color(0xFF1E293B); // Dark blue

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Progress colors
  static const Color progress70 = Color(0xFF10B981); // Green for 70%
  static const Color progress80 = Color(0xFF059669); // Darker green for 80%
  static const Color progress60 = Color(0xFF6B7280); // Gray for 60%
  static const Color progress75 = Color(0xFF06B6D4); // Cyan for 75%
  static const Color progress40 = Color(0xFF10B981); // Green for 40%
}

class AppGradients {
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8DD3C7), // Light mint
      Color(0xFF7DD3FC), // Light blue
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white,
      Color(0xFFF8FAFC),
    ],
  );
}