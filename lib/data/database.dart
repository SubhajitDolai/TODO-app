import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('myBox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Project", false],
      ["Do Exercise", false],
    ];
  }

  // load the data from database
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDateBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
