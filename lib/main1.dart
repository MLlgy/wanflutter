// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sample for material.AppBar.actions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.red,
      ),
//      home: new MyStatelessWidget(),
      home: new RandomWords(),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text('Hello World'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            tooltip: 'Open shopping cart',
            onPressed: () {},
          ),
        ],
      ),
      body: new Center(
        child: new Text("women"),
//        child: new RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
//    return RandomWordsState();// 一个 Text
    return RandomListState(); // ListView
  }
}

///一个 Text
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return new Text(
      wordPair.asPascalCase,
      style: TextStyle(color: Colors.white),
    );
  }
}

/// ListView
class RandomListState extends State<RandomWords> {
  final _suggestion = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello World"),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.list), onPressed: _pushSavedRouter)
        ],
      ),
      body: _buildWidget(),
    );
  }

  Widget _buildWidget() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return new Divider();
        }
        final index = i ~/ 2;
        if (index >= _suggestion.length) {
          _suggestion.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestion[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final _alreadySaved = _saved.contains(wordPair);
    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  ///路由
  void _pushSavedRouter() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _saved.map((pair) {
        return new ListTile(
            title: new Text(
          pair.asPascalCase,
          style: _biggerFont,
        ));
      });
      final divided =
          ListTile.divideTiles(tiles: titles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Save Data Router"),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}
