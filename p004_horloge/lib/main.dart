import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Horloge(),
    );
  }
}

class Horloge extends StatefulWidget {
  const Horloge({super.key});

  @override
  State<Horloge> createState() => _HorlogeState();
}

class _HorlogeState extends State<Horloge> {
  String _heureCourante = "00";
  String _minuteCourante = "00";
  String _secondeCourante = "00";
  late Timer _timerHorloge;
  bool _startHorloge = false;

  void demarrerHorloge() {
    if (_startHorloge == true) {
      _timerHorloge = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _heureCourante = DateTime.now().hour.toString().padLeft(2, '0');
          _minuteCourante = DateTime.now().minute.toString().padLeft(2, '0');
          _secondeCourante = DateTime.now().second.toString().padLeft(2, '0');
        });
      });
    }
  }

  void arreterHorloge() {
    if (_startHorloge == false) {
      _timerHorloge!.cancel();
    }
  }

  void resetHorloge() {
    setState(() {
      _heureCourante = "00";
      _minuteCourante = "00";
      _secondeCourante = "00";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft, end: Alignment.bottomRight,
                //      colors: [Colors.orange, Colors.green]),
                //colors: [Colors.orange, Colors.purple]),
                //colors: [Colors.lightBlue, Colors.purple]),
                // colors: [Colors.lightBlue, Colors.purple, Colors.orange]),
                // colors: [Colors.lightBlue, Colors.purple, Colors.orange]),
                colors: [Color(0xFFe66465), Color(0xFF9198e5)]),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildAffichageHorraire(_heureCourante, "heures"),
                    buildAffichageHorraire(_minuteCourante, "minutes"),
                    buildAffichageHorraire(_secondeCourante, "secondes"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _startHorloge = !_startHorloge;
                          demarrerHorloge();
                        });
                      },
                      child: Icon(
                        Icons.play_arrow,
                        size: 25,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: Size(100, 50),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _startHorloge = !_startHorloge;
                          arreterHorloge();
                        });
                      },
                      child: Icon(
                        Icons.pause,
                        size: 25,
                        color: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(100, 50)),
                    )
                  ],
                )
              ]),
        ),
      ),
    );
  }

  Widget buildAffichageHorraire(value, texte) {
    return Container(
      height: 150,
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$value",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 80,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$texte",
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          )
        ],
      ),
    );
  }
}
