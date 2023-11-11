import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'semester_model.dart';

class StoreGpa extends StatefulWidget {
  StoreGpa();

  @override
  _StoreGpaState createState() => _StoreGpaState();
}

class _StoreGpaState extends State<StoreGpa> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();
  final TextEditingController _credController =
      TextEditingController(); // Add this controller
  final Box<Semester> semesterBox = Hive.box<Semester>('semesters');

  double givecgpa() {
    // Clear the previous list
    double sum = 0;
    double cgpa = 0;
    for (int i = 0; i < semesterBox.length; i++) {
      final semester = semesterBox.getAt(i);
      if (semester != null) {
        sum += semester.credits;
        cgpa += semester.credits * semester.gpa;
      }
    }
    return cgpa / sum;
  }

  void _showcgpa() {
    double cgpa = givecgpa();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // This is the content of the dialog
        return AlertDialog(
          title: Text('CGPA'),
          content: Text('Your CGPA is: $cgpa'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Track Your Academics',
              style: TextStyle(color: Colors.white),
            ),
            Container(
                child: ElevatedButton(
                    onPressed: _showcgpa,
                    child: Text(
                      "CGPA",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 254, 254, 254),
                    )))
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: semesterBox.length,
                itemBuilder: (BuildContext context, int index) {
                  final semester = semesterBox.getAt(index);
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 94, 102, 117),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black)),
                          padding: EdgeInsets.all(
                              5), // Set the background color here
                          child: ListTile(
                            title: Text(
                              semester?.name ?? '',
                              style: TextStyle(
                                  color: Colors.white), // Set text color
                            ),
                            subtitle: Text(
                              'GPA: ${semester?.gpa ?? ''} \t       Credits: ${semester?.credits ?? ''}',
                              style: TextStyle(
                                  color: Colors.white), // Set text color
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                if (semester != null) {
                                  semesterBox.deleteAt(index);
                                  setState(() {});
                                }
                              },
                            ),
                          )));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter Semester Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Added spacing between text fields
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: TextField(
                        controller: _gpaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter GPA',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      )),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller:
                              _credController, // Add controller for credits
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Credits',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final name = _nameController.text.toUpperCase();
                      final gpa = double.tryParse(_gpaController.text) ?? 0.0;
                      final credits =
                          double.tryParse(_credController.text) ?? 0.0;
                      final newSemester = Semester(name, gpa, credits);
                      semesterBox.add(newSemester);
                      _nameController.clear();
                      _gpaController.clear();
                      _credController.clear();
                      setState(() {});
                    },
                    child: Text('Add Semester'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gpaController.dispose();
    _credController.dispose(); // Dispose the credits controller
    super.dispose();
  }
}
