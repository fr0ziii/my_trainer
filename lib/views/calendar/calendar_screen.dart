import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/event_model.dart';
import '../../services/event_service.dart';
import 'add_session_screen.dart';

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
          DateTime sessionDateTime = DateTime.parse(event.sessionDate);
          DateTime startTime = DateTime(
            sessionDateTime.year,
            sessionDateTime.month,
            sessionDateTime.day,
            DateFormat("hh").parse(event.startTime).hour,
            DateFormat("mm").parse(event.startTime).minute,
          );
          DateTime endTime = DateTime(
            sessionDateTime.year,
            sessionDateTime.month,
            sessionDateTime.day,
            DateFormat("hh").parse(event.endTime).hour,
            DateFormat("mm").parse(event.endTime).minute,
          );
          print(event.toMap());
          return Appointment(
            startTime: startTime,
            endTime: endTime,
            subject: event.title,
            color: Colors.blue,
          );
        }).toList();
      });
    });
  }

  void _openAddEditEventScreen([EventModel? event]) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddSessionScreen(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CalendarController calendarController = CalendarController();
    return Scaffold(
      body: SfCalendar(
        showNavigationArrow: true,
        showTodayButton: true,
        showCurrentTimeIndicator: false,
        allowViewNavigation: true,
        view: CalendarView.week,
        allowedViews: const <CalendarView>[
          CalendarView.day,
          CalendarView.week,
          CalendarView.workWeek,
          CalendarView.month,
          CalendarView.schedule
        ],
        cellBorderColor: Colors.grey.shade400,
        backgroundColor: Colors.white,
        headerHeight: 75,
        headerStyle: CalendarHeaderStyle(
          backgroundColor: Colors.white,
            textStyle: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.normal,
                letterSpacing: 1,
                color: Colors.grey.shade700)
        ),
        headerDateFormat: 'dd MMM yyyy',
        controller: calendarController,
        viewNavigationMode: ViewNavigationMode.snap,
        firstDayOfWeek: DateTime.monday,
        dataSource: EventDataSource(_appointments),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          dayFormat: 'EEE',
          navigationDirection: MonthNavigationDirection.horizontal,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        ),
        selectionDecoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.blue.shade400, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSessionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> source) {
    appointments = source;
  }
}
