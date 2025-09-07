import 'package:flutter/material.dart';
import 'package:travel_application/landing_page/widgets/Review.dart';
import 'package:travel_application/landing_page/widgets/about_us.dart';
import 'package:travel_application/landing_page/widgets/background.dart';
import 'package:travel_application/landing_page/widgets/contact.dart';
import 'package:travel_application/landing_page/widgets/custom_appbar.dart';
import 'package:travel_application/landing_page/widgets/faq.dart';
import 'package:travel_application/landing_page/widgets/horizontal_slider.dart';
import 'package:travel_application/landing_page/widgets/query_form.dart';
import 'package:travel_application/landing_page/widgets/services_container.dart';
import 'package:travel_application/landing_page/widgets/trending_destination.dart';
import '../Theme/theme.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final homeKey = GlobalKey();
  final aboutKey = GlobalKey();
  final servicesKey = GlobalKey();
  final testimoniesKey = GlobalKey();
  final contactKey = GlobalKey();

  final scrollController = ScrollController();
  String currentSection = "Home";

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  // 🔹 Scroll Section Tracking
  void _onScroll() {
    _checkSectionVisibility(homeKey, "Home");
    _checkSectionVisibility(aboutKey, "About Us");
    _checkSectionVisibility(servicesKey, "Services");
    _checkSectionVisibility(testimoniesKey, "Testimonies");
    _checkSectionVisibility(contactKey, "Contacts");
  }

  void _checkSectionVisibility(GlobalKey key, String sectionName) {
    final context = key.currentContext;
    if (context != null) {
      final box = context.findRenderObject() as RenderBox;
      final position = box.localToGlobal(Offset.zero);

      if (position.dy >= 0 &&
          position.dy < MediaQuery.of(context).size.height / 2) {
        if (currentSection != sectionName) {
          setState(() => currentSection = sectionName);
        }
      }
    }
  }

  // 🔹 Smooth Scroll to Section
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  // 🔹 Drawer for Mobile View
  Drawer _buildDrawer(bool isMobile) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: DefaultColors.queryColor),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            selected: currentSection == "Home",
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(homeKey);
            },
          ),
          ListTile(
            title: const Text('About Us'),
            selected: currentSection == "About Us",
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(aboutKey);
            },
          ),
          ListTile(
            title: const Text('Services'),
            selected: currentSection == "Services",
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(servicesKey);
            },
          ),
          ListTile(
            title: const Text('Testimonies'),
            selected: currentSection == "Testimonies",
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(testimoniesKey);
            },
          ),
          ListTile(
            title: const Text('Contacts'),
            selected: currentSection == "Contacts",
            onTap: () {
              Navigator.pop(context);
              _scrollToSection(contactKey);
            },
          ),
        ],
      ),
    );
  }

  // 🔹 Helper for Dynamic Spacing
  double _getSectionSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 20; // mobile
    if (width < 1200) return 40; // tablet
    return 60; // desktop
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return BackgroundLayout(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: isMobile ? _buildDrawer(isMobile) : null,
          body: CustomScrollView(
            controller: scrollController,
            slivers: [
              CustomAppBar(
                isMobile: isMobile,
                scrollToSection: _scrollToSection,
                currentSection: currentSection,
                homeKey: homeKey,
                aboutKey: aboutKey,
                servicesKey: servicesKey,
                testimoniesKey: testimoniesKey,
                contactKey: contactKey,
              ),
              SliverToBoxAdapter(
                child: Builder(
                  builder: (context) {
                    double sectionSpacing = _getSectionSpacing(context);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          key: homeKey,
                          height: MediaQuery.of(context).size.height * 0.85,
                          child: const HorizontalSlider(),
                        ),
                        const QueryForm(),
                        SizedBox(height: sectionSpacing),
                        Container(key: aboutKey, child: const AboutUs()),
                        SizedBox(height: sectionSpacing),
                        const TrendingDestination(),
                        SizedBox(height: sectionSpacing),
                        Container(
                            key: servicesKey, child: const ServicesContainer()),
                        SizedBox(height: sectionSpacing),
                        Container(
                            key: testimoniesKey,
                            child: const TestimonialsSection()),
                        SizedBox(height: sectionSpacing),
                        const Faq(),
                        Container(key: contactKey, child: const Contact()),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
