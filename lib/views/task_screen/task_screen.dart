// import 'package:flutter/material.dart';
// import 'package:to_do_app/controllers/HomeScreenController.dart';

// class TaskScreen extends StatefulWidget {
//   const TaskScreen({super.key});

//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   @override
//   Widget build(BuildContext context) {
//     @override
//     void initState() {
//       WidgetsBinding.instance.addPostFrameCallback(
//         (timeStamp) async {
//           Homescreencontroller.getTask();
//           setState(() {});
//         },
//       );
//       super.initState();
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Tasks",
//           style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/controllers/HomeScreenController.dart';
import 'package:to_do_app/views/task_screen/updatetask.dart';

class TaskScreen extends StatefulWidget {
  final Map<String, dynamic> task;

  const TaskScreen({required this.task, Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    final String taskName = widget.task["name"] ?? "Unnamed Task";
    final String taskDescription =
        widget.task["Description"] ?? "No description available";
    final String taskTime = widget.task["time"] ?? "No time specified";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Details",
          style: TextStyle(fontSize: 20),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (value) async {
              if (value == 'edit') {
                final updatedTask = await showDialog<Map<String, String>>(
                  context: context,
                  builder: (context) => UpdateTaskDialog(
                    initialName: taskName,
                    initialDescription: taskDescription,
                    initialTime: taskTime,
                  ),
                );

                if (updatedTask != null) {
                  // Update task in database
                  await Homescreencontroller.updateTask(
                    widget.task['id'],
                    updatedTask['name']!,
                    updatedTask['description']!,
                    updatedTask['time']!,
                  );
                  Navigator.pop(context); // Close TaskScreen
                }
              } else if (value == 'delete') {
                // Delete the task
                await Homescreencontroller.deleteTask(widget.task['id']);
                Navigator.pop(context); // Close TaskScreen
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black.withOpacity(0.8)),
                    SizedBox(width: 8),
                    Text("Edit"),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.black.withOpacity(0.8)),
                    SizedBox(width: 8),
                    Text("Delete"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              taskName,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(height: 20),
            Text(
              taskDescription,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  taskTime,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
