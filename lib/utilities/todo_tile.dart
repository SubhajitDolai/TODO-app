import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
//--------------------------------------
// VARIABLES
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  // constructors for TodoTile class
  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                if (deleteFunction != null) {
                  deleteFunction!(context);
                }
              },
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12.0),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.black,
                side: const BorderSide(
                  color: Colors.white, // Customize the border color here
                  width: 2, // Set the border width
                ),
              ),

              // Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white,
                  ),
                  overflow:
                      TextOverflow.ellipsis, // Adds "..." if text overflows
                  maxLines: 1, // Limit the text to a single line
                  softWrap:
                      false, // Prevents the text from wrapping to the next line
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
