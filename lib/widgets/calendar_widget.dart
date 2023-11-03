import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class CalenderWidget extends StatefulWidget {
  const CalenderWidget({super.key});

  @override
  State<CalenderWidget> createState() => _CalenderWidgetState();
}

class _CalenderWidgetState extends State<CalenderWidget> {
  

  @override
  void initState() {
    super.initState();

  
  }

  
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.5,
      child: Column(
        children: [
         TableCalendar(
  firstDay: DateTime.utc(2010, 10, 16),
  lastDay: DateTime.utc(2030, 3, 14),
  focusedDay: DateTime.now(), 
  calendarBuilders: CalendarBuilders(
              todayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(3.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: blue, borderRadius: BorderRadius.circular(3.0)),
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              selectedBuilder: (context, date, events) => Container(
                margin: const EdgeInsets.all(3.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(3.0)),
                child: Text(
                  date.day.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonDecoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(22.0),
              ),
              formatButtonTextStyle: const TextStyle(color: Colors.white),
              formatButtonShowsNext: false,
            ),calendarFormat: CalendarFormat.month,
            calendarStyle: CalendarStyle(todayDecoration: const BoxDecoration(color: Colors.blue),
               selectedDecoration: BoxDecoration(color: Theme.of(context).primaryColor) ,
                
                todayTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                    color: Colors.white)),
          ),
      
        ],
      ),
    );
  }
}
