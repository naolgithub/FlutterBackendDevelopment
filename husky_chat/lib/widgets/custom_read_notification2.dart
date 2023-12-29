import 'package:flutter/material.dart';

import '../helper/colors.dart';
import 'custom_button.dart';

/// This class represents a custom follow notification button which contains a circle avatar and a custom button
/// which changes its appearance depending on whether it has been read or not.
///
/// The custom button changes its background color and text color when it is clicked to indicate that it has been read.
/// This class extends [StatefulWidget] because its state changes when the button is clicked.
///
/// The class consists of two widgets - a circle avatar and a custom button. The avatar displays an image and the name
/// of the user who sent the notification. The custom button is used to mark the notification as read.
///
/// To use this widget, simply create an instance of [CustomFollowNotifcation] and add it to your widget tree.
class CustomReadNotifcation extends StatefulWidget {
  const CustomReadNotifcation({Key? key}) : super(key: key);

  @override
  State<CustomReadNotifcation> createState() => _CustomReadNotifcationState();
}

/// Build up the class for the custom follow notification state
class _CustomReadNotifcationState extends State<CustomReadNotifcation> {
  /// A boolean value for whether the notification has been read or not
  bool read = false;

  /// Build the state of the custom follow notification
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage("assets/Avatar2.png"),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "YUHANTEST",
              style: Theme.of(context)
                  .textTheme
                  // .headline3!
                  .headlineSmall,
              // .copyWith(color: mainText),
            ),
            const SizedBox(
              height: 5,
            ),
            Text("send you new message  .  1h",
                style: Theme.of(context).textTheme.bodySmall
                // .subtitle1!
                // .copyWith(color: SecondaryText),
                ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: read == false ? 30 : 30),
            child: CustomButton(
              height: 40,
              color: read == false ? primary : form,
              textColor: read == false ? Colors.white : mainText,
              onTap: () {
                setState(() {
                  read = !read;
                });
              },
              text: "Read",
            ),
          ),
        ),
      ],
    );
  }
}
