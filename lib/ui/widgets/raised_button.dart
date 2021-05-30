import 'package:audiobook/utils/appTheme.dart';
import 'package:flutter/material.dart';

class FRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  FRaisedButton({@required this.child, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: AppTheme().primaryColor.withOpacity(0.1),
              offset: Offset(0, 10),
              blurRadius: 50,
              spreadRadius: 10),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
