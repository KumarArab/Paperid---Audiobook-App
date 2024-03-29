import 'dart:ui';

import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/premium.dart';
import 'package:audiobook/ui/widgets/book.dart';
import 'package:audiobook/ui/widgets/book_grid.dart';
import 'package:audiobook/ui/widgets/premium_card.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Downloads extends StatefulWidget {
  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  TextEditingController _downloadSearchcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextBox(
                controller: _downloadSearchcontroller,
                isObsecure: false,
                label: "Search Downloads",
              ),
              Expanded(
                child: ListView(
                  children: List.generate(
                      context.watch<AppData>().allBooks.length, (index) {
                    FBookModel book = context.watch<AppData>().allBooks[index];
                    return Container(
                      // height: SizeConfig.height * 0.3,
                      width: SizeConfig.width,
                      child: Row(
                        children: [
                          Book(book: book),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0, bottom: 10),
                                    child: Text(
                                      book.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    book.author ?? "Unknown",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Colors.grey),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Text(
                                      "${book.audios.length} chapters " ??
                                          "Unknown",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                  Text("49min" ?? "Unknown",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.grey)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("12.54mb" ?? "Unknown",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.grey)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              )
            ],
          ),
        ),
        // BackdropFilter(
        //   filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        //   child: Container(
        //     color: Colors.white.withOpacity(0.5),
        //     child: Center(
        //         child: PremiumCard(
        //       text:
        //           "Download all the audiobooks of your choice and listen them offline anywhere anytime.",
        //     )
        //         //  Icon(
        //         //   Icons.lock_outline,
        //         //   size: 50,
        //         //   color: AppTheme().primaryColor,
        //         // ),
        //         ),
        //   ),
        // ),
      ],
    );
  }
}
