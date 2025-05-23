import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:note_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initiallize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
    
  }

  final List<Note> currentNote = [];

  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;
    await isar.writeTxn(() => isar.notes.put(newNote));
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    List<Note> fetchNewNotes = await isar.notes.where().findAll();
    currentNote.clear();
    currentNote.addAll(fetchNewNotes);
    notifyListeners();
  }

  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(
        () => isar.notes.put(existingNote),
      );
      await fetchNotes();
    }
  }

  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
