import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/authors.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/foryou.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/premium.dart';
import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/ui/widgets/drawer.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  PageController _controller;
  ValueNotifier<int> _pageNotifier;

  @override
  void initState() {
    _controller = PageController();
    _pageNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    AppData appData = context.read<AppData>();
    appData.fetchBooks(Section.CurrRead, "");
    appData.fetchBooks(Section.All, "").then(
          (_) => print("All Books Updated"),
        );
    appData.fetchBooks(Section.Trending, "Trending").then(
          (_) => print("Trending Books Updated"),
        );
    appData
        .fetchAuthors(AuthorSearch.All, "")
        .then((_) => print("Authors updated"));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      drawer: FDrawer(),
      drawerEnableOpenDragGesture: true,
      body: SafeArea(
        child: Column(
          children: [
            FAppBar(
              isAction: true,
            ),
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
                              child: section(context, "For you", value, 0),
                            ),
                            Expanded(
                              child: section(context, "Genres", value, 1),
                            ),
                            Expanded(
                              child: section(context, "Authors", value, 2),
                            ),
                            Expanded(
                              child: section(context, "Premium", value, 3),
                            )
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(value * SizeConfig.width * 0.25, 0),
                        // duration: Duration(milliseconds: 600),
                        // curve: Curves.easeInOutSine,
                        // left: value * SizeConfig.width * 0.2,
                        child: Container(
                          width: SizeConfig.width * 0.25,
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
                physics: NeverScrollableScrollPhysics(),
                children: [ForYou(), Genres(), Authors(), Premium()],
              ),
            )
          ],
        ),
      ),
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
