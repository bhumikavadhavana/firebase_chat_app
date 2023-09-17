import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter_app/controllers/theme_controller.dart';
import 'package:firebase_flutter_app/utills/helper/firebase_auth_helper.dart';
import 'package:firebase_flutter_app/utills/helper/firebasefirestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utills/globals.dart';

class Chat_page extends StatefulWidget {
  const Chat_page({super.key});

  @override
  State<Chat_page> createState() => _Chat_pageState();
}

class _Chat_pageState extends State<Chat_page> {
  List<String> args = Get.arguments as List<String>;

  TextEditingController sendmessageController = TextEditingController();
  ThemeController themeController = Get.put(ThemeController());

  late Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages;

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:  Text("chat screen"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.video_camera,
              size: 30,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.phone,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: (themeController.darkModeModel.isdark)
                ? const AssetImage(
                    "assets/background/dark.jpg",
                  )
                : const AssetImage(
                    "assets/background/light.jpg",
                  ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 6,
                child: StreamBuilder(
                    stream: allMessages,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("ERROR:${snapshot.error}");
                      } else if (snapshot.hasData) {
                        QuerySnapshot<Map<String, dynamic>> data = snapshot.data
                            as QuerySnapshot<Map<String, dynamic>>;

                        print("================================");
                        print("${data}");
                        print("================================");

                        List<QueryDocumentSnapshot<Map<String, dynamic>>>
                            allDocs = (data == null) ? [] : data.docs;

                        return (allDocs.isEmpty)
                            ? const Center(
                                child: Text("No any message yet.."),
                              )
                            : ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                itemCount: allDocs.length,
                                itemBuilder: (context, i) {
                                  return Row(
                                    mainAxisAlignment:
                                        ((allDocs[i].data()['sentBy']) ==
                                                FirebaseAuthHelper.firebaseAuth
                                                    .currentUser?.uid)
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: ((allDocs[i]
                                                        .data()['sentBy']) ==
                                                    FirebaseAuthHelper
                                                        .firebaseAuth
                                                        .currentUser
                                                        ?.uid)
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: (allDocs[i].data()[
                                                            'timestamp'] ==
                                                        null)
                                                    ? const Text("")
                                                    : Text(allDocs[i]
                                                        .data()['timestamp']
                                                        .toDate()
                                                        .toString()
                                                        .split(" ")[0]),
                                              ),
                                              Chip(
                                                label: Text(
                                                  "${allDocs[i].data()['msg']}",
                                                  style: GoogleFonts.aBeeZee(),
                                                ),
                                                backgroundColor: (allDocs[i]
                                                            .data()['sentBy'] ==
                                                        FirebaseAuthHelper
                                                            .firebaseAuth
                                                            .currentUser
                                                            ?.uid)
                                                    ? Colors.purple
                                                    : Colors.transparent,
                                                elevation: 0,
                                                autofocus: false,
                                              ),
                                              (allDocs[i].data()['timestamp'] ==
                                                      null)
                                                  ? const Text("")
                                                  : Text(
                                                      "${dateTime.hour}:${dateTime.minute} ${"am"}"),
                                              // : Text(
                                              //     "${allDocs[i].data()['timestamp'].toDate().toString().split(" ")[1].toString().split(".")[0]}"),
                                            ],
                                          ),
                                          (allDocs[i].data()['sentBy'] ==
                                                  FirebaseAuthHelper
                                                      .firebaseAuth
                                                      .currentUser
                                                      ?.uid)
                                              ? const Icon(
                                                  Icons.done_all_rounded,
                                                  color: Colors.purpleAccent,
                                                )
                                              : IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.r_mobiledata,
                                                    size: 2,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: sendmessageController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.emoji_emotions,size: 28,),
                            hintText: "Message...",
                            suffixIcon: IconButton(
                              onPressed: () async {
                                FireBaseFireStoreHelper.fireBaseFireStoreHelper
                                    .sendChatMessage(
                                        uid1: args[0],
                                        uid2: args[1],
                                        msg: sendmessageController.text);
                                sendmessageController.clear();
                              },
                              icon: const Icon(Icons.send),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
