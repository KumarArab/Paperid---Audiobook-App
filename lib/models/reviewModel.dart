import 'package:flutter/cupertino.dart';

class FReviewModel {
  final String name;
  final String bookRate;
  final String narrRate;
  final String imageurl;
  final String review;

  FReviewModel({
    @required this.bookRate,
    @required this.imageurl,
    @required this.name,
    @required this.narrRate,
    @required this.review,
  });
}
