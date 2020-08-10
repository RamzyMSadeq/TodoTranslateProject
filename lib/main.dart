import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:words_project/sql_word_project/providers/db_provider.dart';
import 'package:words_project/sql_word_project/ui/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DBProvider>(
      create: (context) => DBProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
