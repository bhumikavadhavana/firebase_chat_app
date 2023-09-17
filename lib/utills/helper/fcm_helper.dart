import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper {
  FCMHelper._();

  static final FCMHelper fcmHelper = FCMHelper._();
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();

    return token;
  }
}
