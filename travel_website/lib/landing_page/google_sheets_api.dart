import 'dart:convert';
import 'package:http/http.dart' as http;

class GoogleSheetsApi {
  final String webAppUrl;

  GoogleSheetsApi({required this.webAppUrl});

  /// Append a new row to Google Sheets
  Future<bool> appendRow({
    required String name,
    required String email,
    required String whatsapp,
    required String destination,
    required String travelDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(webAppUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "name": name,
          "email": email,
          "whatsapp": whatsapp,
          "destination": destination,
          "travelDate": travelDate,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return jsonResponse["status"] == "success";
      }
      return false;
    } catch (e) {
      print("Error sending data: $e");
      return false;
    }
  }
}
