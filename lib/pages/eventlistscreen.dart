import 'package:event_management_app/components/AddEventDialog.dart';
import 'package:event_management_app/providers/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EventListScreen extends StatefulWidget {
  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          userId = user.uid;
        });
        Provider.of<EventProvider>(context, listen: false).fetchEvents(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Events'), actions: [
    IconButton(
      icon: Icon(Icons.logout),
      tooltip: 'Sign out',
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        
        Navigator.of(context).pushReplacementNamed('auth_screen');
      },
    ),
  ],),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.events.isEmpty
              ? Center(child: Text('No events found.'))
              : ListView.builder(
                  itemCount: provider.events.length,
                  itemBuilder: (context, index) {
                    final event = provider.events[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Event info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.title, style: Theme.of(context).textTheme.labelMedium),
                                  SizedBox(height: 4),
                                  Text(event.description),
                                  SizedBox(height: 4),
                                  Text(
                                    event.date.toLocal().toString().split(' ')[0],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            // RSVP and Delete buttons
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('RSVP: ${event.totalRsvpCount}'),
                                IconButton(
                                  icon: Icon(
                                    event.rsvpStatus
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: event.rsvpStatus ? Colors.green : null,
                                  ),
                                  onPressed: userId == null
                                      ? null
                                      : () {
                                          provider.toggleRsvp(userId!, event);
                                        },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: userId == null
                                      ? null
                                      : () {
                                          provider.deleteEvent(event.id, userId!);
                                        },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: userId == null
            ? null
            : () async {
                final result = await showDialog<Map<String, dynamic>>(
                  context: context,
                  builder: (context) => AddEventDialog(),
                );
                if (result != null) {
                  provider.addEvent(
                    title: result['title'],
                    description: result['description'],
                    date: result['date'],
                    userId: userId!,
                  );
                }
              },
      ),
    );
  }
}
