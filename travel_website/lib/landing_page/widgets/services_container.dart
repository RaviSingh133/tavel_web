import 'package:flutter/material.dart';
import 'package:travel_application/Theme/image_string.dart';
import '../../Theme/theme.dart';

class ServicesContainer extends StatelessWidget {
  const ServicesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'YOUR JOURNEY, OUR SERVICES',
            style: TextStyle(
              color: DefaultColors.aboutHeadingColor,
              fontSize: screenWidth < 600 ? 24 : 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isMobile
                    ? 2
                    : screenWidth < 1200
                    ? 3
                    : 6; // adjust number of columns based on screen size
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: const [
                    ServicesItem(
                        images: RImages.flight, label: 'Flight Booking'),
                    ServicesItem(
                        images: RImages.hotels,
                        label: 'Hotel & Accommodation booking'),
                    ServicesItem(
                        images: RImages.transportServices,
                        label: 'Transport Services'),
                    ServicesItem(
                        images: RImages.tourPackages,
                        label: 'Tour Packages'),
                    ServicesItem(
                        images: RImages.visa, label: 'Visa Assistance'),
                    ServicesItem(
                        images: RImages.boat, label: 'Cruise Booking'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesItem extends StatelessWidget {
  final String images;
  final String label;

  const ServicesItem({super.key, required this.images, required this.label});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          images,
          width: isMobile ? 50 : 60,
          height: isMobile ? 50 : 60,
        ),
        const SizedBox(height: 10),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 14 : 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
