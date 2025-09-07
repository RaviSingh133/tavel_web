import 'package:flutter/material.dart';
import '../../Theme/theme.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment:
          isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
          children: [
            // FAQ Heading
            Text(
              'FAQ :',
              style: TextStyle(
                color: DefaultColors.aboutHeadingColor,
                fontSize: screenWidth < 600 ? 24 : 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            const SizedBox(height: 30),

            // FAQ Items
            const FaqItem(
              question: '1. How is TravShala different from other travel agencies?',
              answer:
              "We're not just a travel agency, we're your travel partners.\n"
                  "That means better deals, customized trips as per your budget, and 24/7 support.\n"
                  "Before, during, and after travel, just say it: we’ll make it happen!",
            ),
            const SizedBox(height: 20),

            const FaqItem(
              question: '2. How far in advance should I book my trip?',
              answer:
              "For international trips, we recommend booking at least 6–8 weeks in advance.\n"
                  "For domestic travel, 3–4 weeks is ideal.\n"
                  "We also handle last-minute getaways based on availability.",
            ),
            const SizedBox(height: 20),

            const FaqItem(
              question: '3. What kind of visa services do you provide?',
              answer:
              "We provide:\n"
                  "1. Tourist Visa\n"
                  "2. Visitor Visa\n"
                  "3. Business Visa",
            ),
            const SizedBox(height: 20),

            const FaqItem(
              question: '4. Is travel insurance included in your package?',
              answer:
              "Travel insurance is optional but highly recommended, especially for international trips.\n"
                  "We can add the best travel insurance to your package at affordable rates.",
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      crossAxisAlignment:
      isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth < 600 ? 18 : 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: isMobile ? TextAlign.start : TextAlign.start,
        ),
        const SizedBox(height: 8),
        Text(
          answer,
          style: TextStyle(
            color: Colors.black87,
            fontSize: screenWidth < 600 ? 14 : 18,
          ),
          textAlign: isMobile ? TextAlign.start : TextAlign.justify,
        ),
      ],
    );
  }
}
