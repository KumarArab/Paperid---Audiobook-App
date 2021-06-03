import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class AddToShelf extends StatefulWidget {
  final String bookname;
  AddToShelf({this.bookname});
  @override
  _AddToShelfState createState() => _AddToShelfState();
}

class _AddToShelfState extends State<AddToShelf> {
  TextEditingController _newShelfController = TextEditingController();
  List<bool> checkList = [true, false, false, false];

  List<String> shelves = [
    "Top Sci-fi Novels",
    "Must Listen Books",
    "Classics",
    "Top Fantasy Novels"
  ];

  mark(int i, val) {
    setState(() {
      checkList[i] = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
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
                    "Add to Shelf",
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
                    "Select the shelves you want to add this audiobook to:",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    ListTile(
                      onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) {
                            return Wrap(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Creating\na new Shelf",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(
                                              Icons.clear_rounded,
                                              size: 40,
                                              color: Colors.black,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 40,
                                      ),
                                      Text(
                                        "Name your Shelf",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                              color: AppTheme().mulledWineColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                      Container(
                                        width: SizeConfig.width * 0.8,
                                        child: TextBox(
                                          controller: _newShelfController,
                                          isObsecure: false,
                                          label: "Type a create Name",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: SizeConfig.width * 0.8,
                                        child: FRaisedButton(
                                            child: Text(
                                              "Create Shelf",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                checkList.add(false);
                                                shelves.add(
                                                    _newShelfController.text);
                                              });
                                            }),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      leading: Icon(
                        Icons.add_circle_outline_rounded,
                        color: AppTheme().primaryColor,
                        size: 40,
                      ),
                      title: Text(
                        "Create new Shelf",
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: AppTheme().primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: buildShelves(),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildShelves() {
    List<CheckboxListTile> shelfTiles = [];
    for (int i = 0; i < shelves.length; i++) {
      shelfTiles.add(
        CheckboxListTile(
          value: checkList[i],
          onChanged: (val) => mark(i, val),
          title: Text(
            shelves[i],
            style: Theme.of(context).textTheme.headline5.copyWith(
                  color: AppTheme().mulledWineColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          subtitle: checkList[i]
              ? Text("${widget.bookname} added to the shelf ${shelves[i]}")
              : SizedBox(),
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );
    }

    return shelfTiles;
  }
}
