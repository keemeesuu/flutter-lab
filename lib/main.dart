import 'package:flutter/material.dart';
import 'package:lab/features/future_builder/future_builder.dart';
import 'package:lab/features/simple_calendar/simple_calendar.dart';
import 'package:lab/features/stream_builder/stream_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SimpleCalendar(),
    );
  }
}
