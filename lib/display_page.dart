import 'package:flutter/material.dart';

class DisplayPage extends StatelessWidget {
  final String gpa;
  String loc = 'assets/top.jpg';

  DisplayPage({required this.gpa});

  @override
  Widget build(BuildContext context) {
    if (double.parse(gpa) >= 8 && double.parse(gpa) < 9) {
      loc = 'assets/ok.jpg';
    } else if (double.parse(gpa) < 8) {
      loc = 'assets/noose.jpg';
    }

    final formattedGpa =
        double.parse(gpa).toStringAsFixed(3); // Round GPA to 3 decimal places

    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Result'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black, // Set the background color of the entire page
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(loc),
              Text(
                formattedGpa, // Display rounded GPA
                style: TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
