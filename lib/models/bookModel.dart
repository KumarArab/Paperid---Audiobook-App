import 'package:cloud_firestore/cloud_firestore.dart';

class FBookModel {
  String name;
  String author;
  String cover;
  List<dynamic> genre;
  String preface;
  double rating;
  List<dynamic> audios;

  FBookModel(
      {this.audios,
      this.author,
      this.cover,
      this.genre,
      this.name,
      this.preface,
      this.rating});

  FBookModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    name:
    doc.get('Name');
    author:
    doc.get('Author');
    cover:
    doc.get('Cover');
    genre:
    doc.get('Genre');
    preface:
    doc.get('Preface');
    rating:
    doc.get('Rating');
    audios:
    doc.get('Chapters');
  }
}
