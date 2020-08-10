import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';
import 'package:words_project/sql_word_project/models/words.dart';
import 'package:words_project/sql_word_project/repositories/db_repository.dart';

class DBProvider extends ChangeNotifier{
  List<Word> allWords = [];
  List<Word> subSWords = [];
  List<Word> completeWords = [];
  List<Word> inCompleteWords = [];
  final translator = new GoogleTranslator();

   Future<List<Word>> setAllLists() async {
    List<Word> words = await DBRepository.dbRepository.geAllWords();
    this.allWords = words;
    this.subSWords = await DBRepository.dbRepository.geSubsWords();
    this.completeWords = await DBRepository.dbRepository.getCompleteWord();
    this.inCompleteWords = await DBRepository.dbRepository.getInCompleteWord();
    notifyListeners();

    return words;
  }
    insertNewTask(Word word) async {
    await DBRepository.dbRepository.insertNewWord(word);
    setAllLists();
  }

  updateTask(Word word) async {
    await DBRepository.dbRepository.updateWord(word);
    //print('update');
    setAllLists();
  }

  deleteTask(Word word) async {
    print('delete2');
    await DBRepository.dbRepository.deleteWord(word);
    print('delete8');

    setAllLists();
  }

  deleteAllTasks() async {
    await DBRepository.dbRepository.deleteAllWords();
    setAllLists();
  }
   translateWord(String word) async{
    String result = await  translator.translate(word, from: 'en', to: 'ar');
    notifyListeners();
    return result;
  }
}