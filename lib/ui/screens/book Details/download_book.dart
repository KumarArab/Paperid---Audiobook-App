import 'dart:ui';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/ui/screens/book_player.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/constants.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DownloadBook extends StatelessWidget {
  final FBookModel book;
  DownloadBook({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Text(
                        "Download This Audiobook",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      width: SizeConfig.width * 0.9,
                      child: Text(
                        "Select chapters of the audiobook which you want to download",
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: buildAudioFileSection(book, context),
                    )
                  ],
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                color: Colors.white.withOpacity(0.5),
                child: Center(
                    child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: AppTheme().primaryColor.withOpacity(0.5),
                  margin: EdgeInsets.symmetric(horizontal: 60),
                  child: Wrap(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            SvgPicture.asset(
                              "assets/svgs/premium.svg",
                              width: SizeConfig.width * 0.4,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            FRaisedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svgs/crown.svg",
                                      color: Colors.white,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Become Premium",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3),
                                    )
                                  ],
                                ),
                                onPressed: () {}),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                kPremiumText,
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                    //  Icon(
                    //   Icons.lock_outline,
                    //   size: 50,
                    //   color: AppTheme().primaryColor,
                    // ),
                    ),
              ),
            ),
            SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        ),
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
          leading: IconButton(
            icon: Icon(
              Icons.download_outlined,
              size: 40,
              color: AppTheme().mulledWineColor,
            ),
            onPressed: () {},
          ),
          subtitle: Text("11:07"),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "11.07 MB",
              ),
            ],
          ),
          contentPadding: EdgeInsets.only(right: 40, left: 10),
          minVerticalPadding: 20,
        ),
      );
    }
    return chapters;
  }
}
