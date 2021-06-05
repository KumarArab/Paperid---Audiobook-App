import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/book%20Details/add_to_shelf.dart';
import 'package:audiobook/ui/screens/book%20Details/download_book.dart';
import 'package:audiobook/ui/screens/book_player.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class InfoContent extends StatelessWidget {
  final FBookModel book;

  InfoContent({this.book});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20),
            child: Book(
              coverUrl: book.cover,
              showRating: false,
            ),
          ),
          Text(
            book.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Text(
            book.author,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DetailSection(
                icon: Icons.star,
                color: AppTheme().tertiaryColor,
                score: book.rating,
                scoreTitle: "Book Score",
              ),
              DetailSection(
                icon: Icons.mic_rounded,
                color: AppTheme().secondaryColor,
                score: book.rating,
                scoreTitle: "Narrator Score",
              ),
              DetailSection(
                icon: Icons.timer_rounded,
                color: AppTheme().primaryColor,
                score: "7hr 41min",
                scoreTitle: "Duration",
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme().tertiaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme().primaryColor.withOpacity(0.1),
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        spreadRadius: 10),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (ctx) => DownloadBook(
                        book: book,
                      ),
                    ),
                  ),
                  child: Icon(Icons.download_rounded, color: Colors.white),
                ),
              ),
              Expanded(
                child: FRaisedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Start Listening",
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1.3),
                        )
                      ],
                    ),
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: 60,
                height: 60,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme().secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: AppTheme().primaryColor.withOpacity(0.1),
                        offset: Offset(0, 10),
                        blurRadius: 50,
                        spreadRadius: 10),
                  ],
                ),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (ctx) => AddToShelf(
                        bookname: book.name,
                      ),
                    ),
                  ),
                  child: SvgPicture.asset(
                    "assets/svgs/library.svg",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 30,
                ),
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              book.preface,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          Container(
            height: kToolbarHeight * 0.8,
            width: SizeConfig.width,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: book.genre.length,
              itemBuilder: (ctx, i) => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.only(right: 20),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppTheme().secondaryColor.withOpacity(0.1),
                ),
                child: Text(
                  book.genre[i],
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: AppTheme().secondaryColor,
                      ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                  20.0,
                ),
                child: Text(
                  "Added on 01 June 2020",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 10,
                ),
                child: Text(
                  "Content",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
          Column(
            children: buildAudioFileSection(book, context),
          )
        ],
      ),
    );
  }

  List<ListTile> buildAudioFileSection(FBookModel book, BuildContext context) {
    List<ListTile> chapters = [];
    for (int i = 0; i < book.audios.length; i++) {
      chapters.add(
        ListTile(
          onTap: () {
            context.read<Player>().playAudio(book, i);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => BookPlayer(),
              ),
            );
          },
          title: Text(
            book.audios[i].name ?? "Unknown",
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: Text("11:07"),
          trailing: IconButton(
            icon: Icon(
              Icons.play_circle_fill_rounded,
              size: 40,
              color: AppTheme().primaryColor,
            ),
            onPressed: () {},
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          minVerticalPadding: 20,
        ),
      );
    }
    return chapters;
  }
}

class DetailSection extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String score, scoreTitle;

  DetailSection({this.icon, this.score, this.scoreTitle, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                score,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            scoreTitle,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: Colors.black45,
                ),
          ),
        ],
      ),
    );
  }
}
