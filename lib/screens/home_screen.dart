
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/models/note.dart';
import 'package:sqflite_flutter/screens/add_update_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Note> notes = [
    Note(1, 1, "task1", "description"),
    Note(2, 1, "task2", "description"),
    Note(3, 1, "task3", "description"),
    Note(4, 1, "task4", "description"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteApp", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue.shade500,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: ElevatedButton(
                child: Text("AddNote"),
                onPressed: () async {
                  final response = await Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AddUpdateNote(),)
                  );
                  if(response != null) {
                    print("back response: $response");
                  }
                },
            ),
          )
        ],
      ),

      body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notes[index].title),
              subtitle: Text(notes[index].description),
              leading: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddUpdateNote(note: notes[index],),));
                  },
              ),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                  },
              ),
            );
          },
        itemCount: notes.length,
      ),

    );
  }
}