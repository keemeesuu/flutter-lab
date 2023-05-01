import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  DateTime createdAt;
  String text;

  Event({
    required this.createdAt,
    required this.text,
  });
}

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({super.key});

  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

// 목표
/*
setState를 동기적으로 가져올수 있나 테스트 duration으로 기다리기
*/
class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  late CalendarFormat _calendarFormat;

  /// Diary 목록
  List<Event> _events = [
    // Dummy Data
    Event(createdAt: DateTime.now(), text: "dummy1"),
    Event(createdAt: DateTime.now(), text: "dummy2"),
    Event(createdAt: DateTime(2023, 05, 03), text: "dummy2"),
  ];

  @override
  void initState() {
    super.initState();

    _calendarFormat = CalendarFormat.month;
  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_selectedDay.year, _selectedDay.month, 1);
    final lastDay = DateTime(_selectedDay.year, _selectedDay.month + 1, 0);

    print("firstDay : $firstDay");
    print("lastDay : $lastDay");

    await Future.delayed(Duration(seconds: 2));
    _events.clear();

    print("count Done");

    _events.add(
      Event(createdAt: DateTime(2023, 06, 03), text: "Add"),
    );

    setState(() {});
  }

  List<Event> _getEventsForTheDay(DateTime day) {
    return _events.where((diary) => isSameDay(day, diary.createdAt)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Table Calendar")),
      body: TableCalendar(
        focusedDay: _selectedDay,
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 10, 16),
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _selectedDay = focusedDay;
          });
          _loadFirestoreEvents();
        },
        eventLoader: _getEventsForTheDay,
      ),
    );
  }
}
