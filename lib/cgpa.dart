import 'package:flutter/material.dart';

class Cgpa extends StatefulWidget {
  @override
  _CgpaState createState() => _CgpaState();
}

class _CgpaState extends State<Cgpa> {
  TextEditingController c1 = TextEditingController();
  TextEditingController cr1 = TextEditingController();

  TextEditingController c2 = TextEditingController();
  TextEditingController cr2 = TextEditingController();

  String calculatedResult = ''; // Store the calculated result here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA Calculator'),
        backgroundColor: Color.fromARGB(255, 0, 89, 255),
      ),
      body: Container(
        color: Colors.black, // Set the background color to black
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150, // Set a specific width for the second TextField
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: cr1,
                      decoration: InputDecoration(
                        labelText: 'Graded Credits Completed',
                        border: OutlineInputBorder(),
                        hintText: 'Completed Credits', // Text color
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ), // Add some spacing between the text fields
                  Container(
                    width: 150,
                    // Set a specific width for the first TextField
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: c1,
                      decoration: InputDecoration(
                        labelText: 'Current CGPA',
                        border: OutlineInputBorder(),
                        hintText: 'Enter your current CGPA',
                        // Text color
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 150, // Set a specific width for the fourth TextField
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: cr2,
                      decoration: InputDecoration(
                        labelText: 'Graded Credits Completed',
                        border: OutlineInputBorder(),
                        hintText: 'Completed Credits',
                        // Text color
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ), // Add some spacing between the text fields
                  Container(
                    width: 150, // Set a specific width for the third TextField
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: c2,
                      decoration: InputDecoration(
                        labelText: 'Sem GPA',
                        border: OutlineInputBorder(),
                        hintText: 'Current GPA',
                        // Text color
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 0, 89, 255),
                      Color.fromARGB(202, 0, 58, 203),
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed: () {
                      double currentCGPA = double.tryParse(c1.text) ?? 0.0;
                      int totalCredits = int.tryParse(cr1.text) ?? 0;

                      double currentGPA = double.tryParse(c2.text) ?? 0.0;
                      int creds = int.tryParse(cr2.text) ?? 0;

                      double calculatedCGPA =
                          (currentCGPA * totalCredits + currentGPA * creds) /
                              (totalCredits + creds);

                      setState(() {
                        calculatedResult = 'CGPA : $calculatedCGPA';
                      });
                    },
                    child: Text('Calculate'),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                calculatedResult,
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
