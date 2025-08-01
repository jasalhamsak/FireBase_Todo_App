import 'package:firebasedemo/Resources/Models/Task_model.dart';
import 'package:firebasedemo/Resources/services/Task_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddTaskVeiw extends StatefulWidget {
  final TaskModel? task;

  const AddTaskVeiw({super.key, this.task});

  @override
  State<AddTaskVeiw> createState() => _AddTaskVeiwState();
}

class _AddTaskVeiwState extends State<AddTaskVeiw> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  TaskService _taskService = TaskService();
  bool _edit = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  loadData() {
    if (widget.task != null) {
      setState(() {
        _titleController.text = widget.task!.title!;
        _descController.text = widget.task!.body!;
        _edit = true;
      });
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  final _taskKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _taskKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _edit
                  ? Text(
                      "Update Task",
                      style: themedata.textTheme.displayMedium,
                    )
                  : Text(
                      "Add Task",
                      style: themedata.textTheme.displayMedium,
                    ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                height: 3,
                color: Colors.teal,
                endIndent: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: themedata.textTheme.displaySmall,
                controller: _titleController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Title is Mandatory";
                  }
                },
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                    hintText: "Enter Task Title",
                    hintStyle: themedata.textTheme.displaySmall,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                style: themedata.textTheme.displaySmall,
                controller: _descController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Description is Mandatory";
                  }
                },
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                    hintText: "Enter Task Description",
                    hintStyle: themedata.textTheme.displaySmall,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (_taskKey.currentState!.validate()) {
                      if (_edit) {
                        TaskModel _taskModel = TaskModel(
                          id: widget.task?.id,
                          title: _titleController.text,
                          body: _descController.text,
                        );
                        _taskService.updateTask(_taskModel).then((value) {
                          Navigator.pop(context);
                        });
                      } else {
                        _addTask();
                      }
                    }
                  },
                  child: Container(
                    width: 250,
                    height: 48,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: _edit
                            ? Text("Update Task",
                                style: themedata.textTheme.displayMedium)
                            : Text("Add Task",
                                style: themedata.textTheme.displayMedium)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _addTask() async {
    var id = Uuid().v1();

    TaskModel _task = TaskModel(
        title: _titleController.text,
        body: _descController.text,
        id: id,
        status: 1,
        taskAt: DateTime.now());

    final task = await _taskService.createTask(_task);

    if (task != null) {
      Navigator.pop(context);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task created")));
    }
  }
}
