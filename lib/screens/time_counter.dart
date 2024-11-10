import 'dart:async';

import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  const TimeCounter({super.key});

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  StreamController<int> controller = StreamController<int>();

  timeCounter() async {
    for(int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(seconds: 1));
      controller.sink.add(i);
    }
    controller.close();
  }

  @override
  void initState() {
    super.initState();
    timeCounter();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Counter Stream"),
      ),
      body: Center(
        child: StreamBuilder(stream: controller.stream, 
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Text("${snapshot.data}");
          } else {
            return const Text("No Data");
          }
        }),
      ),
    );
  }
}