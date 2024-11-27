import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();
}

class MainAppState extends State<MainApp> { 
  String quote = "Nach der Erschwernis kommt die Erleichterung."; // immer das erste Zitat
  String author = "Unbekannt";    // immer der erste Autor
  Future<void>getQuote() async {  // das ist die Funktion, die die Zitate von der API holt
    final response = await
    http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"), // das ist die API von der die Zitate geholt werden
    headers: {
      "x-Api-Key": '58QgRFpoOdfVqr3FiNrNVw==khlnt3f6pa729CBM'}// mwin API Key
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
            setState(() {
        quote = data[0]["quote"]; 
        author = data[0]["author"];
      }
     );
    }
  }
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
            title: const Text("Zitat",
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          [
            const SizedBox(height: 170),
             Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(quote, // Zitat
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 219, 210, 210),
                  fontStyle: FontStyle.italic,
                ),
                ),
              ),
            ),
              const SizedBox(height: 20), 
               Text("- $author", // author
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 219, 210, 210),
                fontStyle: FontStyle.italic,
              ),
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                onPressed: getQuote,
              child: const Text("next",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
            const SizedBox(height: 180), 
          ],
        ),
      ),
    );
  }
}
