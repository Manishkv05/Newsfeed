import 'package:flutter/material.dart';
import 'package:newsfeed/models/thewallstreetjournalmodel.dart';

class favListProvider with ChangeNotifier {
  List<Article> favarticl = [];

  List<Article> get numbers => favarticl;

  void addfavarticl(Article article) {
    favarticl.add(article);
    notifyListeners(); // This will notify all listeners about the change
  }

  void removefavarticl(Article article) {
    favarticl.remove(article);
    notifyListeners();
  }

  // void updateNumber(int index, Article newNumber) {
  //   favarticl[index] = newNumber;
  //   notifyListeners();
  // }
}
