import 'package:flutter/material.dart';

import '../../utility/ui_constants.dart';
import '../dashboard_screen/dashboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 0),
            Image.asset("assets/images/Chat1.png"),
            const SizedBox(height: 150),
            Text(
              "Welcome to our \nPandaTalks",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .apply(bodyColor: const Color.fromARGB(255, 255, 255, 255))
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            FittedBox(
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: kImperialOrange,
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 60,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
