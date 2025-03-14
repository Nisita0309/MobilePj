import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'historyPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController districtController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController humidityController = TextEditingController();

  Future<void> _addWeatherData(
    String district,
    String province,
    String temperature,
    String humidity,
  ) async {
    await FirebaseFirestore.instance.collection('Weather').add({
      'district': district,
      'province': province,
      'temperature': temperature,
      'humidity': humidity,
    });
  }

  void _clearFields() {
    districtController.clear();
    provinceController.clear();
    temperatureController.clear();
    humidityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 154, 219),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.cloud_outlined,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
            child: const Text(
              'History',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: districtController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  labelText: 'District',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 165, 154, 219),
                  ),
                ),
                cursorColor: Color.fromARGB(255, 165, 154, 219),
                style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: provinceController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  labelText: 'Province',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 165, 154, 219),
                  ),
                ),
                cursorColor: Color.fromARGB(255, 165, 154, 219),
                style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: temperatureController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  labelText: 'Temperature (°C)',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 165, 154, 219),
                  ),
                ),
                cursorColor: Color.fromARGB(255, 165, 154, 219),
                style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: humidityController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 165, 154, 219),
                    ),
                  ),
                  labelText: 'Humidity (%)',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 165, 154, 219),
                  ),
                ),
                cursorColor: Color.fromARGB(255, 165, 154, 219),
                style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addWeatherData(
                  districtController.text,
                  provinceController.text,
                  temperatureController.text,
                  humidityController.text,
                ).then((_) {
                  _clearFields();
                });
              },
              child: const Text('Add Weather Data'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 165, 154, 219),
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Color.fromARGB(255, 165, 154, 219),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
