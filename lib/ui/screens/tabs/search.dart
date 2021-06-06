import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/ui/widgets/textbox.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FAppBar(
                isAction: false,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Search",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      TextBox(
                        controller: _searchController,
                        isObsecure: false,
                        label: "Search anything",
                        onChanged: (val) {
                          print(val);
                        },
                      ),
                      showRecentSearches()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget showRecentSearches() {
    List<Widget> recentSearchTileList = [];
    for (int i = 0; i < kRecentSearches.length; i++) {
      recentSearchTileList.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Icon(
              Icons.timer_rounded,
              color: AppTheme().dolphinColor,
              size: 30,
            ),
            SizedBox(width: 20),
            Text(
              kRecentSearches[i],
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    height: 1.3,
                    color: AppTheme().dolphinColor,
                  ),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
              icon: Icon(
                Icons.next_plan_outlined,
                size: 20,
                color: AppTheme().primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _searchController.text = kRecentSearches[i];
                });
              },
            )
          ],
        ),
      ));
    }
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Recent Searches",
            style: Theme.of(context).textTheme.headline5.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          Column(
            children: recentSearchTileList,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
