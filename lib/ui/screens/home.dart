import 'package:audiobook/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String routeName = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var userData = context.read<AuthenticaitonService>().currentUser;
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.green,
                size: 50,
              ),
              onPressed: () {
                // Provider.of<AuthenticaitonService>(context, listen: false)
                //     .signOut();
                context.read<AuthenticaitonService>().signOut();
              },
            ),
            Text(userData.name),
            Text(userData.email),
            // Text(userData.user.photoURL),
            //Text(userData.user.uid),
            // Text(userData.user.emailVerified.toString()),
          ],
        ),
      ),
    );
  }
}
