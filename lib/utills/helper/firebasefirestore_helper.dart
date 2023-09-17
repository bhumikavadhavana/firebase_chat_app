import 'package:cloud_firestore/cloud_firestore.dart';

mixin DBmixin {
  addUser({required Map<String, dynamic> data});

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers();

  Future<void> deleteUser({required String id});

  Future<void> sendChatMessage(
      {required String uid1, required String uid2, required String msg});

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> displayMessage(
      {required uid1, required uid2});

  deleteMessage({required String id});
}

class FireBaseFireStoreHelper with DBmixin {
  FireBaseFireStoreHelper._();

  static final FireBaseFireStoreHelper fireBaseFireStoreHelper =
      FireBaseFireStoreHelper._();

  static final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future addUser({required Map<String, dynamic> data}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firebaseFirestore.collection("records").doc("users").get();

    Map<String, dynamic>? fetchedData = documentSnapshot.data();

    int Id = (fetchedData == null) ? 0 : fetchedData['id'];
    int Length = (fetchedData == null) ? 0 : fetchedData['length'];

    //TODO: check a user already exists or not
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseFirestore.collection("users").get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
        querySnapshot.docs;

    bool isUserAlreadyExists = false;

    for (QueryDocumentSnapshot<Map<String, dynamic>> element in allDocs) {
      if (data['uid'] == element.data()['uid']) {
        isUserAlreadyExists = true;
        break;
      } else {
        isUserAlreadyExists = false;
        break;
      }
    }
    if (isUserAlreadyExists == false) {
      await firebaseFirestore.collection("users").doc("${++Id}").set(data);

      await firebaseFirestore
          .collection("records")
          .doc("users")
          .update({"id": Id, "length": ++Length});
    }
  }

