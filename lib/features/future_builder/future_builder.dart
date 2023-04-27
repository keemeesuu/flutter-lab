import 'package:flutter/material.dart';
import 'dart:math' as math;

class FutureBuilderTest extends StatefulWidget {
  const FutureBuilderTest({super.key});

  @override
  State<FutureBuilderTest> createState() => _FutureBuilderTestState();
}

/// UserModel
class EventModel {
  final DateTime date;

  EventModel({
    required this.date,
  });

  EventModel.empty() : date = DateTime(2000, 01, 01);
}

class _FutureBuilderTestState extends State<FutureBuilderTest> {
  int nextDay = 0;
  Future<EventModel>? futureEvent;

  /// 서버로 데이터를 받아오는 시뮬레이션
  Future<EventModel> fetchEvent(DateTime date) async {
    // 서버통신 대체 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    return EventModel(
      date: date,
    );
  }

  @override
  void initState() {
    super.initState();
    futureEvent = fetchEvent(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event"),
      ),
      body: FutureBuilder(
        future: futureEvent,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData == true) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Text(
                  snapshot.data!.date.toString(),
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () {
          setState(() {
            nextDay++;
            futureEvent = fetchEvent(
              DateTime.now().add(
                Duration(days: nextDay),
              ),
            );
          });
        },
      ),
    );
  }
}
