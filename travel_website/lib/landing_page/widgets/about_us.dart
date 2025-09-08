import 'package:flutter/material.dart';
import 'package:travel_application/Theme/image_string.dart';
import 'package:travel_application/Theme/theme.dart';
import 'package:video_player/video_player.dart'; // Add this in pubspec.yaml

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Text(
              'WHO ARE WE ?',
              style: TextStyle(
                color: DefaultColors.aboutHeadingColor,
                fontSize: screenWidth < 600 ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 30),

            // First Section
            ResponsiveRow(
              mediaPath: RImages.img1,
              text:
              "Your Journey Your Way - We Just Make It Unforgettable.\n\n"
                  "At Travshala we believe traveling is just not a single trip – "
                  "it's personal, emotional & beautifully unique. "
                  "That’s why we don’t just book trips, we craft tailor-made "
                  "experiences that reflect your dream, passion & pace.",
              mediaFirst: false,
              isVideo: false,
              screenWidth: screenWidth,
            ),
            const SizedBox(height: 40),

            // Second Section (Video)
            ResponsiveRow(
              mediaPath: 'asset/about_images/vid1.mp4',
              text:
              "Whether it's sunrise hike in Himalayas or it’s just two hearts "
                  "and one passport or you have a backpack and a wild idea – "
                  "we can design it all.\n\n"
                  "We Start Travshal as we were filled with madness to travel, now it's your turn.\n\n"
                  "We're not just a travel agency. We're your behind the scenes magic makers.",
              mediaFirst: true,
              isVideo: true,
              screenWidth: screenWidth,
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsiveRow extends StatelessWidget {
  final String mediaPath;
  final String text;
  final bool mediaFirst;
  final bool isVideo;
  final double screenWidth;

  const ResponsiveRow({
    super.key,
    required this.mediaPath,
    required this.text,
    required this.mediaFirst,
    required this.isVideo,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 800 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    // Media Widget (Image or Video)
    final mediaWidget = ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: isVideo
          ? VideoPlayerWidget(videoPath: mediaPath)
          : Image.asset(
        mediaPath,
        fit: BoxFit.fitHeight,
        width: isMobile ? double.infinity : screenWidth * 0.4,
        height: isMobile ? 200 : 400,
      ),
    );

    // Text Widget
    final textWidget = Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontSize: screenWidth < 600 ? 14 : 18,
        ),
        textAlign: isMobile ? TextAlign.center : TextAlign.justify,
      ),
    );

    // Layout
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          mediaWidget,
          const SizedBox(height: 20),
          textWidget,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: mediaFirst
          ? [
        Expanded(child: Center(child: mediaWidget)),
        const SizedBox(width: 50),
        Expanded(child: textWidget),
      ]
          : [
        Expanded(child: textWidget),
        const SizedBox(width: 50),
        Expanded(child: Center(child: mediaWidget)),
      ],
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;
  const VideoPlayerWidget({super.key, required this.videoPath});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
      });
    _controller.setLooping(true);
    _controller.setVolume(0); // 🔇 Mute video
    _controller.play(); // ▶️ Auto-play
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : const Center(child: CircularProgressIndicator());
  }
}
