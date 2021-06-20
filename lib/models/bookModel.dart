import 'package:audiobook/models/chapterModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FBookModel {
  String id;
  String name;
  String author;
  String cover;
  List<dynamic> genre;
  String preface;
  String rating;
  String color;
  List<FChapterModel> audios;

  FBookModel(
      {this.id,
      this.audios,
      this.author,
      this.cover,
      this.genre,
      this.name,
      this.preface,
      this.color,
      this.rating});
}
