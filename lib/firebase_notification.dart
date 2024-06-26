import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_water_meter/main.dart';
import 'package:smart_water_meter/pages/notifications_page.dart';


class FirebaseNotification{
  final _firebaseMessaging=FirebaseMessaging.instance;


   Future<void> initNotification() async{
      await _firebaseMessaging.requestPermission();
      final fCMToken= await _firebaseMessaging.getToken();
      print('Token $fCMToken');

     initPushNotifications();
   }

  Future<void> handleBackgroundMessages(RemoteMessage message) async {
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      print('Data: ${message.data}');

  }

   void handleMessage(RemoteMessage? message)  {
      if(message==null)
      return;

      navigatorKey.currentState?.pushNamed(
        NotificationPage.route,
        arguments: message
        );
   }

Future initPushNotifications() async{
FirebaseMessaging.instance
.setForegroundNotificationPresentationOptions(
  alert: true,
  badge: true,
  sound: true,
);

FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

}

}