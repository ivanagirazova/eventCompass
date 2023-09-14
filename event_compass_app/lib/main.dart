import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Event {
  final String name;
  final DateTime datetime;
  final String eventType;
  final String musicType;
  final String details;

  Event({
    required this.name,
    required this.datetime,
    required this.eventType,
    required this.musicType,
    required this.details,
  });
}

class MyApp extends StatelessWidget {
  // Dummy list of events
  final List<Event> events = [
    Event(
      name: 'Sample Event 1',
      datetime: DateTime(2023, 9, 20, 18, 0),
      eventType: 'Conference',
      musicType: 'Classical',
      details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Event(
      name: 'Sample Event 2',
      datetime: DateTime(2023, 9, 25, 15, 30),
      eventType: 'Concert',
      musicType: 'Rock',
      details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
    Event(
      name: 'Sample Event 3',
      datetime: DateTime(2023, 10, 5, 20, 0),
      eventType: 'Party',
      musicType: 'Electronic',
      details: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Event List'),
        ),
        body: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Text(event.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date & Time: ${event.datetime.toString()}'),
                  Text('Event Type: ${event.eventType}'),
                  Text('Music Type: ${event.musicType}'),
                ],
              ),
              onTap: () {
                // Handle tapping on an event here
                // You can navigate to event details page, for example
              },
            );
          },
        ),
      ),
    );
  }
}
