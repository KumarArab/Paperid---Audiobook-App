import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/book_player.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BookDetails extends StatelessWidget {
  final FBookModel book;

  BookDetails({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Book(coverUrl: book.cover),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      // "Conjure Women",
                      book.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      //"By Afia Atakora",
                      "By ${book.author ?? "Unkown"}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmoothStarRating(
                          rating: 3,
                          // bookList[index].rating
                          isReadOnly: false,
                          size: 25,
                          filledIconData: Icons.star,
                          halfFilledIconData: Icons.star_half,
                          defaultIconData: Icons.star_border,
                          starCount: 5,
                          allowHalfRating: true,
                          spacing: 2.0,
                          onRated: (value) {
                            print(value);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "4.0",
                          // bookList[index].rating.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 24),
                      width: 100,
                      child: FRaisedButton(
                          child: Text("PLAY"),
                          onPressed: () {
                            context.read<Player>().playAudio(book, 0);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => BookPlayer(),
                              ),
                            );
                          }),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Preface",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${book.preface.substring(0, 150)}...",
                                  style: TextStyle(
                                    fontSize: 20,
                                    letterSpacing: 1.5,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: Text("Read More"),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (ctx) => Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: Text(
                                                    // "Conjure Women",
                                                    book.name,
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  book.preface,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    letterSpacing: 1.5,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  "Chapters",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                              ),
                              Column(
                                children: buildAudioFileSection(book, context),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<ListTile> buildAudioFileSection(FBookModel book, BuildContext context) {
    List<ListTile> chapters = [];
    for (int i = 0; i < book.audios.length; i++) {
      chapters.add(ListTile(
        onTap: () {
          context.read<Player>().playAudio(book, i);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => BookPlayer(),
            ),
          );
        },
        leading: Icon(Icons.music_note_outlined),
        title: Text(book.audios[i].name ?? "Unknown"),
      ));
    }
    return chapters;
  }
}

// class Book extends StatelessWidget {
//   final FBookModel book;

//   Book({this.book});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: SizeConfig.height,
//         width: SizeConfig.width,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 100,
//             ),
//             Container(
//               height: SizeConfig.height * 0.4,
//               child: Image.network(
//                 book.cover,
//               ),
//             ),
//             Text(book.name),
//             Text(book.author ?? ""),
//             Container(
//               height: SizeConfig.height * 0.3,
//               width: SizeConfig.width,
//               padding: EdgeInsets.all(20),
//               child: buildAudioFileSection(book.audios, context),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//}
