

import 'package:todo_app/domain/entities/task.dart';


Task task = Task(id: '1', title: 'Test Task', description: '', isCompleted: false,category: 'learn',date: '12-11-2024',time: '10:00 pm');
Task newTask = Task(id: '2', title: 'New Test Task', description: '', isCompleted: false,category: 'learn',date: '12-11-2024',time: '10:00 pm');

Task updatedTask = Task(id: '1', title: 'Updated Test Task', description: '', isCompleted: false,category: 'learn',date: '12-11-2024',time: '10:00 pm');

Task? nullTask = null;

final List<Task> tasks = [task];