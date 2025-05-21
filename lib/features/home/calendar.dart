import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ovia_app/api_connectors/apis.dart';
import 'package:ovia_app/api_connectors/login.dart';
import 'package:table_calendar/table_calendar.dart';

class CycleCalendar extends StatefulWidget {
  const CycleCalendar({super.key});

  @override
  State<CycleCalendar> createState() => _CalendarState();
}

class _CalendarState extends State<CycleCalendar> {
  _CalendarState();

  String? getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  List<DateTime> periodDays = [];
  List<DateTime> fertileWindow = [];
  List<DateTime> ovulationDays = [];

  void getCycleData() async {
    final userId = getCurrentUserId();
    final data = await APIs().fetchUserCycle(userId!);

    if (data != null) {
      setState(() {
        periodDays = List<DateTime>.from(
            data['periodDays'].map((date) => DateTime.parse(date)).toList());
        fertileWindow = List<DateTime>.from(
            data['fertileWindow'].map((date) => DateTime.parse(date)).toList());
        ovulationDays = List<DateTime>.from(
            data['ovulationDays'].map((date) => DateTime.parse(date)).toList());
      });
      print("Period Days: ${data['periodDays']}");
      print("Fertile Window: ${data['fertileWindow']}");
      print("Ovulation Days: ${data['ovulationDays']}");
    } else {
      print("Failed to fetch user cycle.");
    }
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final userProfile = await Auth().getUserProfile();
    return userProfile;
  }

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    getCycleData();
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) =>
              _selectedDay != null && _isSameDay(_selectedDay!, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, day, focusedDay) {
            if (ovulationDays.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.blue, label: "🥚");
            } else if (periodDays.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.pink);
            } else if (fertileWindow.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.purple);
            }
            return null;
          }, outsideBuilder: (context, day, focusedDay) {
            if (ovulationDays.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.blue, label: "🥚");
            } else if (periodDays.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.pink);
            } else if (fertileWindow.any((d) => _isSameDay(d, day))) {
              return _cycleDot(day, Colors.purple);
            }
            return null;
          }),
          availableCalendarFormats: const {
            CalendarFormat.twoWeeks: '2 Weeks',
          },
          calendarFormat: _calendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
        ),
      ),
    );
  }

  Widget _cycleDot(DateTime day, Color color, {String? label}) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(0.15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label ?? day.day.toString(),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
