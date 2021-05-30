import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:flutter/material.dart';

class Library extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FAppBar(
                isAction: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
