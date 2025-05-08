import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EventAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  User? _user;

  EventAuthProvider() {
    _user = _auth.currentUser;
    if (_user != null) {
      _storage.write(key: 'uid', value: _user!.uid);
    }
    _auth.authStateChanges().listen((user) {
      _user = user;
      if (user != null) {
        _storage.write(key: 'uid', value: user.uid);
      } else {
        _storage.delete(key: 'uid');
      }
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    await _storage.write(key: 'uid', value: _user?.uid);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _user = result.user;
    await _storage.write(key: 'uid', value: _user?.uid);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _user = null;
    await _storage.delete(key: 'uid');
    notifyListeners();
  }

  Future<String?> getStoredUid() async {
    return await _storage.read(key: 'uid');
  }
}
