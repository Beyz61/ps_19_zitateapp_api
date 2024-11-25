import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 4, 4, 4),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image copy.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text("Poesie",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 255, 254, 254),
              fontStyle: FontStyle.italic
            ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Nach der Erschwernis kommt die Erleichterung.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 219, 210, 210),
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
              const SizedBox(height: 20), 
              ElevatedButton(
                onPressed: () {},
              child: const Text("weiter",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
