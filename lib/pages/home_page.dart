import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/utilities/dialog_box.dart';
import 'package:todo_app/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exist data
      db.loadData();
    }

    super.initState();
  }

// VARIABLES
  // text controller
  final _controller = TextEditingController();

// FUNCTIONS
  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDateBase();
  }

  // save new task
  void saveNewTask() {
    if (_controller.text.trim().isNotEmpty) {
      // Check if text is not empty
      setState(() {
        db.toDoList.add([_controller.text.trim(), false]);
        _controller.clear();
      });
    }
    Navigator.of(context).pop();
    db.updateDateBase();
  }

  // cancel
  void cancelTask() {
    setState(() {
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  // create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: cancelTask,
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDateBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // AppBar
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: const Text(
          "TO DO",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),

      // Body
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),

      // Floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        // opPressed calls a function named createNewTask
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
