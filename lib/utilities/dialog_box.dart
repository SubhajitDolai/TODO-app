import 'package:flutter/material.dart';
import 'package:todo_app/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      // container
      content: SizedBox(
        height: 150,
        width: 310,

        // child
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLength: 50,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(24),
                hintText: "Add a new task",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when focused
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),

            // save and cancel button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // save button
                MyButton(text: "Cancel", onPressed: onCancel),

                // cancel button
                MyButton(text: "Save", onPressed: onSave),
              ],
            )
          ],
        ),
      ),
    );
  }
}
