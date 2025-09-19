import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nex_common_api/api_core/api_methods.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApiMethods Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiMethods apiMethods = ApiMethods();

  String _displayText = '';

  void _getData() async {
    try {
      var response = await apiMethods.getMethod(
        url: 'https://jsonplaceholder.typicode.com/posts/1',
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      setState(() {
        print("Here is post Get: ${response.$2}");
        print("Here is post type: ${response.$2.runtimeType}");
        _displayText = response.toString();
      });
    } catch (e) {
      setState(() {
        _displayText = 'Error: $e';
        print("Here is post data: ${e}");
      });
    }
  }

  void _postData() async {
    try {
      var response = await apiMethods.postMethod(
        url: 'https://jsonplaceholder.typicode.com/posts',
        body: jsonEncode({'title': 'foo', 'body': 'bar', 'userId': 1}),
      );

      setState(() {
        print("Here is post data: ${response}");
        _displayText = response.toString();
      });
    } catch (e) {
      setState(() {
        _displayText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ApiMethods Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getData,
              child: Text('GET Data'),
            ),
            ElevatedButton(
              onPressed: _postData,
              child: Text('POST Data'),
            ),
            SizedBox(height: 20),
            Text(
              'Response:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    _displayText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
