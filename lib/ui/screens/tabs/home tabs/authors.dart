import 'dart:convert';

import 'package:audiobook/ui/screens/tabs/author_single.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextBox(
            controller: _searchAuthorController,
            isObsecure: false,
            label: "Search Author",
          ),
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
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(kAuthorList.length, (index) {
                  return AuthorCard(
                    index: index,
                  );
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
  final int index;
  AuthorCard({this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => AuthorSingle(
            author: kAuthorList[index].name,
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
                    image: AssetImage(kAuthorList[index].imagepath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              kAuthorList[index].name,
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
