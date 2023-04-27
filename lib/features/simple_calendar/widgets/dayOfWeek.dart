import 'package:flutter/material.dart';

class DayOfWeek extends StatelessWidget {
  final String name;
  const DayOfWeek({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () => print("click"),
        child: Container(
          height: 40,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
