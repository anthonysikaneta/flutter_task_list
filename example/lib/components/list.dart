import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:task_list_example/models/Task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _tasks = <Task>[];
  final _savedTasks = Set<Task>();

  // this is where you insert your view
  Widget _buildRow(Task task) {
    final saved = _savedTasks.contains(task);
    return ListTile(
        title: Text(task.title, style: TextStyle(fontSize: 18)),
        trailing: Icon(saved ? Icons.favorite : Icons.favorite_border,
            color: saved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (saved) {
              _savedTasks.remove(task);
            } else {
              _savedTasks.add(task);
            }
          });
        });
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // itemCount: entries.length,
        itemBuilder: (BuildContext context, int item) {
          if (item.isOdd) {
            return Divider();
          }
          final index = item ~/ 2;

          if (index >= _tasks.length) {
            _tasks.addAll(generateTasks());
          }

          return _buildRow(_tasks[index]);
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedTasks.map((Task task) {
        return ListTile(
            title: Text(task.title, style: TextStyle(fontSize: 16)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Saved Tasks')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task list example app'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
