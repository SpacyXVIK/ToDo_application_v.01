import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList = [];

  // reference our box
  final _myBox = Hive.box('MyBox');

  // run this method if this is 1st time opening this app
  void createInitialData(){
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  // load the data from database
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDatabase(){
    _myBox.put("TODOLIST", toDoList);
  }
}