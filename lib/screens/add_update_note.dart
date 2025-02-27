
import 'package:flutter/material.dart';
import 'package:sqflite_flutter/models/note.dart';

class AddUpdateNote extends StatefulWidget {
  final Note? note;
  const AddUpdateNote({this.note, super.key});

  @override
  State<AddUpdateNote> createState() => _AddUpdateNoteState();
}

class _AddUpdateNoteState extends State<AddUpdateNote> {

  final titleController = TextEditingController();
  final subTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    if(widget.note != null) {
      titleController.text = widget.note!.title;
      subTitleController.text = widget.note!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Add Note", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              icon: Icon(Icons.check_circle_rounded),
              onPressed: () {
                String title = titleController.text;
                String subTitle = subTitleController.text;
                if(title.isEmpty || subTitle.isEmpty) {
                  print('please enter required fields');
                } else {
                  Note note = Note(1, DateTime.now().millisecondsSinceEpoch, titleController.text, subTitleController.text);
                  Navigator.pop(context, note);
                }
              },
          )
        ],
      ),

      body: Column(
        children: [

          myTextField("Title", titleController),
          myTextField("Description", subTitleController),

        ],
      ),

    );
  }
}

Widget myTextField(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue.shade500)
        )
      ),
    ),
  );
}
