import 'package:audiobook/ui/widgets/flat_button.dart';
import 'package:audiobook/ui/widgets/raised_button.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';

class Genres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: FRaisedButton(
                  child: Text(
                    "Fiction",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: FFlatButton(
                  onTap: () {},
                  text: "Non-Fiction",
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(kGenreList.length, (index) {
                return GenreCard(
                  index: index,
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class GenreCard extends StatelessWidget {
  final int index;
  GenreCard({this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kGenreList[index].imagePath),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.bottomLeft,
      child: Text(
        kGenreList[index].name,
        style: Theme.of(context).textTheme.headline4.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
