import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter_app/controllers/theme_controller.dart';
import 'package:firebase_flutter_app/utills/globals.dart';
import 'package:firebase_flutter_app/utills/helper/fcm_helper.dart';
import 'package:firebase_flutter_app/utills/helper/firebase_auth_helper.dart';
import 'package:firebase_flutter_app/utills/helper/firebasefirestore_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  String? name;
  String? age;

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  GlobalKey<FormState> adduserformkey = GlobalKey<FormState>();

  // User? user = ModalRoute.of(context)!.settings.arguments as User?;

  User? user = Get.arguments as User;

  ThemeController themeController = Get.put(ThemeController());

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      drawer: GetBuilder<ThemeController>(
        builder: (_) {
          return Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 70,
                ),
                CircleAvatar(
                  radius: 60,
                  foregroundImage: (user!.isAnonymous)
                      ? const AssetImage("assets/images/user.png")
                          as ImageProvider
                      : NetworkImage("${user!.photoURL}"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                // (user!.isAnonymous)
                //     ? const Text("")
                //     : (user.displayName == null)
                //         ? const Text("")
                //         : Text("${user.displayName}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((user!.isAnonymous)
                        ? ""
                        : (user?.displayName == null)
                            ? ""
                            : "Name: "),
                    // const Text("Name :"),
                    Text(
                      (user!.isAnonymous)
                          ? ""
                          : (user?.displayName == null)
                              ? ""
                              : FirebaseAuthHelper
                                  .firebaseAuth.currentUser?.email
                                  ?.split('@')[0] as String,
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((user!.isAnonymous) ? "" : "E-mail: "),
                    Text((user!.isAnonymous) ? "" : "${user!.email}")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text((user!.isAnonymous)
                        ? ""
                        : (user?.displayName == null)
                            ? ""
                            : "PhoneNumber:  "),
                    Text((user!.isAnonymous)
                        ? ""
                        : (user?.phoneNumber == null)
                            ? ""
                            : "${user!.phoneNumber}"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                (user!.isAnonymous)
                    ? const ListTile()
                    : ListTile(
                        onTap: () {
                          Get.toNamed('/update_emailpage');
                        },
                        title: const Text(
                          "Update E-mail",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.email_outlined),
                      ),
                (user!.isAnonymous)
                    ? const ListTile()
                    : ListTile(
                        onTap: () {
                          Get.toNamed('/update_passwordpage');
                        },
                        title: const Text(
                          "Update Password",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.password),
                      ),
                (user!.isAnonymous)
                    ? const ListTile()
                    : ListTile(
                        onTap: () {
                          Get.toNamed('/delete_accountpage');
                        },
                        title: const Text(
                          "Delete Account",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(Icons.delete),
                      ),
                ListTile(
                  title: const Text(
                    "Theme Mode",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  trailing: Switch(
                    value: themeController.darkModeModel.isdark,
                    onChanged: (val) {
                      setState(() {
                        themeController.darkThemeUDF(val: val);
                      });
                      // Get.changeTheme(Get.isDarkMode
                      //     ? ThemeData.light()
                      //     : ThemeData.dark());
                      print("2");
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      appBar: AppBar(
          title: const Text("HomePage"),
          // leading: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(FirebaseAuthHelper.firebaseAuth.currentUser?.email
          //       ?.split('@')[0] as String),
          // ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuthHelper.firebaseAuthHelper.signOut();

                Get.offNamed('/login_page');
              },
              icon: const Icon(CupertinoIcons.power),
            ),
          ]),
      body: StreamBuilder(
        stream: FireBaseFireStoreHelper.fireBaseFireStoreHelper.fetchAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("ERROR: ${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>> data =
                snapshot.data as QuerySnapshot<Map<String, dynamic>>;

            // List allDocs = (data == null) ? [] : data.docs;
            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                data.docs;

            Set<String> uniqueset = {};

            List<QueryDocumentSnapshot<Map<String, dynamic>>> uniqueList =
                allDocs.where((e) => uniqueset.add(e.data()['uid'])).toList();

            List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];

            for (int i = 0; i < uniqueList.length; i++) {
              if (user!.uid != uniqueList[i].data()['uid']) {
                documents.add(uniqueList[i]);
              }
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: documents.length,
                itemBuilder: (context, i) {
                  return (documents[i]['uid'] ==
                          FirebaseAuthHelper.firebaseAuth.currentUser?.uid)
                      ? Container()
                      : ListTile(
                          onLongPress: () async {
                            //for delete user
                            await FireBaseFireStoreHelper
                                .fireBaseFireStoreHelper
                                .deleteUser(id: documents[i].id);
                          },
                          onTap: () async {
                            allMessages = await FireBaseFireStoreHelper
                                .fireBaseFireStoreHelper
                                .displayMessage(
                                    uid1: FirebaseAuthHelper
                                        .firebaseAuth.currentUser?.uid,
                                    uid2: documents[i]['uid']);
                            Get.toNamed('/chat_page', arguments: <String>[
                              FirebaseAuthHelper.firebaseAuth.currentUser!.uid,
                              documents[i]['uid'],
                              // Globals.u1 = FirebaseAuthHelper
                              //     .firebaseAuth.currentUser!.uid,
                              // Globals.u2 = allDocs[i]['uid'],
                            ]);
                          },
                          // leading: Text(documents[i].id),
                          leading: Text("${i + 1}"),
                          title: Text(
                            "${documents[i]['email']}",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            documents[i]['email'].toString().split("@")[0],
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          // subtitle: Text("Uid: ${documents[i]['uid']}"),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.navigate_next),
                          ),
                          // trailing: IconButton(
                          //   onPressed: () async {
                          //     await FireBaseFireStoreHelper
                          //         .fireBaseFireStoreHelper
                          //         .deleteUser(id: documents[i].id);
                          //   },
                          //   icon: const Icon(
                          //     CupertinoIcons.delete,
                          //   ),
                          // ),
                        );
                });
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  insertUser() {
    Get.dialog(
      AlertDialog(
        title: const Center(
          child: Text("Add User"),
        ),
        content: Form(
          key: adduserformkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                validator: (val) {
                  return (val!.isEmpty) ? "Please enter name.." : null;
                },
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: ageController,
                validator: (val) {
                  return (val!.isEmpty) ? "Please enter age.." : null;
                },
                decoration: const InputDecoration(
                  hintText: "Age",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (adduserformkey.currentState!.validate()) {
                adduserformkey.currentState!.save();

                Get.back();

                String? token = await FCMHelper.fcmHelper.getDeviceToken();

                // FireBaseFireStoreHelper.fireBaseFireStoreHelper.addUser(
                //   data: {
                //     "name": nameController.text,
                //     "age": ageController.text,
                //     "token": token,
                //     "uid": FirebaseAuthHelper.firebaseAuth.currentUser?.uid,
                //   },
                // );

                Get.showSnackbar(
                  const GetSnackBar(
                    message: "SUCCESSFULLY ADD USER",
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                nameController.clear();
                ageController.clear();
              }
            },
            child: const Text("ADD USER"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              nameController.clear();
              ageController.clear();
            },
            child: const Text("CANCEL"),
          ),
        ],
      ),
    );
  }
}
