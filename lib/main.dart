import 'package:flutter/material.dart';
import 'package:flutter_application_1/Todos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerUser = TextEditingController();

  Widget buildFormForUsername() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter your name please",
        labelStyle: TextStyle(fontSize: 20),

        hint: Text("man123"),
      ),
      textAlign: TextAlign.justify,
      controller: controllerUser,
    );
  }

  Widget buildFormForPassword() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter your password",
        labelStyle: TextStyle(fontSize: 20),

        hint: Text("1234567"),
      ),
      obscureText: true,
      textAlign: TextAlign.justify,
      controller: controllerPassword,
    );
  }

  Widget buildonClickButton() {
    return ElevatedButton(
      onPressed: () async {
        if (controllerPassword.text.isEmpty || controllerUser.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("All fields must be completed"),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }
        Map<String, String> map = Map();
        map["username"] = controllerUser.text;
        map["password"] = controllerPassword.text;

        var res = await http.post(
          Uri.parse("http://localhost:8082/basmag_php/login.php"),
          body: jsonEncode(map),
        );
        var data = jsonDecode(res.body);
        if (data["token"] != null) {
          print(data["token"]);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Todos(token: data["token"],)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("your data is false"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Text("sign in"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login from"), backgroundColor: Colors.blue),
      body: Column(
        children: [
          SizedBox(height: 30),
          buildFormForUsername(),
          SizedBox(height: 30),
          buildFormForPassword(),
          SizedBox(height: 20),
          buildonClickButton(),
        ],
      ),
    );
  }
}
