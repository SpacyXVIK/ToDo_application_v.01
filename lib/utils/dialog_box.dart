import 'package:flutter/material.dart';
import 'package:to_do_app/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;



    DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
    backgroundColor: Colors.greenAccent,
    content: Container(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          // Input  User Data
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Add a New Task',
            ),
          ),

          // Button = Save and Cancel
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

            // Save button
            MyButton(text: 'Save', onPressed: onSave),
            const SizedBox(width: 10,),
            // Cancel button
            MyButton(text: 'Cancel', onPressed: onCancel),

            ],
          ),


        ],
      ),
    ),
    );
  }
}