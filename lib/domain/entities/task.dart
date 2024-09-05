import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/*
class Task extends Equatable {
  final String id; // Unique identifier for the task
  final String title; // Title of the task
  final String? description; // Optional description of the task
  final bool isCompleted; // Indicates if the task is completed
  final DateTime? dueDate; // Optional due date for the task
  final DateTime createdAt; // Timestamp when the task was created
  final DateTime updatedAt; // Timestamp for the last update

  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}*/


// Example of Task model
class Task {
  final String? id;
  final String title;
  final String description;
  final bool  isCompleted; // Indicates if the task is completed
  final String date; // Optional due date for the task
  final String time; // Optional due date for the task
  final String category; // Optional due date for the task

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.category,
    required this.date,
    required this.time,
  });

  factory Task.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    print(data['isCompleted']);
    bool isCompleted= false;
    if(data['isCompleted']!=null&&(data['isCompleted']==true||data['isCompleted']==false)){
      isCompleted = data['isCompleted'];
    }
    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      date: data['date'] ?? '',
      time: data['time'] ?? '',
      isCompleted: isCompleted,
    );
  }

  // Convert Task object to a Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'isCompleted': isCompleted,
      'date': date,
      'time': time
    };
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    String? date,
    String? time,
    String? category,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
    );
  }



}
