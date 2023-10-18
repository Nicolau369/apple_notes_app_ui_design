import 'package:apple_notes_app/data/hive_database.dart';
import 'package:apple_notes_app/models/note.dart';
import 'package:flutter/widgets.dart';

class NoteData extends ChangeNotifier {
  // hive databse
  final db = HiveDatabase();

  // overrall list of notes
  List<Note> allNotes = [];

  // initalize list
  void initialize() {
    allNotes = db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  // add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  // update note
  void updateNote(Note note, String text) {
    // go thru list of all notes
    for (int i = 0; i < allNotes.length; i++) {
      // find the relevant note
      if (allNotes[i].id == note.id) {
        // replace text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  // delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
