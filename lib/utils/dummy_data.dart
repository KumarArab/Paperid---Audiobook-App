import 'package:audiobook/models/authorModel.dart';
import 'package:audiobook/models/genreModel.dart';
import 'package:audiobook/models/reviewModel.dart';
import 'package:audiobook/models/shelfModel.dart';

List<FGenreModel> kGenreList = [
  FGenreModel(
      imagePath: "assets/images/genres/action-adventure.png",
      name: "Action & Adventure"),
  FGenreModel(imagePath: "assets/images/genres/romance.png", name: "Romance"),
  FGenreModel(imagePath: "assets/images/genres/mystery.png", name: "Mystery"),
  FGenreModel(
      imagePath: "assets/images/genres/children.png", name: "Children's"),
  FGenreModel(imagePath: "assets/images/genres/history.png", name: "History"),
  FGenreModel(imagePath: "assets/images/genres/horror.png", name: "Horror"),
  FGenreModel(imagePath: "assets/images/genres/fantasy.png", name: "Fantasy"),
  FGenreModel(imagePath: "assets/images/genres/fiction.png", name: "Fiction"),
  FGenreModel(imagePath: "assets/images/genres/classics.png", name: "Classics"),
  FGenreModel(imagePath: "assets/images/genres/sci-fi.png", name: "Sci-fi"),
];

List<FAuthorModel> kAuthorList = [
  FAuthorModel(
      imagepath: "assets/images/authors/H.G. Wells.jpg", name: "H.G. Wells"),
  FAuthorModel(
      imagepath: "assets/images/authors/Israel Zangwill.jpg",
      name: "Israel Zangwill"),
  FAuthorModel(
      imagepath: "assets/images/authors/Jack London.jpg", name: "Jack London"),
  FAuthorModel(
      imagepath: "assets/images/authors/Louis Hughes.jpg",
      name: "Louis Hughes"),
  FAuthorModel(
      imagepath: "assets/images/authors/neil-gaiman.jpg", name: "Neil Gaiman"),
  FAuthorModel(
      imagepath: "assets/images/authors/Nikolai Gogol.jpeg",
      name: "Nikolai Gogol"),
  FAuthorModel(
      imagepath: "assets/images/authors/Sigmund Freud.jpg",
      name: "Sigmund Freud"),
];

List<FReviewModel> kReviewList = [
  FReviewModel(
    bookRate: "4.5",
    imageurl:
        "https://static2.srcdn.com/wordpress/wp-content/uploads/2021/03/Top-Tik-Tok-Follower-Count-Zach-King-Cropped.jpg?q=50&fit=crop&w=740&h=370&dpr=1.5",
    name: "Zach King",
    narrRate: "4.3",
    review:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words,",
  ),
  FReviewModel(
    bookRate: "4.2",
    imageurl:
        "https://static0.srcdn.com/wordpress/wp-content/uploads/2021/03/Top-Tik-Tok-Follower-Count-Charli-DAmelio-Cropped.jpg?q=50&fit=crop&w=740&h=370&dpr=1.5",
    name: "Charli D'Amelio",
    narrRate: "4.0",
    review:
        "Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words",
  ),
  FReviewModel(
    bookRate: "3.5",
    imageurl:
        "https://static3.srcdn.com/wordpress/wp-content/uploads/2021/03/Top-Tik-Tok-Follower-Count-Addison-Rae-Cropped.jpg?q=50&fit=crop&w=740&h=370&dpr=1.5",
    name: "Addison Rae",
    narrRate: "4.0",
    review:
        "It has roots in a piece of classical Latin literature from 45 BC,he more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections ",
  ),
  FReviewModel(
    bookRate: "4.0",
    imageurl:
        "https://static2.srcdn.com/wordpress/wp-content/uploads/2021/03/Top-Tik-Tok-Follower-Count-Loren-Gray-Cropped.jpg?q=50&fit=crop&w=740&h=370&dpr=1.5",
    name: "Loren Gray",
    narrRate: "4.5",
    review:
        "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical  and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections ",
  ),
];

List<String> kRecentSearches = [
  "american gods",
  "neil gaiman",
  "catcher in the eye",
  "lords of the rings"
];
