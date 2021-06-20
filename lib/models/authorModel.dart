import 'package:flutter/cupertino.dart';

class FAuthorModel {
  final String name;
  final String imagepath;
  final List<dynamic> books;

  FAuthorModel(
      {@required this.imagepath, @required this.name, @required this.books});
}
