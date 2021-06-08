import 'package:audiobook/models/authorModel.dart';
import 'package:audiobook/models/genreModel.dart';
import 'package:audiobook/models/reviewModel.dart';
import 'package:audiobook/models/shelfModel.dart';

List<FGenreModel> kGenreList = [
  FGenreModel(
      imagePath: "assets/images/genres/action-adventure.jpg",
      name: "Action &\nAdventure"),
  FGenreModel(imagePath: "assets/images/genres/fantasy.jpg", name: "Fantasy"),
  FGenreModel(imagePath: "assets/images/genres/history.jpg", name: "History"),
  FGenreModel(imagePath: "assets/images/genres/romance.jpg", name: "Romance"),
  FGenreModel(imagePath: "assets/images/genres/mystery.png", name: "Mystery"),
  FGenreModel(imagePath: "assets/images/genres/sci-fi.jpg", name: "Sci-Fi"),
  FGenreModel(imagePath: "assets/images/genres/drama.jpg", name: "Drama"),
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

List<FShelfModel> kShelfList = [
  FShelfModel(
      name: "Must Listen Books",
      bookCount: 12,
      coverUrl:
          "https://cdn.pastemagazine.com/www/system/images/photo_albums/30-best-book-covers-2016/large/2vegetariancover.png?1384968217",
      overlayColor: "000000"),
  FShelfModel(
      name: "Classics",
      bookCount: 8,
      coverUrl:
          "https://www.portersquarebooks.com/sites/portersquarebooks.com/files/teaspoonearthandsea.jpg",
      overlayColor: "000000"),
  FShelfModel(
      name: "Top Sci-Fi Novels",
      bookCount: 20,
      coverUrl:
          "https://blog-cdn.reedsy.com/directories/admin/attachments/large_7c4c00ee056decdc83cfa053ae29593c.jpg",
      overlayColor: "000000"),
  FShelfModel(
      name: "Top Fantasy Novels",
      bookCount: 4,
      coverUrl:
          "https://s26162.pcdn.co/wp-content/uploads/2019/01/9781616208882.jpg",
      overlayColor: "000000"),
  FShelfModel(
      name: "Romance",
      bookCount: 10,
      coverUrl: "https://images4.penguinrandomhouse.com/cover/9780525645610",
      overlayColor: "000000"),
  FShelfModel(
      name: "To-Read",
      bookCount: 20,
      coverUrl:
          "https://cdn.pastemagazine.com/www/system/images/photo_albums/best-book-covers-2019-so-far/large/bbc19bangkokrain.png?1384968217",
      overlayColor: "000000"),
];
