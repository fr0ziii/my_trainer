import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/event_model.dart';
import '../../services/event_service.dart';
import '../../utils/constants.dart';
import '../../view_models/auth_view_model.dart';
import 'add_session_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarScreen> {
  final EventService _eventService = EventService();
  EventDataSource? _dataSource;
  List<EventModel> _events = [];
  late Future<void> _initialLoad;

  @override
  void initState() {
    super.initState();
    _initialLoad = _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final user = await authViewModel.getCurrentUser();
    if (user != null) {
      _loadEvents(user.uid);
    }
  }

  Future<void> _loadEvents(String userId) async {
    _eventService.getEventsByTrainer(userId).listen((events) {
      setState(() {
        _events = events;
        _dataSource = EventDataSource(_events);
      });
    });
  }

  EventModel? _getEventFromAppointment(Appointment appointment) {
    return _events.firstWhere((event) => event.id == appointment.id);
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
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initialLoad,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          CalendarController calendarController = CalendarController();
          return SfCalendar(
            showNavigationArrow: true,
            showTodayButton: true,
            showCurrentTimeIndicator: false,
            allowViewNavigation: true,
            timeSlotViewSettings: TimeSlotViewSettings(
                timeTextStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.grey.shade900,
                ),
                timeRulerSize: 50,
                timeFormat: "HH:mm",
                timeIntervalHeight: 75),
            view: CalendarView.week,
            allowedViews: const <CalendarView>[
              CalendarView.day,
              CalendarView.week,
              CalendarView.month,
              CalendarView.schedule
            ],
            cellBorderColor: Colors.grey.shade400,
            backgroundColor: Colors.white,
            headerHeight: 60,
            headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.white,
                textStyle:
                    TextStyle(fontSize: 20, fontStyle: FontStyle.normal, letterSpacing: 0.5, color: Colors.grey.shade700)),
            headerDateFormat: 'dd MMM yyyy',
            controller: calendarController,
            viewNavigationMode: ViewNavigationMode.snap,
            firstDayOfWeek: DateTime.monday,
            appointmentTimeTextFormat: 'HH:mm',
            dataSource: _dataSource,
            appointmentTextStyle: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
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
          );
        }
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

class EventDataSource extends CalendarDataSource<EventModel> {
  EventDataSource(List<EventModel> source) {
    appointments = source;
  }

  @override
  EventModel? convertAppointmentToObject(EventModel customData, Appointment appointment) {
    return EventModel(
      id: customData.id,
      description: customData.description,
      sessionDate: customData.sessionDate,
      sessionType: customData.sessionType,
      title: customData.title,
      startTime: customData.startTime,
      endTime: customData.endTime,
      capacity: customData.capacity,
      clientsIds: customData.clientsIds,
      trainerId: customData.trainerId,
      userId: customData.userId,
    );
  }
}
