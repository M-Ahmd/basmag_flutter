import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/adding.dart';
import 'package:http/http.dart' as http;

class Todos extends StatefulWidget {
  const Todos({super.key, this.token});
  final String? token;
  @override
  State<Todos> createState() => _TodosState();
}

class _TodosState extends State<Todos> {
  List<dynamic> todos = [];
  void getTodos() async {
    print("goes there");
    var res = await http.get(
      Uri.parse("http://localhost:8082/basmag_php/list.php"),
      headers: {
        "Authorization": "Bearer ${widget.token}",
        "Content-Type": "application/json",
      },
    );
    if (res.statusCode == 200) {
      setState(() {
        todos = jsonDecode(res.body);
      });
    } else {
      print("Error: ${res.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.token.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Adding(token: widget.token),
            ),
          );
          if (res) {
            getTodos();
          }
        },
        child: Icon(Icons.add, color: Colors.blue),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final lastTodo = todos[index];
          return ListTile(
            title: Text(lastTodo['title'].toString()),
            onTap: () => {},
          );
        },
      ),
    );
  }
}
