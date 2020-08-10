import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/repositories/db_client.dart';

class DBRepository{

  DBRepository._();

 static final DBRepository dbRepository = DBRepository._();

 insertNewWord(Word word)async{
   await DBClient.dbClient.insertWordDB(word.toJson());
   print('insert');

 }

 Future<List<Word>> geAllWords()async{
   List<Map<String, dynamic>> result= await DBClient.dbClient.getAllWords();
   List<Word> listAllWord = result.map((e) => Word.fromJson(e)).toList();
   return listAllWord;

 }
 Future<List<Word>> geSubsWords()async{
   List<Map<String, dynamic>> result= await DBClient.dbClient.getSubsWord();
   List<Word> listSubsWord = result.map((e) => Word.fromJson(e)).toList();
   return listSubsWord;

 }
 Future<List<Word>> getCompleteWord() async {
    List<Map<String, dynamic>> results =
        await DBClient.dbClient.getCompleteWords();
    List<Word> words = results.map((e) => Word.fromJson(e)).toList();
    return words;
  }

  Future<List<Word>> getInCompleteWord() async {
    List<Map<String, dynamic>> results =
        await DBClient.dbClient.getInCompleteWords();
    List<Word> words = results.map((e) => Word.fromJson(e)).toList();
    return words;
  }

  Future<int> updateWord(Word word) async {
    word.togelTask();
    int x = await DBClient.dbClient.updateWord(word.toJson(), word.id);
    
    return x;
  }
  Future<int> deleteWord(Word word) async {
    print('delete3');
    int x = await DBClient.dbClient.deleteWord(word.id);
    print('delete7');
    return x;
  }
  deleteAllWords() async {
    await DBClient.dbClient.deleteAllWords();
  }



}