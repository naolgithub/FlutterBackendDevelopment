import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  final String userName;
  const GroupPage({
    super.key,
    required this.userName,
  });

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anonymous group',
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Type here...',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.send,
                  color: Colors.teal,
                  size: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
