import 'package:flutter/material.dart';
import 'main.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  EventDetailsPage({required this.event});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  List<String> comments = [];
  TextEditingController commentController = TextEditingController();
  bool isReserved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Name: ${widget.event.name}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Date & Time: ${widget.event.dateTime.toString()}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Event Type: ${widget.event.eventType}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Music Type: ${widget.event.musicType}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Details: ${widget.event.details}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Back to Event List'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: isReserved ? null : _reserveEvent,
              child: Text(isReserved ? 'Reserved' : 'Reserve'),
            ),
            SizedBox(height: 10.0),
            Divider(), // Add a divider to separate comments
            _buildCommentsList(),
          ],
        ),
      ),
    );
  }

  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Comment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: commentController,
                decoration: InputDecoration(labelText: 'Comment'),
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
                String comment = commentController.text;
                if (comment.isNotEmpty) {
                  _addComment(comment);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add Comment'),
            ),
          ],
        );
      },
    );
  }

  void _addComment(String comment) {
    setState(() {
      comments.add(comment);
      commentController.clear();
    });
  }

  Widget _buildCommentsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Comments:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Text(comments[index]),
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                _showCommentDialog(context);
              },
              child: Text('Comment'),
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: isReserved ? null : _reserveEvent,
              child: Text(isReserved ? 'Reserved' : 'Reserve'),
            ),
          ],
        ),
      ],
    );
  }

  void _reserveEvent() {
    setState(() {
      isReserved = true;
    });
  }
}
