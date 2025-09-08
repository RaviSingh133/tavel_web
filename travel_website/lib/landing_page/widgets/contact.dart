import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'find_us_on.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  Future<void> _launchURL(BuildContext context, String url, String platform) async {
    _showPopup(context, platform);
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showPopup(BuildContext context, String platform) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          title: Text(
            "Opening $platform",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("You are about to visit our $platform page."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    // 🔹 Find Us Section
    Widget findUsSection = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Find Us on:',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialImageButton(
              imagePath: 'asset/find_us_on_image/treads.jpg',
              tooltip: 'Thread',
              url: 'https://www.threads.com/@travshala.in?igshid=NTc4MTIwNjQ2YQ==',
            ),
            const SizedBox(width: 10),
            SocialImageButton(
              imagePath: 'asset/find_us_on_image/insta.jpg',
              tooltip: 'Instagram',
              url: 'https://www.instagram.com/travshala.in?igsh=aHZxaWNkZnhjb3Zz&utm_source=qr',
            ),
          ],
        ),
      ],
    );

    // 🔹 Contact Details Section
    Widget contactDetails = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Contact us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Address:\n286-C, Block C, First Floor,\nBRS Nagar, Ludhiana, 141012',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 12),
        Text(
          'Contact:\n+91 8989530008, +91 9015000801',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(height: 12),
        Text(
          'Email:\nTravShala@info.com',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      decoration: const BoxDecoration(
        color: Color(0xFF3A5A49),
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(1000, 300),
        ),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          findUsSection,
          const SizedBox(height: 30),
          contactDetails,
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2,child: findUsSection),
          Expanded(child: SizedBox(width: 20,)),
          Expanded(flex: 1,child: contactDetails),
        ],
      ),
    );
  }
}
