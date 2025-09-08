// lib/services/google_sheets_service.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gsheets/gsheets.dart';

class GoogleSheetsService {
  // TODO: Replace with your sheet ID
  static const _spreadsheetId = '10n_hb4_3TfnJcU2oXONMLa1jLcckreSO4mArDDFJjdY';
  // TODO: Replace with the sheet/tab name inside the spreadsheet
  static const _sheetName = 'travel_data';

  static GSheets? _gsheets;
  static Worksheet? _worksheet;

  /// Initialize the GSheets client and worksheet.
  static Future<void> init() async {
    if (_worksheet != null) return; // already initialized

    // Load service account credentials JSON from assets
    final credentials = await rootBundle.loadString('asset/travel_data.json');

    _gsheets = GSheets(credentials);
    final ss = await _gsheets!.spreadsheet(_spreadsheetId);

    _worksheet = ss.worksheetByTitle(_sheetName) ??
        await ss.addWorksheet(_sheetName);

    // If first row is empty (no headers), add headers
    final firstRow = await _worksheet!.values.row(1);
    final isHeaderEmpty = firstRow == null ||
        firstRow.isEmpty ||
        firstRow.every((c) => c == null || c.toString().trim().isEmpty);

    if (isHeaderEmpty) {
      await _worksheet!.values.insertRow(1, [
        'Name',
        'Email',
        'WhatsApp',
        'Destination',
        'Travel Date',
        'Submitted At'
      ]);
    }
  }

  /// Append a new query row to the sheet
  static Future<bool> saveQuery({
    required String name,
    required String email,
    required String whatsapp,
    required String destination,
    required String travelDate,
  }) async {
    try {
      await init();
      final now = DateTime.now().toIso8601String();
      await _worksheet!.values.appendRow([
        name,
        email,
        whatsapp,
        destination,
        travelDate,
        now,
      ]);
      return true;
    } catch (e, st) {
      // For debugging during development:
      // print('GoogleSheetsService error: $e\n$st');
      return false;
    }
  }
}
