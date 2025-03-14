import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 154, 219),
        title: const Text(
          'Weather Data History',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Weather').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final weatherData = data[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.white,
                  elevation: 3,
                  child: ListTile(
                    title: Text(
                      'District: ${weatherData['district']}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 165, 154, 219),
                      ),
                    ),
                    subtitle: Text(
                      'Province: ${weatherData['province']}\n'
                      'Temperature: ${weatherData['temperature']}°',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 165, 154, 219),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 165, 154, 219),
                          ),
                          onPressed: () {
                            _showEditDialog(context, weatherData);
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 165, 154, 219),
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('Weather')
                                .doc(weatherData.id)
                                .delete();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, DocumentSnapshot weatherData) {
    final TextEditingController temperatureController = TextEditingController(
      text: weatherData['temperature'],
    );
    final TextEditingController humidityController = TextEditingController(
      text: weatherData['humidity'],
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            'Edit Weather Data',
            style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
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
              const SizedBox(height: 8.0),
              TextField(
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
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 165, 154, 219)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('Weather')
                    .doc(weatherData.id)
                    .update({
                      'temperature': temperatureController.text,
                      'humidity': humidityController.text,
                    });
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 165, 154, 219),
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: Color.fromARGB(255, 165, 154, 219),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
