import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';
import 'package:words_project/sql_word_project/ui/screens/saved_tab.dart';
import 'package:words_project/sql_word_project/ui/screens/tosave_tab.dart';

import 'package:words_project/sql_word_project/ui/screens/words_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<String> tabsName = ["English", "compleate", "Last"];

    return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          backgroundColor: Colors.pink[500],
          title: Text("EnglishWords"),
          bottom: TabBar(
              controller: tabController,
              tabs: tabsName
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList()),
        ),
        body: FutureBuilder(
            future: Provider.of<DBProvider>(context).setAllLists(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TabBarView(controller: tabController, children: <Widget>[
                  WordTab(),
                  ToSaveTab(),
                  SavedTab(),
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
