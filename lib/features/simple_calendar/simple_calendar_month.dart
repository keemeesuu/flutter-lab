import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lab/features/simple_calendar/date_time.dart';
import 'package:lab/features/simple_calendar/utils.dart';
import 'package:lab/features/simple_calendar/widgets/dayOfWeek.dart';

class SimpleCalendarMonth extends StatefulWidget {
  const SimpleCalendarMonth({super.key});

  @override
  State<SimpleCalendarMonth> createState() => _SimpleCalendarMonthState();
}

class _SimpleCalendarMonthState extends State<SimpleCalendarMonth> {
  String _dateType = "month"; // week, month

  List<DateTime> date = [];

  /// Start week on
  /// You can setting the start day of the week
  /// 1: Mon, 2: Tue, 3: Wed, 4: Thu, 5: Fri, 6: Sat, 7: Sun
  final int _startWeekAt = 7;

  /// Names of Days
  /// Mon, Thu, Wed, Thu, Fri, Sat, Sun
  late List<String> _weekNames;

  /// Todays date
  final DateTime _today = DateTime.utc(2023, 04, 28);

  Map<int, List<DateTime>> _month = {};

  /// The Calendar displays the day of the week
  List<DateTime> currentMonth = [];

  /// Displays the current year
  String _showsYearName = "";

  /// Displays the current month
  String _showsMonthName = "";

  @override
  void initState() {
    super.initState();

    // initializeDateFormatting('ko_KR', null);
    // print(DateFormat.EEEE('ko_KR').format(DateTime.now()));

    // Displays the Current month
    currentMonth = _getMonth(_today);

    for (var day in currentMonth) print(day);

    // Get names of the week
    _weekNames = _getWeekName(_startWeekAt);

    // Displays the Current Day info
    _showsYearName = _today.year.toString();
    _showsMonthName = _today.month.toString();
  }

  /// Get names of the week
  List<String> _getWeekName(int day) {
    int startAt = day - 1;
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

  // Get month
  List<DateTime> _getMonth(DateTime _today) {
    int firstDay = DateTime(_today.year, _today.month, 1).day;
    int lastDay = DateTime(_today.year, _today.month + 1, 0).day;
    List<DateTime> days = [];

    DateTime.utc(_today.year, _today.month, _today.day);

    int weekNumber = 1;
    List<DateTime> daysOfWeek = [];
    for (int i = 1; i <= lastDay; i++) {
      print(i);
      // _month.addAll({5: });
      if (i % 7 == 0) {
        weekNumber++;
        print("weekNumber ${weekNumber}");
      }
      // days.add(DateTime.utc(_today.year, _today.month, i));
    }

    return days;
  }

  void _getPrevMonth() {}

  void _getNextMonth() {}

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
                  style: const TextStyle(fontSize: 20),
                ),
                const Spacer(),

                /// Prev Week BUtton
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _getPrevMonth,
                ),

                /// Next Week Button
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _getNextMonth,
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
                for (int i = 0; i < currentMonth.length; i++)
                  DayOfWeek(
                    name: convertDateTimeToDay(currentMonth[i]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
