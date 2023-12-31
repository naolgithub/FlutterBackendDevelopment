import 'package:flutter/material.dart';
import 'package:multi_player_tictactoe/widgets/custom_text.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              shadows: [
                Shadow(
                  blurRadius: 40,
                  color: Colors.blue,
                ),
              ],
              text: 'Create Room',
              fontSize: 70,
            ),
          ],
        ),
      ),
    );
  }
}
