import 'package:audiobook/ui/screens/book%20Details/submit_review.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            FRaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.rate_review_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Submit your rate and review",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1),
                  )
                ],
              ),
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (ctx) => SubmitReview(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    "24 Reviews",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: generateReviewTile(context),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> generateReviewTile(BuildContext context) {
    List<Widget> reviewList = [];
    for (int i = 0; i < kReviewList.length; i++) {
      reviewList.add(
        Wrap(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(kReviewList[i].imageurl),
                        radius: 35,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              kReviewList[i].name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.star,
                              color: AppTheme().tertiaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              kReviewList[i].bookRate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.mic_rounded,
                              color: AppTheme().secondaryColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              kReviewList[i].narrRate,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          kReviewList[i].review,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
    return reviewList;
  }
}
