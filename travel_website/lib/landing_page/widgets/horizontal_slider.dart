import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travel_application/Theme/image_string.dart';

class HorizontalSlider extends StatefulWidget {
  const HorizontalSlider({super.key});

  @override
  UpperHorizontalSlider createState() => UpperHorizontalSlider();
}

class UpperHorizontalSlider extends State<HorizontalSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _slides = [
    {"image": RImages.sliderBanner1, "title": "Summit to sea"},
    {"image": RImages.sliderBanner2, "title": "Passport to Romance"},
    {"image": RImages.sliderBanner3, "title": "Great family escapes"},
    {"image": RImages.sliderBanner4, "title": "The bag pack trail"},
    {"image": RImages.sliderBanner5, "title": "Corporate Retreats"},
  ];

  static const int _initialPage = 1000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _currentPage = _initialPage;

    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    setState(() => _currentPage++);
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    setState(() => _currentPage--);
    _pageController.animateToPage(
      _currentPage,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final realIndex = _currentPage % _slides.length;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            // PageView
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                final realIndex = index % _slides.length;
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(_slides[realIndex]["image"]!),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
            ),

            // Animated Title Only
            Positioned.fill(
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 700),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: Text(
                    _slides[realIndex]["title"]!,
                    key: ValueKey<int>(realIndex),
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Left Arrow
            Positioned(
              left: 20,
              top: 220,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.white70, size: 40),
                onPressed: _previousPage,
              ),
            ),

            // Right Arrow
            Positioned(
              right: 20,
              top: 220,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios,
                    color: Colors.white70, size: 40),
                onPressed: _nextPage,
              ),
            ),

            // Dots Indicator
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_slides.length, (index) {
                  final realPage = _currentPage % _slides.length;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: realPage == index ? 20 : 10,
                    decoration: BoxDecoration(
                      color:
                      realPage == index ? Colors.white : Colors.white54,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
