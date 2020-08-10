import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBClient{
  DBClient._();

  static final DBClient dbClient = DBClient._();


  Database database;
  static final String wordTableName = 'words';
  static final String wordIdColumn = 'id';
  static final String wordTitleColumn = 'title';
  static final String wordSubSTitleColumn = 'subscTitle';
  static final String wordisCompleatColumn = 'wordCompleat';
 

  Future<Database> initDB() async {
    if(database != null){
      return database;
    }else{
      database = await connectToDB();
      return database;
    }

  }

  Future<Database> connectToDB() async {

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = join(appDocDir.path , 'words.db');
    Database db = await openDatabase(path , version: 1 , onCreate:(db , version){
          db.execute('''CREATE TABLE $wordTableName(
          $wordIdColumn INTEGER PRIMARY KEY AUTOINCREMENT,
          $wordTitleColumn TEXT NOT NULL,
          $wordSubSTitleColumn TEXT NOT NULL,
          $wordisCompleatColumn INTEGER NOT NULL
        )''');
       
    });
    return db;
  }

  Future<int> insertWordDB(Map<String , dynamic> word)async{
    try{
      database = await initDB();
      int res = await database.insert(wordTableName, word);
      return res;
      }catch(error){
      throw 'database error $error';
    }

  }

  Future<List<Map<String, dynamic>>> getAllWords()async{
    try{
      database = await initDB();
    List<Map<String, dynamic>> listRes = await database.query(wordTableName);

    return listRes;
    }catch(error){
      throw 'database error $error';
    }

  }

  Future<List<Map<String, dynamic>>> getSubsWord() async {
    try {
      database = await initDB();
      List<Map<String, dynamic>> results = await database.query(wordTableName,columns: [wordSubSTitleColumn]);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }
  Future<List<Map<String, dynamic>>> getCompleteWords() async {
    try {
      database = await initDB();
      List<Map<String, dynamic>> results = await database.query(wordTableName,
          where: '$wordisCompleatColumn = ?', whereArgs: [1]);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }
  Future<List<Map<String, dynamic>>> getInCompleteWords() async {
    try {
      database = await initDB();
      List<Map<String, dynamic>> results = await database.query(wordTableName,
          where: '$wordisCompleatColumn = ?', whereArgs: [0]);
      return results;
    } catch (error) {
      throw 'database error $error';
    }
  }

  Future<int> updateWord(Map<String , dynamic> map , int id)async {
   try{
      database = await initDB();
    int result = await database.update(wordTableName, map ,
    where: '$wordIdColumn = ?' , whereArgs: [id]
    );
    print('nbhjn $result');
    return result;
   }catch(error){
     throw 'database error $error';
   }
  }
  deleteWord(int id) async {
    try {
      print('delete4');
      database = await initDB();
      int rows = await database.delete(wordTableName, where: '$wordIdColumn = ?', whereArgs: [id]);

          print('delete5');
      return rows;
    } catch (error) {
      print('delete6');
      throw 'database error $error';
      
    }
    
  }
  deleteAllWords() async {
    try {
      database = await initDB();
      int rows = await database.delete(wordTableName);
      return rows;
    } catch (error) {
      throw 'database error $error';
    }
  }


}

