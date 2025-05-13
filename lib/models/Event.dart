import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  bool rsvpStatus; // Whether the current user has RSVP'd
  int totalRsvpCount;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.rsvpStatus = false,
    this.totalRsvpCount=0,
  });

 

  factory Event.fromFirestore(
    Map<String, dynamic> data,
    String documentId, {
    bool rsvpStatus = false,
  }) {
    return Event(
      id: documentId,
      title: data['title'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(),
      rsvpStatus: rsvpStatus,
      totalRsvpCount: data['totalRsvpCount'] ?? 0,
    );
  }


}
