import 'package:sqflite/sqflite.dart';

class Homescreencontroller {
  static late Database TaskDatabase;
  // static List<Map> Tasklist = [];
  static List<Map<String, dynamic>> taskList = []; // All tasks
  static List<Map<String, dynamic>> ongoingList = []; // Ongoing tasks
  static List<Map<String, dynamic>> completedList = []; // Completed tasks

  static Future<void> initdb() async {
    TaskDatabase = await openDatabase("task21.db", version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE TasksToDo (id INTEGER PRIMARY KEY, name TEXT, Description TEXT, time TEXT, status TEXT DEFAULT "pending")');
    });
  }

  static Future<void> addTask({
    required String taskname,
    required String taskdescription,
    required String taskTime,
  }) async {
    await TaskDatabase.rawInsert(
      'INSERT INTO TasksToDo(name, Description, time, status) VALUES(?, ?, ?, "pending")',
      [taskname, taskdescription, taskTime],
    );
    await getTask();
  }

  static Future<void> getTask() async {
    taskList = await TaskDatabase.rawQuery('SELECT * FROM TasksToDo');
    print(taskList);
    await refreshTaskLists();
    print("Pending Tasks: $taskList");
    print("Completed Tasks: $completedList");
  }

  static Future<void> deleteTask(int id) async {
    await TaskDatabase.rawDelete('DELETE FROM TasksToDo WHERE id = ?', [id]);
    await getTask();
  }

  static Future<void> updateTask(
    int id,
    String newName,
    String newDescription,
    String newTime,
  ) async {
    await TaskDatabase.update(
      'TasksToDo',
      {
        'name': newName,
        'Description': newDescription,
        'time': newTime,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
    await getTask();
  }

  static Future<void> markTaskAsCompleted(int taskId) async {
    // Update the task status to 'completed' in the database
    await TaskDatabase.rawUpdate(
      'UPDATE TasksToDo SET status = "completed" WHERE id = ?',
      [taskId],
    );

    // Refresh task lists
    await refreshTaskLists();
  }

  static Future<void> refreshTaskLists() async {
    // Fetch pending tasks
    taskList = await TaskDatabase.rawQuery(
      'SELECT * FROM TasksToDo WHERE status = "pending"',
    );

    // Fetch completed tasks
    completedList = await TaskDatabase.rawQuery(
      'SELECT * FROM TasksToDo WHERE status = "completed"',
    );
  }

  static Future<List<Map>> getCompletedTasks() async {
    return await TaskDatabase.rawQuery(
        'SELECT * FROM TasksToDo WHERE status = "completed"');
  }
}
