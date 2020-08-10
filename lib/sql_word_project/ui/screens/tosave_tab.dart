//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';
import 'package:words_project/sql_word_project/ui/widgets/showDialogWidget.dart';

class ToSaveTab extends StatefulWidget {
  @override
  _ToSaveTabState createState() => _ToSaveTabState();
}

class _ToSaveTabState extends State<ToSaveTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(
      builder: (context, value, child) {
        List<Word> mainList = value.completeWords;
        return ListView.builder(
            itemCount: mainList.length,
            itemBuilder: (contex, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.blue[50]),
                  child: ListTile(
                    title: Text(
                        '${mainList[index].title}  = ${mainList[index].subsTitle} '),
                  ),
                ),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'deleate',
                    color: Colors.blue,
                    icon: Icons.archive,
                    onTap: () {
                      value.updateTask(mainList[index]);

                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("The word is inCompleat"),
                        action: SnackBarAction(
                            label: "Close",
                            onPressed: () {
                              Scaffold.of(context).removeCurrentSnackBar();
                            }),
                      ));
                    },
                  ),
                  IconSlideAction(
                    caption: 'Translate',
                    color: Colors.indigo,
                    icon: Icons.add,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowWidget(this.context, index);
                          });
                    },
                  ),
                ],
              );
            });
      },
    );
  }
}
