
import 'package:words_project/sql_word_project/repositories/db_client.dart';

class Word{
  int id;
  String title;
  String subsTitle;
  bool isCompleate;
  
  Word({this.title , this.subsTitle ,this.isCompleate=false});

  Word.fromJson(Map<String , dynamic> map){
    this.id = map['${DBClient.wordIdColumn}'];
    this.title = map['${DBClient.wordTitleColumn}'];
    this.subsTitle = map['${DBClient.wordSubSTitleColumn}'];
    this.isCompleate = map['${DBClient.wordisCompleatColumn}'] == 1 ? true : false ;

  }

  toJson(){
    return{
      DBClient.wordTitleColumn : this.title,
      DBClient.wordSubSTitleColumn : this.subsTitle,
      DBClient.wordisCompleatColumn : this.isCompleate==true ? 1 : 0

    };

  }

  togelTask(){
     this.isCompleate = !this.isCompleate;
    print(this.isCompleate);
  }

}