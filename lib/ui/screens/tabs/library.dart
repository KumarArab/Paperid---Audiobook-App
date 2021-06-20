import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/authors.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/foryou.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/genres.dart';
import 'package:audiobook/ui/screens/tabs/home%20tabs/premium.dart';
import 'package:audiobook/ui/screens/tabs/library%20tabs/downloads.dart';
import 'package:audiobook/ui/screens/tabs/library%20tabs/local_library.dart';
import 'package:audiobook/ui/screens/tabs/library%20tabs/shelves.dart';
import 'package:audiobook/ui/widgets/appbar.dart';
import 'package:audiobook/ui/widgets/drawer.dart';
import 'package:audiobook/ui/widgets/miniplayer.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  PageController _controller;
  ValueNotifier<int> _pageNotifier;

  @override
  void initState() {
    _controller = PageController();
    _pageNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MiniPlayer(),
      drawer: FDrawer(),
      drawerEnableOpenDragGesture: true,
      resizeToAvoidBottomInset: false,
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
                              child: section(context, "Downloads", value, 0),
                            ),
                            Expanded(
                              child: section(context, "Shelves", value, 1),
                            ),
                            Expanded(
                              child:
                                  section(context, "Local Library", value, 2),
                            ),
                          ],
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(value * SizeConfig.width * 0.33, 0),
                        // duration: Duration(milliseconds: 600),
                        // curve: Curves.easeInOutSine,
                        // left: value * SizeConfig.width * 0.2,
                        child: Container(
                          width: SizeConfig.width * 0.33,
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
                children: [Downloads(), Shelves(), LocalLibrary()],
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
