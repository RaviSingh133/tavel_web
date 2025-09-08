// lib/screens/query_form.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Theme/theme.dart';
import '../../google_sheets_services.dart';

class QueryForm extends StatefulWidget {
  const QueryForm({super.key});

  @override
  State<QueryForm> createState() => _QueryFormState();
}

class _QueryFormState extends State<QueryForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Focus nodes for manual focus
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _whatsappFocus = FocusNode();
  final FocusNode _destinationFocus = FocusNode();
  final FocusNode _dateFocus = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    destinationController.dispose();
    dateController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _whatsappFocus.dispose();
    _destinationFocus.dispose();
    _dateFocus.dispose();
    super.dispose();
  }

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
        dateController.text = DateFormat('dd MMM yyyy').format(pickedDate);
      });
    }
  }

  /// Validate one field at a time and focus
  bool _validateAndFocusSingle() {
    // Name
    if (nameController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_nameFocus);
      _showSnackBar("Please enter your name");
      return false;
    }

    // Email
    if (emailController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_emailFocus);
      _showSnackBar("Please enter your email");
      return false;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      FocusScope.of(context).requestFocus(_emailFocus);
      _showSnackBar("Enter a valid email");
      return false;
    }

    // WhatsApp
    if (whatsappController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_whatsappFocus);
      _showSnackBar("Please enter your WhatsApp number");
      return false;
    }
    if (whatsappController.text.length < 10) {
      FocusScope.of(context).requestFocus(_whatsappFocus);
      _showSnackBar("Enter a valid number");
      return false;
    }

    // Destination
    if (destinationController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_destinationFocus);
      _showSnackBar("Please enter your destination");
      return false;
    }

    // Date
    if (dateController.text.trim().isEmpty) {
      FocusScope.of(context).requestFocus(_dateFocus);
      _showSnackBar("Please select travel date");
      return false;
    }

    return true; // All good
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Send data to Google Sheets
  Future<void> sendData() async {
    if (!_validateAndFocusSingle()) return; // Validate step-by-step

    setState(() => _isLoading = true);

    bool success = await GoogleSheetsService.saveQuery(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      whatsapp: whatsappController.text.trim(),
      destination: destinationController.text.trim(),
      travelDate: dateController.text.trim(),
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
                  Expanded(
                    child: _buildTextField(
                      label: "Your Name",
                      controller: nameController,
                      focusNode: _nameFocus,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: "Your Email",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _emailFocus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "WhatsApp Number",
                      controller: whatsappController,
                      focusNode: _whatsappFocus,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      label: "Travel Destination",
                      controller: destinationController,
                      focusNode: _destinationFocus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: dateController,
                focusNode: _dateFocus,
                readOnly: true,
                onTap: () => selectDate(context),
                decoration: const InputDecoration(
                  labelText: "Travel Date",
                  suffixIcon: Icon(Icons.calendar_today, color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
                      ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : const Text(
                    "Send Query",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
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
