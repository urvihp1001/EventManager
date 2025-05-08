import 'package:event_management_app/pages/auth_screen.dart';
import 'package:event_management_app/pages/eventlistscreen.dart';
import 'package:event_management_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 {
await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'AIzaSyC79Tc2fJSBR8cSTyaIHepwbcAVSMl6zK4',
    appId: '1:128198181189:android:1751f08151fcc6bdda7e2c',
    messagingSenderId: '',
    projectId: 'eventmanagement-ec3fe',
    storageBucket: 'eventmanagement-ec3fe.firebasestorage.app',
  )
);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventAuthProvider()),
      ],
      child: MaterialApp(
        title: 'Event App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return user == null ? const AuthScreen() : const EventListScreen();
  }

}

