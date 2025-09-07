import 'package:flutter/material.dart';
import 'package:travel_application/Theme/image_string.dart';

import '../../Theme/theme.dart';

class TrendingDestination extends StatelessWidget {
  const TrendingDestination({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRENDING DESTINATIONS',
            style: TextStyle(color: DefaultColors.aboutHeadingColor,fontSize: 32,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 350,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                destinationCard(RImages.vietnam, 'Vietnam','@ Rs 49,999 /-'),
                SizedBox(width: 20,),
                destinationCard(RImages.bali, 'Bali','@ Rs 39,999 /-'),
                SizedBox(width: 20,),
                destinationCard(RImages.dubai, 'Dubai','@ Rs 49,999 /-'),
                SizedBox(width: 20,),
                destinationCard(RImages.phuket, 'Phuket and Krabi','@ Rs 34,999 /-'),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget destinationCard(String imagePath, String title, String price) {
    return Container(
      width: 230,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 8,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black45,
                      offset: Offset(1, 1),
                    )
                  ],
                ),
              ),
            ),
            // Text at bottom-left
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black45,
                      offset: Offset(1, 1),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
