import 'package:flutter/material.dart';
import 'package:socketio_flutter_group_chat/src/pages/group/group_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Group Chat App',
          style: TextStyle(
            color: Colors.teal,
            fontSize: 20,
          ),
        ),
      ),
      body: TextButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Please enter your name'),
            content: Form(
              key: formKey,
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.length < 3) {
                    return "User must have a proper name";
                  }
                  return null;
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  nameController.clear();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    String userName = nameController.text;
                    nameController.clear();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => GroupPage(
                          userName: userName,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Enter',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            'Initial group chat',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
