import 'package:flutter/material.dart';
import 'package:scheduler/core/utils/icon_keywords.dart';

class IconPickerService {
  /// Picks an icon based on a keyword in the input text.
  IconData pickIcon(String text) {
    for (final entry in keywordIconMap.entries) {
      if (text.toLowerCase().contains(entry.key)) {
        return entry.value;
      }
    }
    return Icons.notes; // Default fallback icon
  }
}
