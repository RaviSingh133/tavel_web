import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  final bool isMobile;
  final Function(GlobalKey) scrollToSection;
  final String currentSection;
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey servicesKey;
  final GlobalKey testimoniesKey;
  final GlobalKey contactKey;

  const CustomAppBar({
    super.key,
    required this.isMobile,
    required this.scrollToSection,
    required this.currentSection,
    required this.homeKey,
    required this.aboutKey,
    required this.servicesKey,
    required this.testimoniesKey,
    required this.contactKey,
  });

  Widget _navItem(String text, GlobalKey key) {
    final bool isActive = currentSection == text;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: () => scrollToSection(key),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.blue : Colors.black87,
            decoration:
            isActive ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 5,
      leading: isMobile
          ? Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.black87),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      )
          : null,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo
          Row(
            children: [
              Image.asset(
                'asset/appbar_logo/main logo.jpg',
                height: 150,
                filterQuality: FilterQuality.medium,
              )
            ],
          ),

          if (!isMobile)
            Row(
              children: [
                _navItem("Home", homeKey),
                _navItem("About Us", aboutKey),
                _navItem("Services", servicesKey),
                _navItem("Testimonies", testimoniesKey),
                _navItem("Contacts", contactKey),
              ],
            ),

          if (!isMobile)
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse('https://wa.me/+918989530008');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffDDDF00),
                foregroundColor: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text("Get in Touch"),
            ),
        ],
      ),
    );
  }
}
