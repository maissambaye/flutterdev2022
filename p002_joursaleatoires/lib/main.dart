import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Jours aleatoires",
      debugShowCheckedModeBanner: false,
      home: JoursAleatoires(),
    );
  }
}

class JoursAleatoires extends StatefulWidget {
  const JoursAleatoires({super.key});

  @override
  State<JoursAleatoires> createState() => _JoursAleatoiresState();
}

class _JoursAleatoiresState extends State<JoursAleatoires> {
  List<String> jours = [
    "Lundi",
    "Mardi",
    "Mercredi",
    "jeudi",
    "Vendredi",
    "Samedi",
    "Dimanche"
  ];
  int jourCourant = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Jours aleatoires"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Cliquez pour voir un nouveau jour",
                style: TextStyle(color: Colors.red[800], fontSize: 25),
              ),
              Text(
                jours[jourCourant],
                style: TextStyle(color: Colors.green[800], fontSize: 40),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    jourCourant = Random().nextInt(7);
                  });
                },
                child: const Text("Generer jour"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
