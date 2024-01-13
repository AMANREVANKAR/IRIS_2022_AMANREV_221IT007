
import 'package:firebase_core_dart/firebase_core_dart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:messinfo/screens/adminportal/adminlogin.dart';
import 'package:messinfo/screens/userportal/userlogin.dart';
import 'package:messinfo/screens/userportal/usersignup.dart';
import 'package:messinfo/services/authentication/auth.dart';
import 'package:messinfo/services/notification_services.dart';

class loginscreen extends StatefulWidget{
  @override
  State<loginscreen> createState() =>_loginscreen();
}


class _loginscreen extends State<loginscreen>{

notificationervices ns=notificationervices();

     @override
    void initState() {
      super.initState();
      
     ns.requetsnotificationpermission(); 
    ns.firebaseinit(context);  
     ns.getdevicetoken().then((value) {
   print('device token\n');
   print(value.toString());
     });

    //  FirebaseMessaging.onBackgroundMessage(_backgroundmessagehandler);
    

    }  

    @pragma('vm:entry-point')
 Future<void> _backgroundmessagehandler(RemoteMessage message)async{
 ns.initnofication(context);
    if(message.notification!=null)
    print(message.notification!.body.toString());
  }


  
final Authservice _auth=Authservice();



  
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
           bottom: PreferredSize(
     preferredSize: const Size.fromHeight(4.0),
     child: Container(
        color: Colors.black,
        height: 1.0,
     ),
           ),
          centerTitle: true,
           backgroundColor: Colors.lightGreen,
          title: Text('MessInfo',style:
           TextStyle(fontSize: 27,
          letterSpacing: 2,
          fontWeight: FontWeight.w400,
          color: Colors.black),),
    ),
    body: SafeArea(
      child:Center
        (
        child:Container(
          width:width*0.75,
        height:height*0.3,
        color:Colors.white,
        child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
                   width: 1.4,
          ),
     color:  Colors.lime,
          borderRadius: BorderRadius.circular(18),
                              gradient: LinearGradient(
            stops:const [
             0.003,
             0.55,
              1,
              ],
              colors:[ 
                Colors.teal.withOpacity(0.85),
                  Colors.lightGreen.withOpacity(0.8),
              Colors.lime.withOpacity(0.9)],
           begin: Alignment.bottomLeft,
               end: Alignment.topRight,),
           
        ),
            height: height*0.07,
            width: width*0.6,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const usersignup()),
                );
              },
              child: Text('USER SIGNUP', style: new TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color:  Colors.white,
              border: Border.all(
                    color: Colors.black,
                         width: 1.4,
                  ),
              borderRadius: BorderRadius.circular(18),
            ),
            height: height*0.07,
            width: width*0.6,
            child: TextButton(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const userlogin()),
                );
              },
              child: Text('USER LOGIN', style: new TextStyle(
                fontSize: 18.0,
                color: Colors.black
              ),),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                              gradient: LinearGradient(
            stops:const [
             0.003,
             0.55,
              1,
              ],
              colors:[ 
                Colors.teal.withOpacity(0.85),
                  Colors.lightGreen.withOpacity(0.8),
              Colors.lime.withOpacity(0.9)],
           begin: Alignment.bottomLeft,
               end: Alignment.topRight,),
              border: Border.all(
                color: Colors.black,
                width: 1.4,
              ),
              color:  Colors.lime,
              borderRadius: BorderRadius.circular(18),
            ),
            height: height*0.07,
            width: width*0.6,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => adminlogin()),
                );
              },
              child: Text('ADMIN PORTAL', style: new TextStyle(
                fontSize: 18.0,
                    color: Colors.black,
              ),),
            ),
          ),
        ],
      ),
      ),
        ),
    )
    );

  }
  


}