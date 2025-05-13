import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EventAuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  User? _user;

  EventAuthProvider() {
    _user = _auth.currentUser;
    _updateStorage(_user);
    _auth.authStateChanges().listen((user) {
      _user = user;
      _updateStorage(user);
      notifyListeners();
    });
  }

  User? get user => _user;

  Future<void> signUp(String email, String password) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    _setUser(result.user);
  }

  Future<void> signIn(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _setUser(result.user);
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _setUser(null);
  }

  void _setUser(User? user) async {
    _user = user;
    await _updateStorage(user);
    notifyListeners();
  }

  Future<void> _updateStorage(User? user) async {
    if (user != null) {
      await _storage.write(key: 'uid', value: user.uid);
    } else {
      await _storage.delete(key: 'uid');
    }
  }
}
