import './task.dart';

class Plan {
  final String name;
  final List<Task> tasks;

  const Plan({this.name = '', this.tasks = const []});

  int get completedCount => tasks.where((t) => t.complete).length;

  String get completenessMessage {
    if (tasks.isEmpty) {
      return '0 of 0 tasks';
    }
    return '$completedCount of ${tasks.length} tasks';
  }
}


