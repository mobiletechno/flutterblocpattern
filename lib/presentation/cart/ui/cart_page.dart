import 'package:flutter/material.dart';

import '../../../data/storage/database_helper.dart';
import '../../home/model/home_model.dart';

class MyCartPage extends StatefulWidget {
  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final dbHelper = DatabaseHelper.instance;
  List<HomeModel> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    List<HomeModel> notes = await dbHelper.getAllNotes();
    setState(() {
      _notes = notes;
    });
  }



  void _updateNote(int index) async {
    HomeModel updatedNote = HomeModel(
      id: _notes[index].id,
      date:"" ,link:"" ,protected:false ,slug:"" ,
    );
    await dbHelper.update(updatedNote);
    setState(() {
      _notes[index] = updatedNote;
    });
  }

  void _deleteNote(int index) async {
    await dbHelper.delete(_notes[index].id!);
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter SQLite CRUD'),
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_notes[index].slug!),
            subtitle: Text(_notes[index].link!),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _updateNote(index);
                  },
                ),
                IconButton

                  (
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteNote(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // _addNote();
        },
      ),
    );
  }
}