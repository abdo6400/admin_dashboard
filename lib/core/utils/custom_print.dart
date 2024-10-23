import 'package:flutter/foundation.dart';

class CustomPrint {
  // Function to print route-specific messages
  static void printRoute(String text) {
    if (kDebugMode) {
      _printFullText('[ROUTE] $text');
    }
  }

  // Function to print Bloc events
  static void printBlocEvent(String text) {
    if (kDebugMode) {
      _printFullText('[BLOC] $text');
    }
  }

  // Function to print requests
  static void printRequest(String text) {
    if (kDebugMode) {
      _printFullText('[REQUEST] $text');
    }
  }

  // Function to print responses
  static void printResponse(String text) {
    if (kDebugMode) {
      _printFullText('[RESPONSE] $text');
    }
  }

  // Function to print errors
  static void printError(String text) {
    if (kDebugMode) {
      _printFullText('[ERROR] $text');
    }
  }

  // Properly prints long texts by splitting into 800-character chunks
  static void _printFullText(String text) {
    const chunkSize = 800;
    final pattern = RegExp('.{1,$chunkSize}'); // Splits text into chunks of 800 characters

    for (var match in pattern.allMatches(text)) {
      debugPrint(match.group(0)); // Use debugPrint to handle long texts
    }
  }
}
