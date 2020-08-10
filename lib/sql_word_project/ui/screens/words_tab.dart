import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';

class WordTab extends StatefulWidget {
  @override
  _WordTabState createState() => _WordTabState();
}

class _WordTabState extends State<WordTab> {
  TextEditingController controller = TextEditingController();
  String tr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          height: 30,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.pink[50],
                  offset: Offset(1.0, 3.0),
                  blurRadius: 2.0)
            ],
          ),
          child: Text(
            'English to Arabic',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.pink[800],
              fontSize: 20,
              fontWeight: FontWeight.w700,
              //decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        Expanded(child: Consumer<DBProvider>(
          builder: (context, value, child) {
            List<Word> mainList = value.allWords;

            return GridView.builder(
              itemCount: mainList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      value.updateTask(mainList[index]);
                      print(mainList[index].isCompleate);
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 200,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.pink[100],
                                  offset: Offset(1.0, 3.0),
                                  blurRadius: 2.0)
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  mainList[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  mainList[index].subsTitle,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Checkbox(
                              value: mainList[index].isCompleate,
                              onChanged: (v) {
                                value.updateTask(mainList[index]);
                              },
                            ),
                            IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () async {
                                  print('delete 1');
                                  await value.deleteTask(mainList[index]);
                                  print('delete9');
                                })
                          ],
                        ),
                      ],
                    ));
              },
            );
          },
        )),
        Consumer<DBProvider>(
          builder: (context, valu, child) {
            return Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 10, bottom: 10),
                    width: 350,
                    height: 50,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          labelText: 'english to arabic  ',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                    )),
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      String result = await valu.translateWord(controller.text);
                      int res = await valu.insertNewTask(
                          Word(title: controller.text, subsTitle: result));
                      valu.setAllLists();
                      print(res);
                    })
              ],
            );
          },
        )
      ],
    );
  }
}
