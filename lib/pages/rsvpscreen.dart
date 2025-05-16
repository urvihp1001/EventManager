import 'package:event_management_app/providers/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RsvpEventsScreen extends StatefulWidget {
  @override
  State<RsvpEventsScreen> createState() => _RsvpEventsScreenState();
}

class _RsvpEventsScreenState extends State<RsvpEventsScreen> {
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
        Provider.of<EventProvider>(context, listen: false)
            .fetchRsvpEvents(user.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('My RSVP Events')),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : provider.events.isEmpty
              ? Center(child: Text('No RSVP\'d events found.'))
              : ListView.builder(
                  itemCount: provider.events.length,
                  itemBuilder: (context, index) {
                    final event = provider.events[index];
                    return Card(
                      child: ListTile(
                        title: Text(event.title),
                        subtitle: Text(event.description),
                      ),
                    );
                  },
                ),
    );
  }
}
