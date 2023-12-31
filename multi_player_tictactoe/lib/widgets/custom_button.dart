import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  //VoidCallBack==Function() but does
  //not return anything(void)
  final VoidCallback onTap;
  final String text;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Colors.cyan,
        //     Colors.teal,
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        // ),
        boxShadow: [
          BoxShadow(
            //color:Colors.blue,
            color: Colors.black,
            blurRadius: 5,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(
            width,
            50,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
