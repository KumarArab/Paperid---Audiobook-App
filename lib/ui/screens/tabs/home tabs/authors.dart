import 'dart:convert';

import 'package:audiobook/models/authorModel.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/author_single.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Authors extends StatefulWidget {
  @override
  _AuthorsState createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {
  TextEditingController _searchAuthorController;
  String selectedAlp = '';

  @override
  void initState() {
    _searchAuthorController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authorList = selectedAlp != ''
        ? context.watch<AppData>().searchAuthorResult
        : context.watch<AppData>().allAuthors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // TextBox(
          //   controller: _searchAuthorController,
          //   isObsecure: false,
          //   label: "Search Author",
          // ),
          Container(
            height: kToolbarHeight,
            width: SizeConfig.width,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 26,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAlp = String.fromCharCode(i + 65);
                          context
                              .read<AppData>()
                              .fetchAuthors(AuthorSearch.Start, selectedAlp);
                        });
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor:
                            selectedAlp == String.fromCharCode(i + 65)
                                ? AppTheme().primaryColor
                                : AppTheme().primaryColor.withOpacity(0.15),
                        child: Text(
                          String.fromCharCode(i + 65),
                          style: TextStyle(
                              color: selectedAlp == String.fromCharCode(i + 65)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: authorList.length == 0
                  ? Center(child: SnackToast().showLoadingAsset())
                  : GridView.count(
                      crossAxisCount: 2,
                      children: List.generate(authorList.length, (index) {
                        return AuthorCard(author: authorList[index]);
                      }),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthorCard extends StatelessWidget {
  final FAuthorModel author;
  AuthorCard({this.author});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => AuthorSingle(
            author: author.name,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(author.imagepath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              author.name,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
