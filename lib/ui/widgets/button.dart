import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  Button({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
