import 'package:flutter/material.dart';

class FBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 40,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