  //   await firebaseFirestore.collection("users").doc("${++Id}").set(data);
  //
  //   await firebaseFirestore
  //       .collection("records")
  //       .doc("users")
  //       .update({"id": Id, "length": ++Length});
  // }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() {
    return firebaseFirestore.collection("users").snapshots();
  }

  @override
  Future<void> deleteUser({required String id}) async {
    await firebaseFirestore.collection("users").doc(id).delete();
  }

  // @override
  // Future<void> sendMessage(
  //     {required uid1, required uid2, required String msg}) async {
  //   //TODO : check if a chatroom exists or not
  //   String user1 = uid1;
  //   String user2 = uid2;
  //
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await firebaseFirestore.collection("chat").get();
  //
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
  //       querySnapshot.docs;
  //
  //   bool isChatRoomIsAvailable = false;
  //   // String? docId;
  //   String fetchedUser1 = "";
  //   String fetchedUser2 = "";
  //
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> element in allDocs) {
  //     String u1 = element.id.split("_")[0];
  //     String u2 = element.id.split("_")[1];
  //
  //     // print("==========================");
  //     // print(allDocs.length);
  //     // print(u1);
  //     // print(u2);
  //     // print("==========================");
  //
  //     if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
  //       isChatRoomIsAvailable = true;
  //       fetchedUser1 = element.data()['users'][0];
  //       fetchedUser2 = element.data()['users'][1];
  //
  //       // docId = element.id;
  //       print("=======================================");
  //       print("=======================================");
  //       // break;
  //     }
  //   }
  //
  //   if (isChatRoomIsAvailable == false) {
  //     await firebaseFirestore.collection("chat").doc("${uid1}_${uid2}").set({
  //       "users": [uid1, uid2],
  //     });
  //
  //     await firebaseFirestore
  //         .collection("chat")
  //         .doc("${fetchedUser1}_${fetchedUser2}")
  //         .collection("messages")
  //         .add({
  //       "msg": msg,
  //       "timestamp": FieldValue.serverTimestamp(),
  //       "sentBy": uid1,
  //       "receivedBy": uid2,
  //     });
  //   } else {
  //     await firebaseFirestore
  //         .collection("chat")
  //         .doc("${fetchedUser1}_${fetchedUser2}")
  //         .collection("messages")
  //         .add({
  //       "msg": msg,
  //       "timestamp": FieldValue.serverTimestamp(),
  //       "sentBy": uid1,
  //       "receivedBy": uid2,
  //     });
  //   }
  // }

  // @override
  // Future<QuerySnapshot<Map<String, dynamic>>> displayMessage(
  //     {required uid1, required uid2}) async {
  //   //TODO : check if a chatroom exists or not
  //   String user1 = uid1;
  //   String user2 = uid2;
  //
  //   QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await firebaseFirestore.collection("chat").get();
  //
  //   List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
  //       querySnapshot.docs;
  //
  //   bool isChatRoomIsAvailable = false;
  //   String fetchedUser1 = "";
  //   String fetchedUser2 = "";
  //
  //   for (QueryDocumentSnapshot<Map<String, dynamic>> element in allDocs) {
  //     String u1 = element.id.split("_")[0];
  //     String u2 = element.id.split("_")[1];
  //
  //     if ((user1 == u1 || user1 == u2) && (user2 == u1 || user2 == u2)) {
  //       isChatRoomIsAvailable = true;
  //       fetchedUser1 = element.data()['users'][0];
  //       fetchedUser2 = element.data()['users'][1];
  //     }
  //   }
  //
  //   if (isChatRoomIsAvailable == false) {
  //     print("========CHATROOM IS NOT AVAILABLE==============");
  //     print("===============================");
  //     return firebaseFirestore
  //         .collection("chat")
  //         .doc("${fetchedUser1}_${fetchedUser2}")
  //         .collection("messages")
  //         .orderBy("timestamp", descending: true)
  //         .get();
  //   } else {
  //     print("========CHATROOM IS AVAILABLE==============");
  //     print("===============================");
  //     return firebaseFirestore
  //         .collection("chat")
  //         .doc("${fetchedUser1}_${fetchedUser2}")
  //         .collection("messages")
  //         .orderBy("timestamp", descending: true)
  //         .get();
  //   }
  // }

  Future<void> createChatDoc(
      {required String uid1, required String uid2}) async {
    String chatDocId = "${uid1}_$uid2";
    String reverseChatId = "${uid2}_$uid1";
    bool isChatExists = false;
    String? chatId;

    QuerySnapshot<Map<String, dynamic>> chatDocs =
        await firebaseFirestore.collection("chat").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocList =
        chatDocs.docs;

    for (var element in chatDocList) {
      if (element.id == chatDocId || element.id == reverseChatId) {
        isChatExists = true;
        chatId = element.id;
        break;
      }
    }

    if (isChatExists == false) {
      await firebaseFirestore.collection("chat").doc("${uid1}_$uid2").set({
        "users": [uid1, uid2],
      });
    }
  }

  @override
  Future<void> sendChatMessage(
      {required String uid1, required String uid2, required String msg}) async {
    String chatDocId = "${uid1}_$uid2";
    String reverseChatId = "${uid2}_$uid1";
    String? chatId;

    QuerySnapshot<Map<String, dynamic>> chatDocs =
        await firebaseFirestore.collection("chat").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocList =
        chatDocs.docs;

    for (var element in chatDocList) {
      if (element.id == chatDocId || element.id == reverseChatId) {
        chatId = element.id;
        break;
      }
    }

    await firebaseFirestore
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .add({
      "msg": msg,
      "timestamp": FieldValue.serverTimestamp(),
      "sentBy": uid1,
      "receivedBy": uid2,
    });
  }

  @override
  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> displayMessage(
      {required uid1, required uid2}) async {
    await createChatDoc(uid1: uid1, uid2: uid2);

    String chatDocId = "${uid1}_$uid2";
    String reverseChatId = "${uid2}_$uid1";
    String? chatId;

    QuerySnapshot<Map<String, dynamic>> chatDocs =
        await firebaseFirestore.collection("chat").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatDocList =
        chatDocs.docs;

    for (var element in chatDocList) {
      if (element.id == chatDocId || element.id == reverseChatId) {
        chatId = element.id;
        break;
      }
    }

    return firebaseFirestore
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  @override
  Future deleteMessage({required String id}) async {
    await firebaseFirestore
        .collection("chat")
        .doc(id)
        .collection("messages")
        .doc(id)
        .delete();
  }
}
