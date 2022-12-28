import 'dart:async';

import 'package:flutter/material.dart';

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
  String _hCourante = "00";
  String _mCourante = "00";
  String _sCourante = "00";
  late Timer _timerHorloge;
  bool _startHorloge = false;

  void demarrerHorloge() {
    if (_startHorloge == true) {
      _timerHorloge = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _hCourante = DateTime.now().hour.toString().padLeft(2, '0');
          _mCourante = DateTime.now().minute.toString().padLeft(2, '0');
          _sCourante = DateTime.now().second.toString().padLeft(2, '0');
        });
      });
    }
  }

  void arreterHorloge() {
    if (_startHorloge == false) {
      _timerHorloge.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFe66465),
                  Color(0xFF9198e5),
                ]),
          ),
          child: buildColonneCentrale(),
        ),
      ),
    );
  }

  ElevatedButton buildStartButton() {
    return ElevatedButton(
      onPressed: () {
        if (_startHorloge == false) {
          _startHorloge = !_startHorloge;
          demarrerHorloge();
        }
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
    );
  }

  ElevatedButton buildPauseButton() {
    return ElevatedButton(
      onPressed: () {
        if (_startHorloge == true) {
          _startHorloge = !_startHorloge;
          arreterHorloge();
        }
      },
      child: Icon(
        Icons.pause,
        size: 25,
        color: Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: Size(100, 50),
      ),
    );
  }

  Row buildLigneControles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [buildStartButton(), buildPauseButton()],
    );
  }

  Widget buildAffichageHorraire(value, texte) {
    return Container(
      height: 150,
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
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

  Row buildHeureCourante() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildAffichageHorraire(_hCourante, "heures"),
        buildAffichageHorraire(_mCourante, "minutes"),
        buildAffichageHorraire(_sCourante, "secondes"),
      ],
    );
  }

  Column buildColonneCentrale() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildHeureCourante(),
        buildLigneControles(),
      ],
    );
  }
}
