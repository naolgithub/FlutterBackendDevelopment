import 'package:flutter/material.dart';
import 'package:socketio_flutter_group_chat/src/pages/home/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group chat',
      theme: ThemeData(
        dividerColor: Colors.cyanAccent[900],
        hintColor: Colors.cyan,
        cardColor: Colors.greenAccent[900],
        hoverColor: Colors.deepOrangeAccent,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
