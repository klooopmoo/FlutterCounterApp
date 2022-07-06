import 'dart:math';

import 'package:counter_flutter_app/services/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

void main() {
  runApp(MaterialApp(home: CounterApp()));
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int counter = 0;
  Counter instance = Counter();

  void setupCounter() async {
    counter = await instance.getCount();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupCounter();
  }

  void putCounter(int c) {
    Counter instance = Counter();
    instance.putCount(c);
  }

  dynamic listImages = [
    "assets/potato.png",
    "assets/bunny.png",
    "assets/egg.png",
    "assets/nutella.png",
  ];
  String imgString = "assets/potato.png";
  Random rnd;

  void increaseCounter() {
    setState(() {
      counter++;
    });
    instance.putCount(counter);
  }

  // void increaseStatCounter(){
  //   int a = count;
  //   a ++;
  //   putCounter(a);
  // }

  void decreaseCounter() {
    setState(() {
      counter--;
    });
    instance.putCount(counter);
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
    instance.putCount(counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[400],
        title: Text(
          "Gabe the Babe Awesome Counter",
          style: TextStyle(
            fontFamily: 'Mouse',
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: Image.asset('$imgString')),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: FloatingActionButton(
                onPressed: () {
                  int min = 0;
                  int max = listImages.length;
                  rnd = Random();
                  int r = min + rnd.nextInt(max - min);
                  String image_name = listImages[r].toString();
                  setState(() {
                    imgString = image_name;
                  });
                },
                tooltip: "randomize image",
                child: Icon(Icons.picture_as_pdf_outlined),
                backgroundColor: Colors.teal[400],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Container(
                  child: Text('$counter',
                      style: TextStyle(
                        fontFamily: "Mouse",
                        color: Colors.teal[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      )),
                ),
              )),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: increaseCounter,
                      tooltip: "increase",
                      child: Icon(Icons.add),
                      backgroundColor: Colors.teal[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: decreaseCounter,
                      tooltip: "decrease",
                      child: Icon(Icons.remove),
                      backgroundColor: Colors.teal[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                      onPressed: resetCounter,
                      tooltip: 'reset',
                      child: Icon(Icons.delete),
                      backgroundColor: Colors.teal[400],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
