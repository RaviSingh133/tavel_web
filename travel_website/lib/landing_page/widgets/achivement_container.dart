import 'package:flutter/material.dart';

class AchivementContainer extends StatelessWidget {
  const AchivementContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white,Colors.lightBlue.shade300, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GradientItem(number: '256', label: 'Organized Trips'),
            GradientItem(number: '16', label: 'Years of Experience'),
            GradientItem(number: '1498', label: 'Satisfied Customers'),
            GradientItem(number: '458', label: 'Global Partners'),
          ],
        ),
      ),
    );
  }
}

class GradientItem extends StatelessWidget {
  final String number;
  final String label;

  const GradientItem({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
