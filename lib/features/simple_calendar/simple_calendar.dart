import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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

  /// Start week on
  /// You can setting the start day of the week
  /// 1: Mon, 2: Tue, 3: Wed, 4: Thu, 5: Fri, 6: Sat, 7: Sun
  final int _startWeekAt = 1;

  /// Names of Days
  /// Mon, Thu, Wed, Thu, Fri, Sat, Sun
  late List<String> _weekNames;

  /// Todays date
  final DateTime _today = DateTime.utc(2023, 05, 01);

  /// The Calendar displays the day of the week
  List<DateTime> _daysOfWeek = [];

  /// Started day of the your week
  late DateTime _statredDay;

  /// Displays the current year
  String _showsYearName = "";

  /// Displays the current month
  String _showsMonthName = "";

  @override
  void initState() {
    super.initState();

    // initializeDateFormatting('ko_KR', null);
    // print(DateFormat.EEEE('ko_KR').format(DateTime.now()));

    // Get names of the week
    _weekNames = _getWeekName(_startWeekAt);

    // Get fistday of your week
    _statredDay = _getFirstDayOfWeek(_today);

    // Displays the Current Day info
    _daysOfWeek = _getWeeks(_statredDay);
    _showsYearName = _statredDay.year.toString();
    _showsMonthName = _statredDay.month.toString();
  }

  /// Get names of the week
  List<String> _getWeekName(int day) {
    int startAt = day - 1;
    // default sunday
    List<String> weekNames = ['월', '화', '수', '목', '금', '토', '일'];
    //FIXME: 지역에 따라 다르게 설정하기

    List<String> newWeekNames = [];

    for (int i = startAt; i < weekNames.length; i++) {
      newWeekNames.add(weekNames[i]);
    }
    for (int i = 0; i < startAt; i++) {
      newWeekNames.add(weekNames[i]);
    }

    return newWeekNames;
  }

  /// Get fist day of your week
  DateTime _getFirstDayOfWeek(DateTime day) {
    DateTime firstDayOfWeek =
        day.subtract(Duration(days: day.weekday - _startWeekAt));

    if (_startWeekAt > day.weekday) {
      // 예) 현재 목요일인데 시작지정일이 금요일부터면 이전주 금요일 부터 가져와야 한다.
      // 공식 : 이전주 + (시작요일 - 현재요일)

      DateTime dayOfBeforeWeek = day.subtract(const Duration(days: 7));
      firstDayOfWeek =
          dayOfBeforeWeek.add(Duration(days: _startWeekAt - day.weekday));
    }
    return firstDayOfWeek;
  }

  /// Get days of your week
  List<DateTime> _getWeeks(DateTime day) {
    List<DateTime> week = [];

    for (var i = 0; i < 7; i++) {
      week.add(day.add(Duration(days: i)));
    }

    return week;
  }

  /// Get days next week
  void _getNextWeeks() {
    DateTime firstDayOfNextWeek = _statredDay.add(const Duration(days: 7));
    _statredDay = firstDayOfNextWeek;

    int weekCount = 7;
    List<DateTime> week = [];
    for (var i = 0; i < weekCount; i++) {
      week.add(firstDayOfNextWeek.add(Duration(days: i)));
    }

    setState(() {
      _showsYearName = _statredDay.year.toString();
      _showsMonthName = _statredDay.month.toString();
      _daysOfWeek = week;
    });
  }

  /// Get days previous week
  void _getPrevWeeks() {
    DateTime firstDayOfPreviousWeek =
        _statredDay.subtract(const Duration(days: 7));

    _statredDay = firstDayOfPreviousWeek;

    int weekCount = 7;
    List<DateTime> week = [];
    for (var i = 0; i < weekCount; i++) {
      week.add(firstDayOfPreviousWeek.add(Duration(days: i)));
    }

    setState(() {
      _showsYearName = _statredDay.year.toString();
      _showsMonthName = _statredDay.month.toString();
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
                for (var day in _weekNames)
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
