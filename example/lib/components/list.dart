import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'package:english_words/english_words.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final _randomWordPairs = <WordPair>[];
  final _savedWords = Set<WordPair>();

  // this is where you insert your view
  Widget _buildRow(WordPair pair) {
    final saved = _savedWords.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle(fontSize: 18)),
        trailing: Icon(saved ? Icons.favorite : Icons.favorite_border,
            color: saved ? Colors.red : null),
        onTap: () {
          setState(() {
            if (saved) {
              _savedWords.remove(pair);
            } else {
              _savedWords.add(pair);
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

          if (index >= _randomWordPairs.length) {
            _randomWordPairs.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_randomWordPairs[index]);
        });
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWords.map((WordPair pair) {
        return ListTile(
            title: Text(pair.asPascalCase, style: TextStyle(fontSize: 16)));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
          appBar: AppBar(title: Text('Saved Word Pairs')),
          body: ListView(children: divided));
    }));
  }

  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Task list example app'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
          ],
        ),
        body: _buildList(),
      ),
    );
  }
}
