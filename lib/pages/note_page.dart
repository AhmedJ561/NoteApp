import 'package:flutter/material.dart';
import 'package:note_app/models/drawer_tile.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_database.dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late TextEditingController textController;
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.black,
    ),
  );
  void createNewNote() {
    textController = TextEditingController(text: "New Note");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: textController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
            decoration: InputDecoration(
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                onPressed: () => {
                  context.read<NoteDataBase>().addNote(textController.text),
                  Navigator.of(context).pop(),
                },
                child: Text(
                  "OK",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                onPressed: () => {Navigator.of(context).pop()},
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void readNote() {
    context.watch<NoteDataBase>().fetchNotes();
  }

  void deleteBox(Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        contentTextStyle:
            TextStyle(color: Theme.of(context).colorScheme.secondary),
        content: const SizedBox(
            width: double.maxFinite,
            child: Text("Do You Want To Delete the Note?")),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                onPressed: () => {
                  context.read<NoteDataBase>().deleteNote(note.id),
                  Navigator.of(context).pop(),
                },
                child: Text(
                  "OK",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              MaterialButton(
                color: Theme.of(context).colorScheme.inversePrimary,
                onPressed: () => {Navigator.of(context).pop()},
                child: Text(
                  "Cancel",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void updateBox(Note note) {
    showDialog(
      context: context,
      builder: (context) {
        textController = TextEditingController(text: note.text);
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(2)),
          contentTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Text(
                  note.text,
                  maxLines: (note.text.length / 2).round(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        content: SizedBox(
                          width: double.maxFinite,
                          child: TextField(
                            controller: textController,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: border,
                              focusedBorder: border,
                            ),
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  context
                                      .read<NoteDataBase>()
                                      .updateNote(note.id, textController.text);
                                  Navigator.of(context).pop();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDataBase>();
    noteDatabase.fetchNotes();
    List<Note> currentNote = noteDatabase.currentNote;
    return Scaffold(
      drawer: const DrawerTile(),
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(side: BorderSide(style: BorderStyle.none)),
        onPressed: createNewNote,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: ListView.builder(
          itemCount: currentNote.length,
          itemBuilder: (context, index) {
            final note = currentNote[index];
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
              child: ListTile(
                onTap: () => updateBox(note),
                contentPadding: const EdgeInsets.all(8),
                textColor: Colors.white,
                tileColor: Theme.of(context).colorScheme.inversePrimary,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    note.text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () => deleteBox(note),
                  icon: const Icon(Icons.delete),
                  color: Colors.white,
                ),
              ),
            );
          }),
    );
  }
}
