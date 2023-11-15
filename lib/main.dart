import 'dart:math';

import 'package:flutter/material.dart';
import 'package:puzzle_hack/game_manager.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GameManager manager;

  @override
  void initState() {
    manager = GameManager();
    manager.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double side = min(size.height, size.width);
    side -= 50;
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Center(
        child: SizedBox(
          width: side,
          height: side,
          child: Stack(
            children: listItem((side - 10 * 3) / 4),
          ),
        ),
      ),
    );
  }

  List<Widget> listItem(double size) {
    List<Widget> ls = [];
    for (int i = 1; i <= 15; i++) {
      var pos = manager.getValuePos(i);
      debugPrint("$i ${pos.x} ${pos.y}");
      Widget w = AnimatedPositioned(
        top: pos.y * (size + 10),
        left: pos.x * (size + 10),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutSine,
        child: InkWell(
          onTap: () {
            if (manager.getActionByValue(i) == null) return;
            manager.doAction(manager.getActionByValue(i)!);
            setState(() {});
          },
          child: Container(
            width: size,
            height: size,
            color: Colors.white,
            child: Center(child: Text(i.toString())),
          ),
        ),
      );
      ls.add(w);
    }
    return ls;
  }
}
