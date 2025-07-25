import 'package:flutter/material.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utils/dialog_box.dart';
import 'package:to_do_app/utils/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ToDoDataBase db = ToDoDataBase();

  // reference th hive box
  final _myBox = Hive.box('MyBox');

  @override
  void initState(){
  //if this 1st time opening the app, then create defaul data
  if(_myBox.get("TODOLIST")==null){
    db.createInitialData();
  }else{
    db.loadData();
  }

  super.initState();
  }



  // Text Cotriller
  final _controller = TextEditingController();

  
  
  // Checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  // save new task
  void saveNewTask(){
    setState(() {
    db.toDoList.add([_controller.text, false]);
    _controller.clear();  
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // create new task
  void createNewTask(){
    showDialog(
      context: context,
       builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
       }
    );
  }


  // Delete Task
  void deleteTask(int index){
    setState(() {  
    db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.yellow[200],
    appBar: AppBar(
      title: Text('TODO'),
      elevation: 0,
      backgroundColor: Colors.green[500],
    ),

    floatingActionButton: FloatingActionButton(
      onPressed: createNewTask ,
      child: Icon(Icons.add),
      ),

    body: ListView.builder(
      itemCount: db.toDoList.length,
      itemBuilder: (context, index){
      return TodoTile(
        taskName: db.toDoList[index][0], 
        taskComplete: db.toDoList[index][1], 
        onChanged: (value) => checkBoxChanged(value, index),
        deleteFunction: (context) => deleteTask(index),
        );
      }
      )
    );
  }
}