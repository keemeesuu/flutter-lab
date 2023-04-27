import 'package:flutter/material.dart';
import 'package:lab/features/simple_calendar/date_time.dart';
import 'package:lab/features/simple_calendar/widgets/dayOfWeek.dart';

class SimpleCalendar extends StatefulWidget {
  const SimpleCalendar({super.key});

  @override
  State<SimpleCalendar> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  String _dateType = "week"; // week, month

  List<DateTime> date = [];

  List<String> dayNameOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  List<DateTime> _daysOfWeek = [];

  final DateTime _today = DateTime.utc(2023, 04, 26);

  /// 캘린더에서 현재 노출되는 날짜
  DateTime _showsDay = DateTime.now();
  String _showsYearName = "";
  String _showsMonthName = "";

  @override
  void initState() {
    super.initState();

    // 현재주 월~일 구하기
    _daysOfWeek = _getWeeks(_today);
    _showsYearName = _showsDay.year.toString();
    _showsMonthName = _showsDay.month.toString();
  }

  /// 해당주의 월요일 구하기
  DateTime _getMondayOfWeek(DateTime day) {
    DateTime mondayOfWeek = day.subtract(Duration(days: day.weekday - 1));
    return mondayOfWeek;
  }

  /// 지정날자의 주(월~일) 구하기
  List<DateTime> _getWeeks(DateTime day) {
    int daysOfWeek = 7;
    List<DateTime> week = [];
    DateTime monday = day.subtract(Duration(days: day.weekday - 1));
    for (var i = 0; i < daysOfWeek; i++) {
      week.add(monday.add(Duration(days: i)));
    }

    return week;
  }

  /// 현재 캘린더에 보여지는 주의 다음주(월~일) 구하기
  void _getNextWeeks() {
    DateTime mondayOfWeek =
        _showsDay.subtract(Duration(days: _showsDay.weekday - 1));
    DateTime mondayOfNextWeek = mondayOfWeek.add(const Duration(days: 7));
    _showsDay = mondayOfNextWeek;

    int weekCount = 7;
    List<DateTime> week = [];
    DateTime monday =
        mondayOfNextWeek.subtract(Duration(days: mondayOfNextWeek.weekday - 1));
    for (var i = 0; i < weekCount; i++) {
      week.add(monday.add(Duration(days: i)));
    }

    setState(() {
      _showsYearName = _showsDay.year.toString();
      _showsMonthName = _showsDay.month.toString();
      _daysOfWeek = week;
    });
  }

  /// 현재 캘린더에 보여지는 주의 이전(월~일) 구하기
  void _getPrevWeeks() {
    DateTime mondayOfPrevWeek =
        _showsDay.subtract(Duration(days: _showsDay.weekday));
    _showsDay = mondayOfPrevWeek;

    int weekCount = 7;
    List<DateTime> week = [];
    DateTime monday =
        mondayOfPrevWeek.subtract(Duration(days: mondayOfPrevWeek.weekday - 1));
    for (var i = 0; i < weekCount; i++) {
      week.add(monday.add(Duration(days: i)));
    }

    setState(() {
      _showsYearName = _showsDay.year.toString();
      _showsMonthName = _showsDay.month.toString();
      _daysOfWeek = week;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SimpleCalendar"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "$_showsYearName / $_showsMonthName",
                  style: TextStyle(fontSize: 20),
                ),
                const Spacer(),

                /// Prev Week BUtton
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _getPrevWeeks,
                ),

                /// Next Week Button
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _getNextWeeks,
                ),
                GestureDetector(
                  onTap: () => print("change"),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      "W",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var day in dayNameOfWeek)
                  DayOfWeek(
                    name: day,
                  ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (var day in _daysOfWeek)
                  DayOfWeek(
                    name: convertDateTimeToDay(day),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
