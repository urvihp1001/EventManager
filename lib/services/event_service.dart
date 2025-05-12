import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event.dart';

class EventService {
  final _firestore = FirebaseFirestore.instance;

  Future<List<Event>> fetchEvents(String userId) async {
    final snapshot = await _firestore.collection('events').get();

    return Future.wait(snapshot.docs.map((doc) async {
      final data = doc.data();
      final rsvpDoc = await _firestore
          .collection('events')
          .doc(doc.id)
          .collection('rsvps')
          .doc(userId)
          .get();

      return Event(
        id: doc.id,
        title: data['title'],
        description: data['description'],
        date: data['date'].toDate(),
        totalRsvpCount: data['rsvpCount'] ?? 0,
        rsvpStatus: rsvpDoc.exists,
      );
    }).toList());
  }

  Future<void> rsvpEvent(String eventId, String userId) async {
    final eventRef = _firestore.collection('events').doc(eventId);
    final rsvpRef = eventRef.collection('rsvps').doc(userId);

    await _firestore.runTransaction((txn) async {
      txn.set(rsvpRef, {'isRSVPed': true});
      final eventSnap = await txn.get(eventRef);
      final currentCount = eventSnap['rsvpCount'] ?? 0;
      txn.update(eventRef, {'rsvpCount': currentCount + 1});
    });
  }

  Future<void> unRsvpEvent(String eventId, String userId) async {
    final eventRef = _firestore.collection('events').doc(eventId);
    final rsvpRef = eventRef.collection('rsvps').doc(userId);

    await _firestore.runTransaction((txn) async {
      txn.delete(rsvpRef);
      final eventSnap = await txn.get(eventRef);
      final currentCount = eventSnap['rsvpCount'] ?? 0;
      txn.update(eventRef, {'rsvpCount': currentCount - 1});
    });
  }
}
