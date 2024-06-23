import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../services/event_service.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarScreen> {
  final EventService _eventService = EventService();
  List<Appointment> _appointments = [];

  @override
  void initState() {
    super.initState();
    _eventService.getEvents().listen((events) {
      setState(() {
        _appointments = events.map((event) {
          return Appointment(
            startTime: event.date,
            endTime: event.date.add(event.duration),
            subject: event.title,
            color: Colors.blue,
          );
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: DateTime.monday,
        dataSource: EventDataSource(_appointments),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
