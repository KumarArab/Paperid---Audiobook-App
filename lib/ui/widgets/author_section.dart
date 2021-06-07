import 'package:audiobook/ui/screens/tabs/author_single.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class AuthorSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: kToolbarHeight,
            child: Row(
              children: [
                Text(
                  "Authors",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "View All",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: AppTheme().primaryColor),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: SizeConfig.width * 0.5,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: kAuthorList.length,
              itemBuilder: (ctx, i) {
                return GestureDetector(
                  onTap: () => Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (ctx) => AuthorSingle(
                        author: kAuthorList[i].name,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
                          width: SizeConfig.width * 0.2,
                          height: SizeConfig.width * 0.2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(kAuthorList[i].imagepath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          kAuthorList[i].name,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Colors.black,
                              ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
