import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/Event.dart';

class EventProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Event> _events = [];
  bool _isLoading = false;
  String? _error;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchEvents(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final eventSnapshot = await _firestore.collection('events').get();
      final userRsvpSnapshot = await _firestore
          .collection('rsvps')
          .doc(userId)
          .get();

      final Map<String, dynamic> userRsvpData = userRsvpSnapshot.data() ?? {};

      _events = eventSnapshot.docs.map((doc) {
        return Event.fromFirestore(
          doc.data(),
          doc.id,
          rsvpStatus: userRsvpData[doc.id] ?? false,
        );
      }).toList();
    } catch (e) {
      _error = 'Failed to load events';
    }

    _isLoading = false;
    notifyListeners();
  }

  // Add this method
  Future<void> addEvent({
    required String title,
    required String description,
    required DateTime date,
    required String userId,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _firestore.collection('events').add({
        'title': title,
        'description': description,
        'date': Timestamp.fromDate(date),
        'totalRsvpCount': 0, 
      });

      // Refresh the event list after adding
      await fetchEvents(userId);
    } catch (e) {
      _error = 'Failed to add event';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteEvent(String eventId, String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _firestore.collection('events').doc(eventId).delete();
      await fetchEvents(userId);
    } catch (e) {
      _error = 'Failed to delete event';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleRsvp(String userId, Event event) async {
  final newStatus = !event.rsvpStatus;

  // Update RSVP collection
  final rsvpRef = _firestore.collection('rsvps').doc(userId);
  await rsvpRef.set({
    event.id: newStatus,
  }, SetOptions(merge: true));

  // Update RSVP count in events collection
  final eventRef = _firestore.collection('events').doc(event.id);
  await eventRef.update({
    'totalRsvpCount': FieldValue.increment(newStatus ? 1 : -1),
  });

  // Update local event
  final index = _events.indexWhere((e) => e.id == event.id);
  if (index != -1) {
    _events[index].rsvpStatus = newStatus;
    _events[index].totalRsvpCount += newStatus ? 1 : -1;
  }

  notifyListeners();
}

}
