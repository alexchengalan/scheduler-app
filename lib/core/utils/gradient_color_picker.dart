import 'dart:math';
import 'package:flutter/material.dart';

class GradientColorPicker {
  static final List<List<Color>> _gradients = [
    // [Color(0xFFFFECB3), Color(0xFFFFF8E1)], // Light warm yellow
    [Color(0xFFB3E5FC), Color(0xFFE1F5FE)], // Soft sky blue
    [Color(0xFFDCEDC8), Color(0xFFF1F8E9)], // Mint green
    [Color(0xFFFFCDD2), Color(0xFFFFEBEE)], // Baby pink
    [Color(0xFFD1C4E9), Color(0xFFEDE7F6)], // Light lavender
    [Color(0xFFFFE0B2), Color(0xFFFFF3E0)], // Soft orange peach
    // [Color(0xFFF0F4C3), Color(0xFFF9FBE7)], // Citrus green
    [Color(0xFFB2EBF2), Color(0xFFE0F7FA)], // Aqua breeze
    [Color(0xFFE1BEE7), Color(0xFFF3E5F5)], // Lavender blush
    // [Color(0xFFFFF59D), Color(0xFFFFFDE7)], // Butter yellow
    [Color(0xFFA3E9A4), Color(0xFFD0F8CE)], // Pastel green tea
    [Color(0xFFFFB6C1), Color(0xFFFFE4E1)], // Light coral pink
    [Color(0xFFB3E5FC), Color(0xFFE1F6FA)], // Cloudy blue
    [Color(0xFFFFCCBC), Color(0xFFFBE9E7)], // Papaya peach
    [Color(0xFFDCEDC8), Color(0xFFF0F4C3)], // Lime-mint
    [Color(0xFFBBDEFB), Color(0xFFE3F2FD)], // Frosted ice blue
    [Color(0xFFFFD180), Color(0xFFFFF8E1)], // Honey mango
    [Color(0xFFC5E1A5), Color(0xFFF1F8E9)], // Avocado mist
    [Color(0xFFCE93D8), Color(0xFFEDE7F6)], // Dreamy purple
    [Color(0xFF80CBC4), Color(0xFFE0F2F1)], // Soft teal
    [Color(0xFFF8BBD0), Color(0xFFFCE4EC)], // Cherry blossom
    [Color(0xFFFFAB91), Color(0xFFFBE9E7)], // Light salmon
    [Color(0xFFA5D6A7), Color(0xFFE8F5E9)], // Aloe vera
    [Color(0xFF90CAF9), Color(0xFFE3F2FD)], // Blue snow
    // [Color(0xFFFFF176), Color(0xFFFFFDE7)], // Dandelion
  ];

  /// Returns a gradient color pair based on an index or hash input
  static List<Color> pickGradient(dynamic seed) {
    int index;
    if (seed is int) {
      index = seed;
    } else if (seed is String) {
      index = seed.codeUnits.fold(0, (prev, char) => prev + char);
    } else {
      index = Random().nextInt(_gradients.length);
    }

    return _gradients[index % _gradients.length];
  }
}
