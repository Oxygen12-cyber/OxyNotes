import 'package:flutter/material.dart';

extension ResponsiveSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  // Responsive height (percentage)
  double hp(double percentage) => height * (percentage / 100);

  // Responsive width (percentage)
  double wp(double percentage) => width * (percentage / 100);
}

class NoteClass extends ChangeNotifier {
  final List<Map<String, dynamic>> _noteStore = [];
  final String? title;
  final String? content;
  List<Map<String, dynamic>> get noteStore => _noteStore;

  NoteClass({this.title, this.content});

  void addNewNote(title, content) {
    _noteStore.insert(0, {"title": title, "content": content});
    notifyListeners();
  }

  void editNote(title, content, int index) {
    _noteStore[index] = {"title": title, "content": content};
    notifyListeners();
  }

  void deleteNote(int index) {
    _noteStore.removeAt(index);
    notifyListeners();
  }
}
