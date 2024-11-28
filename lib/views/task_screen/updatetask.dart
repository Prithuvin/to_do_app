import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateTaskDialog extends StatefulWidget {
  final String initialName;
  final String initialDescription;
  final String initialTime; // Add initial time

  UpdateTaskDialog({
    required this.initialName,
    required this.initialDescription,
    required this.initialTime,
  });

  @override
  _UpdateTaskDialogState createState() => _UpdateTaskDialogState();
}

class _UpdateTaskDialogState extends State<UpdateTaskDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _timeController; // Controller for time

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _timeController = TextEditingController(
        text: widget.initialTime); // Initialize with initial time
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _timeController.dispose(); // Dispose of the time controller
    super.dispose();
  }

  // Function to show time picker and update time controller
  Future<void> selectTime(BuildContext context) async {
    // Convert the current time string to TimeOfDay
    final currentTime = TimeOfDay.fromDateTime(
        DateTime.parse("2000-01-01 ${_timeController.text}:00"));

    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: currentTime, // Pass current time as initial time
    );

    if (pickedTime != null) {
      String formattedTime =
          pickedTime.format(context); // Format the time (e.g., 3:00 PM)
      setState(() {
        _timeController.text = formattedTime; // Update the time field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Update Task"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: "Task Name"),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: "Task Description"),
          ),
          // Time field with picker
          TextField(
            controller: _timeController,
            readOnly: true, // Make the field read-only to trigger time picker
            decoration: InputDecoration(
              labelText: "Task Time",
              hintText: "Select Time",
            ),
            onTap: () {
              // Open time picker on tap
              selectTime(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            // Return updated task details including time
            Navigator.of(context).pop({
              "name": _nameController.text,
              "description": _descriptionController.text,
              "time": _timeController.text, // Include time
            });
          },
          child: Text("Save"),
        ),
      ],
    );
  }
}
