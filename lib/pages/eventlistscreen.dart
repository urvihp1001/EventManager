import 'package:event_management_app/pages/auth_screen.dart';
import 'package:event_management_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated event data for the list
    final events = [
      Event(id: '1', title: 'Flutter Workshop', description: 'A workshop on Flutter development', date: DateTime.now().add(Duration(days: 1)), rsvpCount: 10),
      Event(id: '2', title: 'Dart Meetup', description: 'A meetup for Dart developers', date: DateTime.now().add(Duration(days: 2)), rsvpCount: 5),
      Event(id: '3', title: 'Firebase Conference', description: 'Firebase Conference for developers', date: DateTime.now().add(Duration(days: 3)), rsvpCount: 2),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign out the user when they click the logout button
              Provider.of<EventAuthProvider>(context, listen: false).signOut();
              Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AuthScreen()),
      );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return EventCard(event: event);
        },
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(event.description),
            SizedBox(height: 10),
            Text('Date: ${event.date.toLocal()}'),
            SizedBox(height: 10),
            Text('RSVP Count: ${event.rsvpCount}'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle RSVP action
                // This is where you would integrate Firebase to update RSVP status
                print('RSVP clicked for event: ${event.title}');
              },
              child: Text('RSVP'),
            ),
          ],
        ),
      ),
    );
  }
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final int rsvpCount;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.rsvpCount,
  });
}
