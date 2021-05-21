import 'package:audiobook/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextBox extends StatelessWidget {
  final String label;
  final bool isObsecure;
  final TextEditingController controller;

  TextBox({this.controller, this.isObsecure, this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30, bottom: 10),
      child: TextField(
        obscureText: isObsecure,
        controller: controller,
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }
}
