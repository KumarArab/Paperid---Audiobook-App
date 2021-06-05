import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/services/homedata.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/book%20Details/info_content.dart';
import 'package:audiobook/ui/screens/book%20Details/review_rating.dart';
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

class BookDetails extends StatefulWidget {
  final FBookModel book;

  BookDetails({this.book});

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  PageController _controller;
  ValueNotifier<int> _pageNotifier;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    _pageNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 13),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _pageNotifier,
            builder: (ctx, value, _) {
              return Container(
                height: kToolbarHeight,
                width: SizeConfig.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.grey.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: section(context, "Info & Content", value, 0),
                          ),
                          Expanded(
                            child:
                                section(context, "Review & Ratings", value, 1),
                          ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(value * SizeConfig.width * 0.5, 0),
                      // duration: Duration(milliseconds: 600),
                      // curve: Curves.easeInOutSine,
                      // left: value * SizeConfig.width * 0.2,
                      child: Container(
                        width: SizeConfig.width * 0.5,
                        alignment: Alignment.center,
                        child: Container(
                          width: 20,
                          height: 15,
                          decoration: BoxDecoration(
                            color: AppTheme().primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              onPageChanged: (page) {
                _pageNotifier.value = page;
              },
              physics: BouncingScrollPhysics(),
              children: [
                InfoContent(
                  book: widget.book,
                ),
                ReviewRating()
              ],
            ),
          )
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Book(coverUrl: widget.book.cover),
      // SizedBox(
      //   height: 20,
      // ),
      // Text(
      //   // "Conjure Women",
      //   widget.book.name,
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     fontSize: 30,
      //     fontWeight: FontWeight.w700,
      //   ),
      // ),
      // SizedBox(
      //   height: 8,
      // ),
      // Text(
      //   //"By Afia Atakora",
      //   "By ${widget.book.author ?? "Unkown"}",
      //   style: TextStyle(
      //     fontSize: 20,
      //     fontWeight: FontWeight.w500,
      //   ),
      // ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      // SmoothStarRating(
      //   rating: 3,
      //   // bookList[index].rating
      //   isReadOnly: false,
      //   size: 25,
      //   filledIconData: Icons.star,
      //   halfFilledIconData: Icons.star_half,
      //   defaultIconData: Icons.star_border,
      //   starCount: 5,
      //   allowHalfRating: true,
      //   spacing: 2.0,
      //   onRated: (value) {
      //     print(value);
      //   },
      // ),
      //     SizedBox(
      //       width: 10,
      //     ),
      //     Text(
      //       "4.0",
      //       // bookList[index].rating.toString(),
      //       style: TextStyle(
      //         fontSize: 24,
      //         fontWeight: FontWeight.w700,
      //       ),
      //     )
      //   ],
      // ),
      // Container(
      //   margin: EdgeInsets.symmetric(vertical: 24),
      //   width: 100,
      //   child: FRaisedButton(
      //       child: Text("PLAY"),
      //       onPressed: () {
      // context.read<Player>().playAudio(widget.book, 0);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) => BookPlayer(),
      //   ),
      // );
      //       }),
      // ),
      // Expanded(
      //   child: Container(
      //     margin: EdgeInsets.symmetric(horizontal: 30),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 8.0),
      //             child: Text(
      //               "Preface",
      //               style: Theme.of(context).textTheme.headline5.copyWith(
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //             ),
      //           ),
      //           Container(
      //             child: Text(
      //               "${widget.book.preface.substring(0, 150)}...",
      //               style: TextStyle(
      //                 fontSize: 20,
      //                 letterSpacing: 1.5,
      //                 height: 1.5,
      //               ),
      //             ),
      //           ),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.end,
      //             children: [
      //               TextButton(
      //                 child: Text("Read More"),
      //                 onPressed: () {
      //                   showModalBottomSheet(
      //                     context: context,
      //                     builder: (ctx) => Container(
      //                       padding: EdgeInsets.symmetric(horizontal: 30),
      //                       child: SingleChildScrollView(
      //                         child: Column(
      //                           children: [
      //                             Padding(
      //                               padding: const EdgeInsets.all(20.0),
      //                               child: Text(
      //                                 // "Conjure Women",
      //                                 widget.book.name,
      //                                 style: TextStyle(
      //                                   fontSize: 30,
      //                                   fontWeight: FontWeight.w700,
      //                                 ),
      //                               ),
      //                             ),
      //                             Text(
      //                               widget.book.preface,
      //                               style: TextStyle(
      //                                 fontSize: 20,
      //                                 letterSpacing: 1.5,
      //                                 height: 1.5,
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               )
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.symmetric(vertical: 8.0),
      //             child: Text(
      //               "Chapters",
      //               style: Theme.of(context).textTheme.headline5.copyWith(
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //             ),
      //           ),
      //           Column(
      //             children: buildAudioFileSection(widget.book, context),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget section(BuildContext context, String text, int val, int id) {
    return GestureDetector(
      onTap: () => _controller.animateToPage(id,
          duration: Duration(milliseconds: 600), curve: Curves.easeInOutSine),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6.copyWith(
              fontWeight: val == id ? FontWeight.w700 : FontWeight.w500,
              color: val == id ? AppTheme().primaryColor : Colors.black,
            ),
        textAlign: TextAlign.center,
      ),
    );
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
