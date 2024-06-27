import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../models/event_model.dart';
import '../../services/event_service.dart';
import '../../utils/constants.dart';
import '../widgets/input_field.dart';

class AddSessionScreen extends StatefulWidget {
  final EventModel? event;

  const AddSessionScreen({super.key, this.event});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _titleController = TextEditingController();
  final _infoController = TextEditingController();
  final _selectedDateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _periodicSelectedDate = DateTime.now();

  String _startTime = DateFormat("hh:mm").format(DateTime.now()).toString();
  String _endTime = DateFormat("hh:mm")
      .format(DateTime.now().add(const Duration(minutes: 60)))
      .toString();

  bool? _repeat = false;
  bool? periodic = true;
  List<String> _selectedDays = [];

  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date;
  late Duration _duration;
  late String _description;
  final EventService _eventService = EventService();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      _title = widget.event!.title;
      _date = widget.event!.date;
      _duration = widget.event!.duration;
      _description = widget.event!.description;
    } else {
      _title = '';
      _date = DateTime.now();
      _duration = Duration(hours: 1);
      _description = '';
    }
  }

  void _saveEvent() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final event = EventModel(
        id: widget.event?.id ?? Uuid().v4(),
        title: _title,
        date: _date,
        duration: _duration,
        description: _description,
        userId: 'currentUserId',
        trainerId: 'currentUserId',
        studentIds: [],
      );

      if (widget.event != null) {
        _eventService.updateEvent(event);
      } else {
        _eventService.createEvent(event);
      }

      Navigator.of(context).pop();
    }
  }

  _getDateTime() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _getHour({required bool isStart}) async {
    var pickerHour = await _showTimePicker();

    String hour = pickerHour.format(context);

    if (pickerHour == null) {
    } else if (isStart == true) {
      setState(() {
        _startTime = hour;
      });
    } else if (isStart == false) {
      setState(() {
        _endTime = hour;
      });
    }
  }

  _getPeriodicDateTime() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (pickerDate != null) {
      setState(() {
        _periodicSelectedDate = pickerDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        shadowColor: Colors.black,
        title: Text(widget.event != null ? 'Editar sesión' : 'Crear sesión',
            style: appTitleStyle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputField(
                  label: 'Título de la sesión',
                  hint: '',
                  controller: _titleController),
              InputField(
                  label: 'Información de la sesión',
                  hint: '',
                  controller: _infoController),
              InputField(
                  label: 'Fecha de la sesión',
                  hint: DateFormat.yMd('es_ES').format(_selectedDate),
                  controller: _selectedDateController,
                  widget: IconButton(
                      icon: Icon(Icons.calendar_today_outlined),
                      onPressed: () {
                        _getDateTime();
                      })),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                        label: 'Hora de inicio',
                        hint: _startTime,
                        widget: IconButton(
                            icon: Icon(Icons.access_time_outlined),
                            onPressed: () {
                              _getHour(isStart: true);
                            })),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: InputField(
                        label: 'Hora de fin',
                        hint: _endTime,
                        widget: IconButton(
                            icon: Icon(Icons.access_time_outlined),
                            onPressed: () {
                              _getHour(isStart: false);
                            })),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Quieres repetir esta sesión?',
                    style: titleStyle,
                  ),
                  Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        Row(children: [
                          Radio(
                            value: true,
                            groupValue: _repeat,
                            onChanged: (value) {
                              setState(() {
                                _repeat = value;
                              });
                            },
                          ),
                          Text('Sí', style: titleStyle),
                        ]),
                        const SizedBox(width: 64),
                        Row(children: [
                          Radio(
                            value: false,
                            groupValue: _repeat,
                            onChanged: (value) {
                              setState(() {
                                _repeat = value;
                              });
                            },
                          ),
                          Text('No', style: titleStyle),
                        ]),
                      ]))
                ],
              ),
              Visibility(
                visible: _repeat == true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Repetir los días',
                      style: subtitleStyle,
                    ),
                    Wrap(
                      spacing: 4.0,
                      children: [
                        for (var day in ['L', 'M', 'X', 'J', 'V', 'S'])
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: _selectedDays.contains(day),
                                shape: CircleBorder(),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedDays.add(day);
                                    } else {
                                      _selectedDays.remove(day);
                                    }
                                  });
                                },
                              ),
                              Text(day, style: subtitleStyle),
                            ],
                          ),
                      ],
                    ),
                    InputField(label: 'Cada cuántas semanas', hint: ''),
                    SizedBox(height: 16),
                    Row(children: [
                      Radio(
                        value: true,
                        groupValue: periodic,
                        onChanged: (value) {
                          setState(() {
                            periodic = value;
                          });
                        },
                      ),
                      Text('Durante', style: titleStyle),
                      SizedBox(width: 8), // Espacio entre widgets
                      Container(
                        width: 50, // Ancho del campo de texto
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('semanas', style: titleStyle),
                    ]),
                    Row(children: [
                      Radio(
                        value: false,
                        groupValue: periodic,
                        onChanged: (value) {
                          setState(() {
                            periodic = value;
                          });
                        },
                      ),
                      Text('Hasta el día', style: titleStyle),
                      SizedBox(width: 8),
                      Text(DateFormat.yMd('es_ES').format(_selectedDate), style: subtitleStyle),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _getPeriodicDateTime();
                        },
                        child: Icon(Icons.edit_calendar_outlined),
                      ),
                    ]),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade200,
        onPressed: _saveEvent,
        child: Icon(Icons.edit_calendar_outlined),
      ),
    );
  }
}
