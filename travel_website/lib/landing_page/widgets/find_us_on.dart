import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialImageButton extends StatelessWidget {
  final String imagePath;
  final String tooltip;
  final String url;

  const SocialImageButton({
    super.key,
    required this.imagePath,
    required this.tooltip,
    required this.url,
  });

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: _launchURL,
        borderRadius: BorderRadius.circular(12), // Rounded rectangle ripple
        child: Container(
          width: 30, // button size
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white, // Optional background color
            borderRadius: BorderRadius.circular(12), // Rectangle with rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(4), // spacing around image
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Fills rectangle better
          ),
        ),
      ),
    );
  }
}
