import 'package:audiobook/services/database.dart';
import 'package:audiobook/services/booksData.dart';
import 'package:audiobook/ui/screens/404.dart';
import 'package:audiobook/ui/screens/tabs/discover.dart';
import 'package:audiobook/ui/screens/tabs/library.dart';
import 'package:audiobook/ui/screens/tabs/search.dart';
import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> homeTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> searchTabNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> libraryTabNavKey = GlobalKey<NavigatorState>();

class AppFrame extends StatefulWidget {
  static const routeName = '/appframe';
  @override
  _AppFrameState createState() => _AppFrameState();
}

class _AppFrameState extends State<AppFrame> {
  ValueNotifier<int> _pageNotifier = ValueNotifier(0);

  final listOfKeys = [homeTabNavKey, searchTabNavKey, libraryTabNavKey];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    context
        .read<BookData>()
        .fetchBooks(Section.All, "")
        .then((_) => print("Books Updated"));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !await listOfKeys[_pageNotifier.value].currentState.maybePop();
      },
      child: CupertinoTabScaffold(
          backgroundColor: Colors.white,
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            activeColor: AppTheme().primaryColor,
            inactiveColor: Colors.black,
            items: [
              navItem("Discover", "assets/svgs/home.svg"),
              navItem("Search", "assets/svgs/search.svg"),
              navItem("Library", "assets/svgs/library.svg")
            ],
            currentIndex: _pageNotifier.value,
            onTap: (page) {
              setState(() {
                _pageNotifier.value = page;
              });
            },
          ),
          tabBuilder: (ctx, i) {
            if (i == 0) {
              return CupertinoTabView(
                navigatorKey: homeTabNavKey,
                builder: (ctx) => Discover(),
              );
            } else if (i == 1) {
              return CupertinoTabView(
                navigatorKey: searchTabNavKey,
                builder: (ctx) => Search(),
              );
            } else if (i == 2) {
              return Library();
            }
            return CupertinoTabView(
              navigatorKey: libraryTabNavKey,
              builder: (ctx) => Library(),
            );
          }),
    );
  }

  navItem(String label, String asset) {
    return BottomNavigationBarItem(
      label: label,
      activeIcon: SvgPicture.asset(
        asset,
        height: 25,
        color: AppTheme().primaryColor,
      ),
      tooltip: label,
      icon: SvgPicture.asset(
        asset,
        height: 25,
      ),
    );
  }
}
