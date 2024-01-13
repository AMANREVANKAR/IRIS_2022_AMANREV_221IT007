import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:messinfo/models/leaves.dart';
import 'package:messinfo/models/offlineusermodel.dart';
import 'package:messinfo/data/services/notification_services.dart';
import 'presentation/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'data/services/authentication/auth.dart';
import 'models/student.dart';
import 'presentation/screens/listener.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
Future<void> _backgroundmessagehandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('hello');
  print(message.notification!.title.toString());

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //   Random.secure().nextInt(100000).toString(), 'high importance notification',
  //   channelDescription: 'decripition',
  //   // color: Colors.blue.shade800,
  //   importance: Importance.max,
  //   priority: Priority.high,
  //   ticker: 'ticker');

  //         var platformChannelSpecifics = NotificationDetails(
  //   android: androidPlatformChannelSpecifics,
  //  );

  // await flutterLocalNotificationsPlugin.show(msgId, message["data"]["msgTitle"],
  // message["data"]["msgBody"], platformChannelSpecifics,
  // payload: message["data"]["data"]);
  // return Future<void>.value();}

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
   
      var androidintializationsettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

      var intializationsetting=InitializationSettings(
        android: androidintializationsettings
      );

      await _flutterLocalNotificationsPlugin.initialize(
        intializationsetting,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse)async{

      });


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
        message.notification!.title.toString(), 
        message.notification!.body.toString(), 
        notificationDetails,
        );
        }
        );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(offlineusermodelAdapter());
  await Hive.openBox<offlineusermodel>('users');

    Hive.registerAdapter(leaveAdapter());
  await Hive.openBox<leave>('leaves');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_backgroundmessagehandler);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    print('Message data: ${message.data}');
  });


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  
  @override
  void initState()
  {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.data}');
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundmessagehandler);
  }


  @override
  Widget build(BuildContext context) {
    return StreamProvider<student?>.value(
      initialData: null,
      value: Authservice().user,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.lime,
          ),
          useMaterial3: true,
        ),
        home: listener(),
      ),
    );
  }
}



