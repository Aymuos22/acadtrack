import 'package:flutter/material.dart';
import 'display_page.dart';
import 'cgpa.dart';
import 'store_gpa.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'semester_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDireqctory.path);
  Hive.registerAdapter(SemesterAdapter());
  await Hive.openBox<Semester>('semesters');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(), // Your root widget
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedGrade = 'S';
  int gradeValue = 10;
  List<String> subject = [];
  List<double> credits = [];
  List<int> gpoint = [];
  List<String> grade = [];

  Map<String, int> gradeValueMap = {
    'S': 10,
    'A': 9,
    'B': 8,
    'C': 7,
    'D': 6,
    'E': 5,
    'F': 0,
  };

  TextEditingController s = TextEditingController();
  TextEditingController c = TextEditingController();

  void calculateGradeValue() {
    String grade = selectedGrade;
    gradeValue = gradeValueMap[grade] ?? 0;
    setState(() {});
  }

  void Submit() {
    double gval = 0;
    double sum = 0;
    double gpa = 0;
    for (int i = 0; i < credits.length; i++) {
      gval += credits[i] * gpoint[i];
      sum += credits[i];
    }
    gpa = gval / sum;

    // Navigate to the second page and pass the GPA data
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DisplayPage(gpa: gpa.toString())),
    );
  }

  void Clear() {
    if (credits.length > 0) {
      credits.removeAt(credits.length - 1);
      subject.removeAt(subject.length - 1);
      gpoint.removeAt(gpoint.length - 1);
      grade.removeAt(grade.length - 1);
      setState(() {}); // Update the UI
    }
  }

  void Add() {
    subject.add(s.text);
    grade.add(selectedGrade);
    credits.add(double.tryParse(c.text) ?? 0);
    gpoint.add(gradeValue);
    s.clear();
    c.clear();
    setState(() {}); // Update the UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator'),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        // Add a Drawer to the Scaffold
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Acad Track',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Calculate CGPA'),
              onTap: () {
                // Handle item 1 tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Cgpa()),
                ); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Calculate GPA'),
              onTap: () {
                // Handle item 2 tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                ); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Track Your Academics'),
              onTap: () {
                // Handle item 2 tap
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreGpa()),
                ); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 89, 255),
                    Color.fromARGB(202, 0, 58, 203),
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TextField(
                                controller: s,
                                decoration:
                                    InputDecoration(labelText: 'Subject')),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: TextField(
                              controller: c,
                              decoration: InputDecoration(labelText: 'Credits'),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0),
                                color: Colors.black,
                              ),
                              child: DropdownButton<String>(
                                value: selectedGrade,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedGrade = newValue!;
                                    calculateGradeValue();
                                  });
                                },
                                items: gradeValueMap.keys.map((grade) {
                                  return DropdownMenuItem<String>(
                                    value: grade,
                                    child: Text(
                                      grade,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                                underline: Container(
                                  height: 2,
                                  color: Colors.white,
                                ),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                dropdownColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: Container(
                          width: 300.0,
                          height: 400.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: subject.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            subject[index].toUpperCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Credits: ${credits[index].toStringAsFixed(2)}",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(
                                                "Grade: ${grade[index]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                "Grade Value: ${gpoint[index]}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 10,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              onPressed: Clear,
                              child: Text(
                                'Clear',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              onPressed: Add,
                              child: Text(
                                'Add',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: ElevatedButton(
                              onPressed: Submit,
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
