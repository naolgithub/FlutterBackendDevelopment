import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utility/firebase_constants.dart';
import '../../utility/ui_constants.dart';
import '../../widgets/not_found.dart';
import 'widgets/room_item_widget.dart';

class ForegroundScreen extends StatefulWidget {
  const ForegroundScreen({
    super.key,
    required this.navBarOnPressed,
  });

  final dynamic navBarOnPressed;

  @override
  _ForegroundScreenState createState() => _ForegroundScreenState();
}

class _ForegroundScreenState extends State<ForegroundScreen> {
  final _firestore = FirebaseFirestore.instance;

  bool showProgress = false;

  void showProgressIndicator(bool show) {
    setState(() {
      showProgress = show;
    });
  }

  @override
  Widget build(BuildContext context) {
    final streamBuilder = StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(kRoomCollection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data!.docs.isEmpty) return const NotFoundWidget();

        List<Widget> widgets = [];
        List<DocumentSnapshot> ds = snapshot.data!.docs;

        for (var room in ds) {
          widgets.add(
            RoomItemWidget(
              context: context,
              roomData: room,
              showProgressIndicator: showProgressIndicator,
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            return widgets[index];
          },
        );
      },
    );

    const circularProgressIndicator = Center(
      child: CircularProgressIndicator(),
    );

    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'PandaTalks',
          style: kHeadingTextStyle.copyWith(
            fontSize: 40,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Text(
          'Join a room to continue',
          style: kLightLabelTextStyle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
              ),
            ),
            child: showProgress ? circularProgressIndicator : streamBuilder,
          ),
        ),
      ],
    );

    final foregroundScreen = Container(
      color: kBlack,
      child: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'PandaTalks',
                  style: kHeadingTextStyle.copyWith(
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Join a room to continue',
                  style: kLightLabelTextStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: kBlack,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0.0),
                        topRight: Radius.circular(0.0),
                      ),
                    ),
                    child: showProgress
                        ? circularProgressIndicator
                        : streamBuilder,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.bars,
                  color: kWhite,
                ),
                onPressed: widget.navBarOnPressed,
              ),
            ),
          ],
        ),
      ),
    );

    return foregroundScreen;
  }
}
