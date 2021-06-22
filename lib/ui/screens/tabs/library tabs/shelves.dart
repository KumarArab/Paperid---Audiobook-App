import 'package:audiobook/models/shelfModel.dart';
import 'package:audiobook/services/appData.dart';
import 'package:audiobook/ui/screens/tabs/shelf.dart';
import 'package:audiobook/utils/dummy_data.dart';
import 'package:audiobook/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shelves extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FShelfModel> shelves = context.watch<AppData>().getShelves;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: shelves.isEmpty
          ? Center(
              child: SnackToast().showLoadingAsset(),
            )
          : GridView.count(
              childAspectRatio: 1 / 1.5,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: List.generate(
                shelves.length,
                (index) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => Shelf(
                                  shelf: shelves[index].name,
                                ))),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://images-na.ssl-images-amazon.com/images/I/61XDLylhfTL._SX450_.jpg"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          shelves[index].name,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
