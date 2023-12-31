import 'package:flutter/material.dart';
import 'package:multi_player_tictactoe/screens/create_room_screen.dart';
import 'package:multi_player_tictactoe/screens/join_room_screen.dart';
import 'package:multi_player_tictactoe/screens/main_menu_screen.dart';

import 'utils/colors.dart';

void main() {
  //Utils contains repeated functions,
  //colors or global variables.

  //Widgets contains reusable widgets.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi player tictactoe',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
      ),
      routes: {
        MainMenuScreen.routeName: (context) => const MainMenuScreen(),
        JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
        CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
      },
      // home: const MainMenuScreen(),
      initialRoute: MainMenuScreen.routeName,
    );
  }
}
