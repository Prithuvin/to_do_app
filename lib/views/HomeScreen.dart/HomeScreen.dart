import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/controllers/HomeScreenController.dart';

import 'package:to_do_app/views/task_screen/task_screen.dart';
import 'package:to_do_app/views/task_screen/updatetask.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Homescreencontroller.initdb();
      await Homescreencontroller.getTask();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 200,
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.blue,
            onPressed: () {
              bottomsheet(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.add,
                  color: Colors.white,
                ),
                Text(
                  "Add a Task",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.withOpacity(0.1)),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    radius: 25,
                  ),
                  subtitle: Text(
                    "Prithuvin M G",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  title: Text("Hello!"),
                  trailing: Icon(CupertinoIcons.bell_fill),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.blue,
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(text: "Tasks"),
                  Tab(text: "Ongoing"),
                  Tab(text: "Completed"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildTaskList(), // All Tasks
                  buildOngoingList(), // Ongoing Tasks
                  buildCompletedList(), // Completed Tasks
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTaskList() {
    if (Homescreencontroller.taskList.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset(
                'assets/image/no-task-available-illustration_585024-46.jpg'),
            Text(
              "No tasks available",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemBuilder: (context, index) {
        final task = Homescreencontroller.taskList[index];
        final taskName = task["name"] ?? "Unnamed Task";
        final taskDescription =
            task["Description"] ?? "No description available";
        final taskTime = task["time"] ?? "No time specified";

        return buildTaskItem(task, taskName, taskDescription, taskTime);
      },
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: Homescreencontroller.taskList.length,
    );
  }

  Widget buildOngoingList() {
    if (Homescreencontroller.taskList.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset(
                'assets/image/no-task-available-illustration_585024-46.jpg'),
            Text(
              "No ongoing tasks",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        final task = Homescreencontroller.taskList[index];
        final taskName = task["name"] ?? "Unnamed Task";
        final taskDescription =
            task["Description"] ?? "No description available";
        final taskTime = task["time"] ?? "No time specified";

        return buildTaskItem(task, taskName, taskDescription, taskTime);
      },
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: Homescreencontroller.taskList.length,
    );
  }

  Widget buildCompletedList() {
    if (Homescreencontroller.taskList.isEmpty) {
      return Center(
        child: Column(
          children: [
            Image.asset(
                'assets/image/no-task-available-illustration_585024-46.jpg'),
            Text(
              "No completed tasks",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      itemBuilder: (context, index) {
        final task = Homescreencontroller.completedList[index];
        final taskName = task["name"] ?? "Unnamed Task";
        final taskDescription =
            task["Description"] ?? "No description available";
        final taskTime = task["time"] ?? "No time specified";

        return buildTaskItem(task, taskName, taskDescription, taskTime);
      },
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: Homescreencontroller.completedList.length,
    );
  }

  Widget buildTaskItem(task, taskName, taskDescription, taskTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskScreen(
                        task: task,
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      taskName,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    Spacer(),
                    PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      onSelected: (value) async {
                        if (value == 'edit') {
                          final updatedTask =
                              await showDialog<Map<String, String>>(
                            context: context,
                            builder: (context) => UpdateTaskDialog(
                                initialName: taskName,
                                initialDescription: taskDescription,
                                initialTime: taskTime),
                          );

                          if (updatedTask != null) {
                            // Update task in the database
                            await Homescreencontroller.updateTask(
                                task['id'],
                                updatedTask['name']!,
                                updatedTask['description']!,
                                updatedTask['time']!);
                            setState(() {});
                          }
                        } else if (value == 'delete') {
                          // Delete the task
                          await Homescreencontroller.deleteTask(task['id']);
                          setState(() {});
                        } else if (value == 'completed') {
                          await Homescreencontroller.markTaskAsCompleted(
                              task['id']);
                          await Homescreencontroller
                              .getTask(); 
                          setState(() {}); 
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit,
                                  color: Colors.black.withOpacity(0.8)),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete,
                                  color: Colors.black.withOpacity(0.8)),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'completed',
                          child: Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.black.withOpacity(0.8),
                                shadows: [
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 2.0,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              SizedBox(width: 8),
                              Text('Mark as Completed'),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              taskDescription,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(fontSize: 14),
                            ))),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 10),
                      child: Text(taskTime),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> bottomsheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController desController = TextEditingController();
    TextEditingController timeController = TextEditingController();

    Future<void> _selectTime(BuildContext context) async {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        String formattedTime = pickedTime.format(context);
        timeController.text = formattedTime;
      }
    }

    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: "Task Name", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: desController,
                decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.only(bottom: 100, top: 30)),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: timeController,
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                    labelText: "Time", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Add task to database
                  await Homescreencontroller.addTask(
                    taskname: nameController.text,
                    taskdescription: desController.text,
                    taskTime: timeController.text,
                  );
                  Navigator.pop(context);
                  setState(() {});
                },
                child: Text(
                  "Add Task",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
