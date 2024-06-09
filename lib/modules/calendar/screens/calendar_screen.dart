import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  static const List<String> calendarViews = [
    'day',
    'week',
    'workweek',
    'month',
    'schedule'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendario'),
        ),
        body: SfCalendar(
          view: CalendarView.week,
          firstDayOfWeek: 1,
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          selectionDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
                color: Theme.of(context).colorScheme.primary, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
          ),
        ));
  }
}
