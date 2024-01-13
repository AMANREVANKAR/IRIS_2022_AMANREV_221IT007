import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications_empty.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class notificationervices{
  FirebaseMessaging messaging=FirebaseMessaging.instance;

   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

     Future<void> initnofication(BuildContext context)async
     {
//     AwesomeNotifications().initialize(null, [
// NotificationChannel(channelKey: 'amanmessinfo', channelName: 'aman', channelDescription: 'high importance notification')
//     ]);


      
      var androidintializationsettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

      var intializationsetting=InitializationSettings(
        android: androidintializationsettings
      );

      await _flutterLocalNotificationsPlugin.initialize(
        intializationsetting,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse)async{

      });

     }

      
      void firebaseinit(BuildContext context)
      {
        FirebaseMessaging.onMessage.listen((message) {
           initnofication(context);
           shownotification(message);
        
        });

          
      }

   void istokenrefresh()
   {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
   }


Future<void> shownotification(RemoteMessage message)async{

     AndroidNotificationChannel channel=AndroidNotificationChannel(
     Random.secure().nextInt(100000).toString(), 'high importance notification',
      importance: Importance.max);
      
  
      AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        channel.id.toString(),
         channel.name.toString(),
         channelDescription: 'aman',
         importance: Importance.high,
         priority: Priority.high,
         ticker: 'ticker',
         );
         NotificationDetails notificationDetails=NotificationDetails(
          android: androidNotificationDetails,
         );
        Future.delayed(Duration.zero,(){
         print(message.data['body']);
          _flutterLocalNotificationsPlugin.show(
          0, 
        message.notification!.title, 
        message.notification!.body, 
        notificationDetails,
        );
        }
        );
      
     }




  void requetsnotificationpermission()async {
      NotificationSettings settings=await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );

  


      if(settings.authorizationStatus==AuthorizationStatus.authorized)
      {
        print('user granted permission');
      }else
      if(settings.authorizationStatus==AuthorizationStatus.provisional)
      {
        print('user granted provisional services');

      }else{
        
        print('user did not granted permission');
      }

  }

  Future<String?> getdevicetoken()async{

    
    return await messaging.getToken();

  }



}