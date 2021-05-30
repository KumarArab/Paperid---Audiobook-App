import 'package:flutter/material.dart';

class FFlatButton extends StatelessWidget {
  final String text;
  final Function onTap;

  FFlatButton({this.onTap, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xfff5f8ff),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
