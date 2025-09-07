import 'package:flutter/material.dart';
import 'package:travel_application/Theme/image_string.dart';
import 'package:url_launcher/url_launcher.dart';

import 'find_us_on.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  Future<void> _launchURL(BuildContext context, String url, String platform) async {
    _showPopup(context, platform); // Show popup before launching
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
    final bool isMobile = screenWidth < 600;
    final bool showImage = screenWidth > 600;

    // 🔹 Find Us Section
    Widget findUsSection = Container(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
        children: [
          const Text(
            'Find Us on :',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: isMobile ? MainAxisAlignment.start : MainAxisAlignment.start,
            children: [
              SocialImageButton(
                imagePath: 'asset/find_us_on_image/thread.png',
                tooltip: 'Thread',
                url: 'https://www.threads.com/@travshala.in?igshid=NTc4MTIwNjQ2YQ==',
              ),
              const SizedBox(width: 5),
              SocialImageButton(
                imagePath: 'asset/find_us_on_image/insta.png',
                tooltip: 'Instagram',
                url: 'https://www.instagram.com/travshala.in?igsh=aHZxaWNkZnhjb3Zz&utm_source=qr',
              ),
            ],
          ),
        ],
      ),
    );

    return Stack(      children: [
        Column(
          children: [
            Container(
              height: 250,
              color: Colors.transparent,
            ),
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A5A49),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(screenWidth * 2.5, 500),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Contact us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Address : 286-C, Block C, First Floor,\nBRS Nagar, Ludhiana, 141012',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Contact : +91 8989530008,\n +91 9015000801',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Email : TravShala@info.com',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(height: 10),

                        // 🔹 On small screens, show Find Us here
                        if (isMobile) findUsSection,
                      ],
                    ),
                  ),
                ),

                // 🔹 On large screens, use Positioned
                if (!isMobile)
                  Positioned(
                    top: 150,
                    left: 500,
                    child: findUsSection,
                  ),
              ],
            ),
          ],
        ),

        // 🔹 Show image only on larger screens
        if (showImage)
          Positioned(
            top: -5,
            bottom: -10,
            left: 0,
            child: Image(image: AssetImage(RImages.contactImage)),
          ),
      ],
    );
  }
}
