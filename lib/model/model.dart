import 'dart:io';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Color getRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

final supabase = Supabase.instance.client;

class SupabaseDb extends ChangeNotifier {
  final User? user = supabase.auth.currentUser;

  final List<Map<String, dynamic>> _noteCache = [];
  final String? title;
  final String? content;

  List<Map<String, dynamic>> get noteCache => _noteCache;

  SupabaseDb({this.title, this.content});

  Future<void> getAllNotes() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    _noteCache.clear();
    try {
      final notes = await supabase
          .from('notes')
          .select("id, title, content, created_at")
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      for (var note in notes) {
        _noteCache.add({
          'id': note['id'],
          'title': note['title'],
          'content': note['content'],
          'created_time': note['created_at'],
        });
      }
    
    } on SocketException catch (err) {
      debugPrint('internet error');
      throw err.toString();
    }  on PostgrestException catch (e) {
      debugPrint('Supabase error: $e');
      'Database error: ${e.message}';
    } catch (err) {
      throw err.toString();
    }
    notifyListeners();
  }

  Future<void> addNewNote(title, content) async {
    if (user == null) {
      return;
    }
    try {
      await supabase.from('notes').insert({
        'user_id': user?.id,
        'title': title,
        'content': content,
      });
    } catch (err) {
      debugPrint('adding new note failed: ${err.toString()}');
      throw err.toString();
    }
    notifyListeners();
  }

  Future<void> editNote(title, content, index, noteId) async {
    if (user == null) {
      return;
    }
    try {
      await supabase
          .from('notes')
          .update({'title': title, 'content': content})
          .eq('user_id', user!.id)
          .eq('id', noteId);
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
    notifyListeners();
  }

  Future<void> deleteNote(title, content, noteId) async {
    if (user == null) return;
    try {
      debugPrint('trying to delete');

      await supabase
          .from('notes')
          .delete()
          .eq('id', noteId)
          .eq('user_id', user!.id);
      debugPrint('deleted already');

      getAllNotes();
    } catch (err) {
      debugPrint(err.toString());
      throw err.toString();
    }
    notifyListeners();
  }
}
