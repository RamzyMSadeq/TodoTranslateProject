import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';

class ShowWidget extends StatelessWidget {
  BuildContext context1;
  final int index;
  ShowWidget(this.context1, this.index);

  TextEditingController texteditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<DBProvider>(
      builder: (context, value, child) {
        List<Word> mainList = value.allWords;
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Add Translate",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 45,
                    //width: ,
                    child: TextField(
                      controller: texteditingController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black45))),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          mainList[index].subsTitle =
                              texteditingController.text;
                          print(mainList[index].subsTitle);
                          value.updateTask(mainList[index]);

                          Navigator.of(context).pop();
                          Scaffold.of(this.context1).showSnackBar(SnackBar(
                            content: Text("Successful"),
                            backgroundColor: Colors.green[400],
                            action: SnackBarAction(
                                label: "Close",
                                onPressed: () {
                                  Scaffold.of(this.context1)
                                      .removeCurrentSnackBar();
                                }),
                          ));
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1F9F84),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Colse",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFFFCAA2F),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
