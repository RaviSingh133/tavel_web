import 'dart:async';
import 'package:flutter/material.dart';
import '../../Theme/theme.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  late PageController _pageController;
  Timer? _autoScrollTimer;

  final List<Map<String, String>> testimonials = [
    {
      "name": "Vinod Mahajan",
      "image": "asset/review images/img1.jpg",
      "reviewLine": "Worth the money.",
    },
    {
      "name": "Lovepreet Singh & Shalu Rani",
      "image": "asset/review images/img2.jpg",
      "reviewLine":
          "From transport to hotels to destinations everything was smooth.",
    },
    {
      "name": "Mukesh Kumar",
      "image": "asset/review images/img3.jpg",
      "reviewLine": "Trip organised wonderfully.",
    },
    {
      "name": "Deepak Guglani",
      "image": "asset/review images/img4.jpg",
      "reviewLine": "Best support provided from beginning till end.",
    },
    {
      "name": "Mani",
      "image": "asset/review images/img5.jpg",
      "reviewLine":
          "My recent trip was unforgettable experience filled with breathtaking views,"
              " fresh air and peaceful surroundings. The journey itself was an adventure."
              "Camping stay was also amazing.Thank you travshala",
    },
  ];

  int _currentIndex = 0;
  static const int _initialPage = 1000; // Large number for infinite feel

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "WHAT OUR CLIENTS SAY",
              style: TextStyle(
                color: DefaultColors.aboutHeadingColor,
                fontSize: isMobile ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: isMobile ? 350 : 400,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index % testimonials.length;
                  });
                },
                itemBuilder: (_, index) {
                  final item = testimonials[index % testimonials.length];
                  return Center(
                    child: TestimonialCard(
                      name: item['name']!,
                      imagePath: item['image']!,
                      reviewLine: item['reviewLine']!,
                      isMobile: isMobile,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Swipe Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                testimonials.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index ? Colors.teal : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Testimonial Card (same as before)
class TestimonialCard extends StatelessWidget {
  const TestimonialCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.reviewLine,
    required this.isMobile,
  });

  final String name;
  final String imagePath;
  final String reviewLine;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: DefaultColors.queryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMobile
            ? _buildMobileLayout()
            : _buildDesktopLayout(screenWidth),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            imagePath,
            width: 100,
            height: 100,
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          reviewLine,
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        _buildStars(),
      ],
    );
  }

  Widget _buildDesktopLayout(double screenWidth) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.3,
              height: screenWidth * 0.3,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(reviewLine, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                _buildStars(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStars() {
    return Row(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: List.generate(
        5,
        (_) => const Icon(Icons.star, size: 16, color: Colors.teal),
      ),
    );
  }
}
