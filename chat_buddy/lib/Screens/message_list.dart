import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Logic/cubit_logic.dart';
import '../Logic/logic_methods.dart';
import '../auxilaries/colors.dart';
import '../notifications/notifications.dart';
import 'chat.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List listofChatUsers = [];
  Map<String, String> userUnreads = {};
  ValueNotifier<Map<String, String>> imagesMap =
      ValueNotifier(<String, String>{});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context
        .read<GetUserDataCubit>()
        .getSnapshotValue(context.read<GetUserName>().state);
    listofChatUsers = getListOfUsersInMessagesList(context);
    context.read<SentMessagesCubit>().emptySentMessages();
    context.read<ReceivedMessagesCubit>().emptyRecievedMessages();
  }

  // navigateToChat() {
  //   Navigator.of(context).push(MaterialPageRoute(builder: ((context) => Chat("hello_1"))));
  // }

  @override
  Widget build(BuildContext context) {
    imagesMap.value = getImagesList(listofChatUsers);
    for (var element in listofChatUsers) {
      userUnreads[element] = '';
    }

    return BlocBuilder<GetUserDataCubit, dynamic>(
      builder: (context, state) {
        listofChatUsers = getListOfUsersInMessagesList(context);
        context
            .read<GetUserDataCubit>()
            .getSnapshotValue(context.read<GetUserName>().state);

        return Scaffold(
            body: listofChatUsers.isEmpty ||
                    context.read<GetUserDataCubit>().state["receivedList"] ==
                        null
                ? Container(
                    decoration: backgroundGradient(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            "click on Search to find a new friend",
                            style: TextStyle(color: colors1[1]),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40.0)),
                      ],
                    ),
                  )
                : Container(
                    decoration: backgroundGradient(),
                    child: ListView(
                      children: List.generate(listofChatUsers.length, (index) {
                        listofChatUsers = getListOfUsersInMessagesList(context);

                        // to get latest sent message time:
                        dynamic Smessages = (context
                                    .read<GetUserDataCubit>()
                                    .state["messagesList"]
                                [listofChatUsers[index]] as dynamic)
                            .keys;
                        List msgSentListKeys = [];
                        Smessages.forEach((element) {
                          msgSentListKeys.add(int.parse(element));
                        });
                        msgSentListKeys.sort();
                        int maxSentTime = msgSentListKeys.last;

                        // to get latest received message time:
                        dynamic Rmessages = (context
                                    .read<GetUserDataCubit>()
                                    .state["receivedList"]
                                [listofChatUsers[index]] as dynamic)
                            ?.keys;

                        List msgReceivedListKeys = [];
                        int maxReceivedTime = 0;
                        if (Rmessages != null) {
                          Rmessages.forEach((element) {
                            msgReceivedListKeys.add(int.parse(element));
                          });
                          msgReceivedListKeys.sort();
                          maxReceivedTime = msgReceivedListKeys.last;
                        }
                        dynamic dateTime;

                        String lastMessage = "";
                        num notReadcount = 0;
                        if (maxSentTime > maxReceivedTime) {
                          lastMessage = context
                                  .read<GetUserDataCubit>()
                                  .state["messagesList"][listofChatUsers[index]]
                              ["$maxSentTime"];
                          dateTime =
                              DateTime.fromMillisecondsSinceEpoch(maxSentTime);
                        } else {
                          lastMessage = context
                                  .read<GetUserDataCubit>()
                                  .state["receivedList"][listofChatUsers[index]]
                              ["$maxReceivedTime"];
                          dateTime = DateTime.fromMillisecondsSinceEpoch(
                              maxReceivedTime);

                          if (context
                                  .read<GetUserDataCubit>()
                                  .state["receivedReadPointers"] !=
                              null) {
                            if (context
                                            .read<GetUserDataCubit>()
                                            .state["receivedReadPointers"]
                                        [listofChatUsers[index]] !=
                                    null &&
                                context
                                            .read<GetUserDataCubit>()
                                            .state["receivedReadPointers"]
                                        [listofChatUsers[index]] <
                                    maxReceivedTime) {
                              notReadcount = msgReceivedListKeys.length -
                                  msgReceivedListKeys.indexOf(context
                                          .read<GetUserDataCubit>()
                                          .state["receivedReadPointers"]
                                      [listofChatUsers[index]]) -
                                  1;

                              //To check if notification is not done, then only show notification
                              if (notReadcount != 0 &&
                                  userUnreads[listofChatUsers[index]] !=
                                      "$maxReceivedTime") {
                                SimpleNotificataion().showNotification(
                                    id: index,
                                    title:
                                        '${listofChatUsers[index]} sent $notReadcount Message${notReadcount == 1 ? '' : 's'}',
                                    body: lastMessage,
                                    payload:
                                        'simple.msg&${DateTime.now().millisecondsSinceEpoch}');
                              }
                              userUnreads[listofChatUsers[index]] =
                                  "$maxReceivedTime"; //to madify userReads, so that notification doesn't repeat
                            }
                          }
                        }
                        return ListTile(
                          leading: ValueListenableBuilder(
                              valueListenable: imagesMap,
                              builder: (context, value, child) {
                                return CircleAvatar(
                                  radius: 30,
                                  foregroundImage: value.isEmpty
                                      ? Image.asset(
                                          'assets/defaultprofile.png',
                                          alignment: Alignment.centerLeft,
                                          fit: BoxFit.contain,
                                        ).image
                                      : value.length <= index
                                          ? Image.asset(
                                              'assets/defaultprofile.png',
                                              alignment: Alignment.centerLeft,
                                              fit: BoxFit.contain,
                                            ).image
                                          : value[listofChatUsers[index]] ==
                                                      null ||
                                                  value[listofChatUsers[
                                                          index]] ==
                                                      ''
                                              ? Image.asset(
                                                  'assets/defaultprofile.png',
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.contain,
                                                ).image
                                              : Image.network(
                                                  value[
                                                      listofChatUsers[index]]!,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  fit: BoxFit.contain,
                                                ).image,
                                );
                              }),
                          trailing: Column(
                            children: [
                              Text(
                                  "${dateTime.day}/${dateTime.month}/${dateTime.year}"),
                              Text("${dateTime.hour} : ${dateTime.minute}"),
                            ],
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(listofChatUsers[index].toString()),
                                  const SizedBox(
                                    width: 30.0,
                                  ),
                                  notReadcount == 0
                                      ? Container()
                                      : CircleAvatar(
                                          radius: 14.0,
                                          backgroundColor: colors1[0],
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text("$notReadcount"),
                                          ),
                                        )
                                ],
                              ),
                              // Text("not read received count: $notReadcount"),
                              // Text("last message: $lastMessage"),
                              // Text("${msgReceivedListKeys.indexOf(context.read<GetUserDataCubit>().state["receivedReadPointers"][listofChatUsers[index]])}"),
                            ],
                          ),
                          subtitle: lastMessage.length > 15
                              ? Text("${lastMessage.substring(0, 15)}..")
                              : Text(lastMessage),
                          onTap: () {
                            // context.read<SentMessagesCubit>().getSentMessagesList(context.read<GetUserName>().state, listofChatUsers[index]);
                            // context.read<ReceivedMessagesCubit>().getSentMessagesList(listofChatUsers[index], context.read<GetUserName>().state);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => Chat(
                                    listofChatUsers[index],
                                    imagesMap.value[listofChatUsers[index]] ??
                                        '')),
                              ),
                            );
                            context
                                .read<SentMessagesCubit>()
                                .getSentMessagesList(
                                    context.read<GetUserName>().state,
                                    listofChatUsers[index]);
                            context
                                .read<ReceivedMessagesCubit>()
                                .getSentMessagesList(listofChatUsers[index],
                                    context.read<GetUserName>().state);
                          },
                        );
                      }),
                    )));
      },
    );
  }

  Map<String, String> getImagesList(List chatUsersList) {
    Map<String, String> imageList = {};
    for (var element in chatUsersList) {
      FirebaseDatabase.instance
          .ref("usersData")
          .child("$element")
          .onValue
          .listen((DatabaseEvent event) {
        imageList[element] = "${(event.snapshot.value as Map)['photoUrl']}";
      });
    }
    return imageList;
  }
}
