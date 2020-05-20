import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // 应用名称
      title: 'Flutter Demo',
      // 主题
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      // 注册路由表
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'), // 注册首页路由
        'newRoute': (context) => NewRoute(),
        'tipRoute': (context) => TipRoute(text: ModalRoute.of(context).settings.arguments),
      },
      // 应用首页路由
      // home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _nextPage() {
    //导航到新路由   
    // Navigator.push(context,
    //   MaterialPageRoute(builder: (context) {
    //     return NewRoute();
    //   })
    // );
    Navigator.pushNamed(context, 'newRoute');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            new FlatButton(
              onPressed: _nextPage,
              child: new Text('Open new route'),
              textColor: Colors.blue,
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            // 打开`TipRoute`，并等待返回结果
            // var result = await Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return TipRoute(
            //         // 路由参数
            //         text: "提示提示提示提示提示提示",
            //       );
            //     },
            //   ),
            // );
            var result = await Navigator.pushNamed(context, 'tipRoute', arguments: '你好不好啊?');
            //输出`TipRoute`路由返回结果
            print("路由返回值: $result");
          },
          child: Text("打开提示页"),
        ),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    print(args);

    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(text),
            RaisedButton(
              onPressed: () => Navigator.pop(context, "我是返回值"),
              child: Text("返回"),
            )
          ]
        )
      ),
    );
  }
}
