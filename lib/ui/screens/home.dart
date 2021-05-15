import 'package:audiobook/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
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
      ),
    );
  }
}
