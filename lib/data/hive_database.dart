import 'package:apple_notes_app/models/note.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // reference our hive box
  final _myBox = Hive.box('note_database');

  // load notes
  List<Note> loadNotes() {
    List<Note> saveNotesFormatted = [];

    // if there exist notes, return that, otherwise return empty list
    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        // create individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][i]);
        // add to list
        saveNotesFormatted.add(individualNote);
      }
    } else {
      // default first note
      saveNotesFormatted.add(
        Note(id: 0, text: 'First Note'),        
      );
    }

    return saveNotesFormatted;
  }

  // save notes
  void saveNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*

      [

        [ 0, "First Note"],
        [1, "Second Note"],
        ..

      ]

      */
    ];

    // each note has an id and  text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }

    // then storm into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
