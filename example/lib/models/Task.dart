import 'dart:io';
import 'package:flutter/material.dart';
import 'package:task_list_example/models/Thread.dart';

import 'package:english_words/english_words.dart';

class Task {
  final String title;

  Task({@required this.title});

  static final List<Thread> threads = [];

  static Future<bool> startTask(String id, int duration) async {
    sleep(Duration(seconds: duration));
    return true;
  }

  static void addTask() async {
    return threads
        .add(new Thread(threadId: DateTime.now().toString(), duration: 5));
  }

  static void removeTask(int id) async {
    threads.removeWhere((item) => item.threadId == id);
  }
}

Iterable<Task> generateTasks() {
  final wordPair = WordPair.random();
  List<Task> tasks = [new Task(title: wordPair.asPascalCase)];
  return tasks;
}
