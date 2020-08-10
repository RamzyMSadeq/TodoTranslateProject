import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';

class SavedTab extends StatefulWidget {
  @override
  _SavedTabState createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(builder: (context, value, child) {
      List<Word> mainList = value.inCompleteWords;
      return Container(
        color: Colors.blue[50],
        child: ListView.builder(
          itemCount: mainList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                  '${mainList[index].title}  = ${mainList[index].subsTitle} '),
            );
          },
        ),
      );
    });
  }
}
