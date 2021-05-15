import 'package:audiobook/ui/screens/404.dart';
import 'package:audiobook/ui/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return FourOFour();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Scaffold(
          body: Center(
            child: Icon(
              Icons.book,
              color: Colors.amber,
              size: 50,
            ),
          ),
        );
      },
    );
  }
}
