import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Decompte ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(41, 40, 40, 1),
      ),
      home: const MyDecompte(),
    );
  }
}

class MyDecompte extends StatefulWidget {
  const MyDecompte({super.key});

  @override
  State<MyDecompte> createState() => _MyDecompteState();
}

class _MyDecompteState extends State<MyDecompte> {
  int _compteur = 20; // Variable utilisé pour decompter
  bool _demarrer_decompte =
      false; // True - Demarrer ou False Arreter le decompte met
  late Timer _local_timer; // Timer utilisé pour les ticks

  void startDecompte() {
    if (_demarrer_decompte == true) {
      _local_timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_compteur > 0) {
            _compteur--;
          } else {
            timer.cancel();
            _compteur = 20;
            _demarrer_decompte = false;
          }
        });
      });
    }
  }

  void stopDecompte() {
    if (_demarrer_decompte == false) {
      setState(() {
        _local_timer.cancel();
        //_demarrer_decompte = false;
        _compteur = 20;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                !(_demarrer_decompte) ? "Cliquez pour démarrer" : "En cours...",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  value: _compteur / 20.0,
                  backgroundColor: Colors.orange[600],
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(
                "$_compteur",
                style: TextStyle(
                  color: Colors.green[50],
                  fontSize: 150,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _demarrer_decompte = !(_demarrer_decompte);
                    if (_demarrer_decompte == true) {
                      startDecompte();
                    } else {
                      stopDecompte();
                    }
                  });
                },
                child: Text(
                  !(_demarrer_decompte) ? "Demarrer" : "Arreter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _demarrer_decompte ? Colors.red : Colors.green,
                  foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  fixedSize: Size(110, 110),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
