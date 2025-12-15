import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Adding extends StatefulWidget {
  const Adding({super.key, this.token});
  final String? token;
  @override
  State<Adding> createState() => _AddingState();
}

class _AddingState extends State<Adding> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Widget createTitleField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter the title of the todo please",
        labelStyle: TextStyle(fontSize: 20),
        hint: Text("Go to the GYM"),
      ),
      controller: titleController,
    );
  }

  Widget createBodyField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter the body of the do to please",
        labelStyle: TextStyle(fontSize: 20),
        hint: Text("To workout for 1 hour and get Shower ............."),
      ),
      controller: bodyController,
    );
  }

  Widget createButton() {
    return ElevatedButton(
      onPressed: () async {
        if (titleController.text.isEmpty || bodyController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Please Enter all the Fields"),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        Map<String, String> map = {
          "title": titleController.text,
          "body": bodyController.text,
        };
        var res = await http.post(
          Uri.parse("http://localhost:8082/basmag_php/adding.php"),
          headers: {
            "Authorization": "Bearer ${widget.token}",
            "Content-Type": "application/json",
          },
          body: jsonEncode(map),
        );
        print(res.body);
        Navigator.pop(context, true);
      },
      child: Text("Save it"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adding page"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          createTitleField(),
          SizedBox(height: 20),
          createBodyField(),
          SizedBox(height: 10),
          createButton(),
        ],
      ),
    );
  }
}
