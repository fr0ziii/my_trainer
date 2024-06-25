import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/event_model.dart';
import '../../services/event_service.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: Text(widget.event != null ? 'Editar sesión' : 'Crear sesión',
            style: const TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              InputField(
                  label: 'Título de la sesión',
                  hint: 'Ej: Sesión de prueba',
                  controller: _titleController),
              InputField(
                  label: 'Información de la sesión',
                  hint: 'Ej: Crossfit',
                  controller: _infoController),
              InputField(
                  label: 'Fecha de la sesión',
                  hint: 'Ej: 1 hora',
                  controller: _selectedDateController,
                  widget: Icon(Icons.calendar_today)),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveEvent,
                child: Text(widget.event != null ? 'Actualizar' : 'Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
