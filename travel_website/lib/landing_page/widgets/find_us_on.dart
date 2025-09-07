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
        borderRadius: BorderRadius.circular(50),
        child: Container(
          width: 50, // button size
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8), // adds spacing around the image
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // ensures full image is visible
            ),
          ),
        ),
      ),
    );
  }
}
