
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/controllers/HomeScreenController.dart';

Future<dynamic> Showmodalbottomsheet(BuildContext context, TextEditingController nameController, TextEditingController desController, TextEditingController timeController, Future<void> _selectTime(BuildContext context)) {
  return showModalBottomSheet(
  context: context,
  builder: (context) => Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Add a Task",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Task name",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Task Name",
              labelText: "Name",
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              border: OutlineInputBorder()),
          controller: nameController,
        ),
        SizedBox(
          height: 30,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Task description",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          decoration: InputDecoration(
              hintText: "Task Description",
              labelText: "Description",
              labelStyle: TextStyle(fontSize: 12, color: Colors.black),
              border: OutlineInputBorder()),
          controller: desController,
        ),
        SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Task time",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: timeController,
          readOnly: true, //read-only 
          decoration: InputDecoration(
            hintText: "Select Time",
            labelText: "Time",
            labelStyle: TextStyle(fontSize: 12, color: Colors.black),
            border: OutlineInputBorder(),
          ),
          onTap: () {
            
            _selectTime(context);
          },
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  onPressed: () async {
                 
                    await Homescreencontroller.addTask(
                      taskname: nameController.text,
                      taskdescription: desController.text,
                      taskTime: timeController.text,
                    );

                    Navigator.pop(context, true);
                  },
                  child: Text("Add"),
                ),
              ),
            ),
          ],
        )
      ],
    ),
  ),
);
}
