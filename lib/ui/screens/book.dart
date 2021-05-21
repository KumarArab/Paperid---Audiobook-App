import 'package:audiobook/models/bookModel.dart';
import 'package:audiobook/models/chapterModel.dart';
import 'package:audiobook/services/player.dart';
import 'package:audiobook/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Book extends StatelessWidget {
  final FBookModel book;

  Book({this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              height: SizeConfig.height * 0.4,
              child: Image.network(
                book.cover,
              ),
            ),
            Text(book.name),
            Text(book.author),
            Container(
              padding: EdgeInsets.all(20),
              child: buildAudioFileSection(book.audios, context),
            )
          ],
        ),
      ),
    );
  }

  Widget buildAudioFileSection(
      List<FChapterModel> audios, BuildContext context) {
    List<ListTile> chapters = [];
    for (int i = 0; i < audios.length; i++) {
      chapters.add(ListTile(
        onTap: () => context.read<Player>().play(audios[i].name),
        leading: Icon(Icons.music_note_outlined),
        title: Text("Chapter ${i + 1}"),
      ));
    }
    return Column(
      children: chapters,
    );
  }
}
