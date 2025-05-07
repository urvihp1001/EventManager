import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 {
await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'APIKEY',
    appId: '1:128198181189:android:1751f08151fcc6bdda7e2c',
    messagingSenderId: '',
    projectId: 'eventmanagement-ec3fe',
    storageBucket: 'eventmanagement-ec3fe.firebasestorage.app',
  )
);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Firebase Initialized')),
        
      ),
    );
  }
}
