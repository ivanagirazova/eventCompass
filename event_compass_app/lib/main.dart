import 'package:flutter/material.dart';
import 'event_details.dart';

void main() {
  runApp(EventApp());
}

class EventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Compass',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EventHomePage(),
    );
  }
}

class EventHomePage extends StatefulWidget {
  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event List'),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                events[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date & Time: ${events[index].dateTime.toString()}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Event Type: ${events[index].eventType}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Music Type: ${events[index].musicType}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Details: ${events[index].details}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _showEventDetails(context, events[index]);
                },
                child: Text('Details'),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    String name = '';
    DateTime? dateTime;
    String eventType = '';
    String musicType = '';
    String details = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Event Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              Row(
                children: [
                  Text('Date & Time: '),
                  ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((selectedTime) {
                            if (selectedTime != null) {
                              dateTime = DateTime(
                                selectedDate.year,
                                selectedDate.month,
                                selectedDate.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );
                              setState(() {});
                            }
                          });
                        }
                      });
                    },
                    child: Text('Select Date & Time'),
                  ),
                  if (dateTime != null) Text(dateTime!.toString()),
                ],
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Event Type'),
                onChanged: (value) {
                  eventType = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Music Type'),
                onChanged: (value) {
                  musicType = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Event Details'),
                onChanged: (value) {
                  details = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (name.isNotEmpty && dateTime != null) {
                  _addEvent(name, dateTime!, eventType, musicType, details);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _addEvent(
    String name,
    DateTime dateTime,
    String eventType,
    String musicType,
    String details,
  ) {
    setState(() {
      events.add(
        Event(
          name: name,
          dateTime: dateTime,
          eventType: eventType,
          musicType: musicType,
          details: details,
        ),
      );
    });
  }

  void _showEventDetails(BuildContext context, Event event) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EventDetailsPage(event: event),
      ),
    );
  }
}

class Event {
  final String name;
  final DateTime dateTime;
  final String eventType;
  final String musicType;
  final String details;

  Event({
    required this.name,
    required this.dateTime,
    required this.eventType,
    required this.musicType,
    required this.details,
  });
}
