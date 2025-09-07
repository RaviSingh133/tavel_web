import 'package:flutter/material.dart';
import '../../Theme/theme.dart';
import '../google_sheets_api.dart';

class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}

class _QueryFormState extends State<QueryForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final GoogleSheetsApi sheetService = GoogleSheetsApi(
    webAppUrl: "https://corsproxy.io/?https://script.google.com/macros/s/AKfycbws4SneOvtZFNVi57YhxfJbZoU2Wkg46P4FWSq9c4iChFuHqatQ0E5i8t4Jcxb9s8Rqfg/exec",
  );


  bool _isLoading = false;

  /// Pick travel date
  Future<void> selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  /// Send data to Google Sheets
  Future<void> sendData() async {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        whatsappController.text.isEmpty ||
        destinationController.text.isEmpty ||
        dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("⚠️ Please fill all fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await sheetService.appendRow(
      name: nameController.text,
      email: emailController.text,
      whatsapp: whatsappController.text,
      destination: destinationController.text,
      travelDate: dateController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? "✅ Query sent successfully!" : "❌ Failed to send query!",
        ),
      ),
    );

    if (success) _clearFields();
    setState(() => _isLoading = false);
  }

  /// Clear all fields
  void _clearFields() {
    nameController.clear();
    emailController.clear();
    whatsappController.clear();
    destinationController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: DefaultColors.queryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: _buildTextField("Your Name", nameController)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField("Your Email", emailController)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField(
                          "Your WhatsApp Number", whatsappController,
                          keyboardType: TextInputType.phone)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: _buildTextField(
                          "Travel Destination", destinationController)),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                readOnly: true,
                onTap: () => selectDate(context),
                decoration: const InputDecoration(
                  hintText: "Travel Date",
                  hintStyle: TextStyle(color: Colors.black54),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 20),
              const Text(
                "If you have any query, feel free to connect with us and give us a chance to assist you and create unique memories!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : sendData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DefaultColors.queryButtonColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                    "Send Query",
                    style: TextStyle(
                      fontSize: 16,
                      color: DefaultColors.queryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom text field builder
  Widget _buildTextField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }
}
