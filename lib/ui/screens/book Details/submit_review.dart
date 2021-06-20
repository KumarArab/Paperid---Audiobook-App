import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/appTheme.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SubmitReview extends StatefulWidget {
  @override
  _SubmitReviewState createState() => _SubmitReviewState();
}

class _SubmitReviewState extends State<SubmitReview> {
  TextEditingController _reviewController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    size: 40,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  padding: EdgeInsets.only(left: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Rate The Audiobook",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: AppTheme().tertiaryColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Book Rate",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SmoothStarRating(
                        rating: 3,
                        // bookList[index].rating
                        isReadOnly: false,
                        size: SizeConfig.width * 0.15,
                        color: AppTheme().tertiaryColor,
                        borderColor: Colors.black38,

                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {},
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(
                            Icons.mic_rounded,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Narration Rate",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    height: 1.4),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SmoothStarRating(
                        rating: 3,
                        // bookList[index].rating
                        isReadOnly: false,
                        size: SizeConfig.width * 0.15,
                        color: Colors.red,
                        borderColor: Colors.black38,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        defaultIconData: Icons.star_border,
                        starCount: 5,
                        allowHalfRating: true,
                        spacing: 2.0,
                        onRated: (value) {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Write Your Review",
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      TextField(
                        enableSuggestions: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        controller: _reviewController,
                        decoration: new InputDecoration(
                          labelText: "Start Typing here",
                          //fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FRaisedButton(
                          child: Text(
                            "Submit Review & Rating",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    height: 1),
                          ),
                          onPressed: () {}),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
