import 'package:event_management_app/providers/event_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:event_management_app/pages/auth_screen.dart';
import 'package:event_management_app/pages/eventlistscreen.dart';
import 'package:event_management_app/providers/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    try {
    await dotenv.load(fileName: ".env"); // Load environment variables
  } catch (e) {
    throw Exception('Error loading .env file: $e'); // Print error if any
  }

 
await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: dotenv.env['APIKEY']!,
    appId: '1:128198181189:android:1751f08151fcc6bdda7e2c',
    messagingSenderId: '',
    projectId: 'eventmanagement-ec3fe',
    storageBucket: 'eventmanagement-ec3fe.firebasestorage.app',
  )
);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventAuthProvider()),//helps update data within widget 
        ChangeNotifierProvider(create: (_)=>EventProvider())
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
    return user == null ? const AuthScreen() :  EventListScreen();
  }

}

