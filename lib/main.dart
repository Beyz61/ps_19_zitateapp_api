import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


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
  String author = "Unbekannt";   // immer der erste Autor
  
  @override
  void initState() {
    super.initState();
    loadQuote();
  }

  Future<void> loadQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); // um die Zitate zu speichern
    setState(() {
      quote = prefs.getString("quote") ?? quote;
      author = prefs.getString("author") ?? author;
    });
  }
  
   // immer der erste Autor
  Future<void>getQuote() async {  // das ist die Funktion, die die Zitate von der API holt
    final response = await
    http.get(Uri.parse("https://api.api-ninjas.com/v1/quotes"), // das ist die API von der die Zitate geholt werden
    headers: {
      "x-Api-Key": '58QgRFpoOdfVqr3FiNrNVw==khlnt3f6pa729CBM'}// mwin API Key
    );
    if (response.statusCode == 200) { // wenn die API richtig funktioniert
      final data = json.decode(response.body);
            setState(() {
        quote = data[0]["quote"]; 
        author = data[0]["author"];
      }
     );
      SharedPreferences prefs = await SharedPreferences.getInstance(); // um die Zitate zu speichern
      prefs.setString("quote", quote);
      prefs.setString("author", author);  
      }
  }

     Future<void> clearQuote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    prefs.remove("quote");
    prefs.remove("author");
    setState(() {
      quote = "Nach der Erschwernis kommt die Erleichterung.";
      author = "Unbekannt";
    });

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
                  image: AssetImage("assets/image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text("Qoute",
            style: TextStyle(
              shadows:  [
                Shadow(
                  blurRadius: 10.0,
                  color: Color.fromARGB(255, 2, 2, 2),
                  offset: Offset(5.0, 5.0),
                ),
              ],
              fontSize: 70,
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 255, 255, 255),
              fontStyle: FontStyle.italic,
            ),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          [
            const SizedBox(height: 110),
             Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(quote, // Zitat
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
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
               const Divider(
                color: Color.fromARGB(255, 255, 242, 242),
                thickness: 0.8,
              indent: 40,
              endIndent: 40, ),
                const SizedBox(height: 30),
              ElevatedButton(
                onPressed: getQuote, // funktion fürs nächste Zitat
              child: const Text("  NEXT QOUTE  ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
             const SizedBox(height: 10),
            ElevatedButton(
                onPressed: clearQuote,  // funktion um zu löschen
              child: const Text(" CLEAR ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
              ),
            ),
            const SizedBox(height: 190), 
          ],
        ),
      ),
    );
  }
}