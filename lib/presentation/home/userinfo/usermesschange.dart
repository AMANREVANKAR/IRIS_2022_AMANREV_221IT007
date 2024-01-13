import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:messinfo/bloc/usermesschange_bloc.dart';
import 'package:messinfo/presentation/home/userinfo/userapproval.dart';
import 'package:messinfo/presentation/home/userinfo/userhome.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/data/services/database.dart';
import 'package:messinfo/data/services/notification_services.dart';
import 'package:messinfo/data/services/notificationuserservice.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class messchange extends StatefulWidget {
  var namefromuserhome;

  messchange({this.namefromuserhome});
  @override
  State<messchange> createState() => _messchangestate();
}

class _messchangestate extends State<messchange> {

Future<void> _handlerefresh() async
{
  return await Future.delayed(Duration(seconds: 2));
}

late String notificationstatus;



  bool colors = false;

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<student?>(context);
    return Scaffold(
      
      body:LiquidPullToRefresh (
        onRefresh: _handlerefresh,
        child: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: BlocProvider(
            create: (context) => UsermesschangeBloc(),
            child: BlocBuilder<UsermesschangeBloc,UsermesschangeState>(
                builder: (context,state) {
                  if (state.messInfo.isEmpty) {
                    return Center(child: Text('No Messes Available'));
                  } else {
                    return ListView.builder(
                        itemCount: state.messInfo.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              // height: 120,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  stops: const [
                                    0.003,
                                    0.55,
                                    1,
                                  ],
                                  colors: [
                                    Colors.teal.withOpacity(0.85),
                                    Colors.lightGreen.withOpacity(0.8),
                                    Colors.yellow.withOpacity(0.9)
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                                // border: Border.all(color: Colors.black,width: 2),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                color: Colors.lime,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.messInfo[index].messname!,
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Type:' + state.messInfo[index].type!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'No of seats:' +
                                          state.messInfo[index].noofseats!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'mondays menu:' +
                                          state.messInfo[index].mon!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'tuedays menu:' +
                                         state.messInfo[index].tue!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'wednesdays menu:' +
                                          state.messInfo[index].wed!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'thursdays menu:' +
                                         state.messInfo[index].thur!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'fridays menu:' +
                                          state.messInfo[index].fri!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'saturdays menu:' +
                                          state.messInfo[index].sat!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(18, 0, 0, 5),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'sundays menu:' +
                                          state.messInfo[index].sun!,
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 180,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      color: colors ? Colors.amber : Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    margin: EdgeInsets.only(left: 13, bottom: 15),
                                    child: TextButton(
                                      onPressed: () async {

                                        DataService _checkcount = DataService(
                                            uid: userdata!.emailid.toString());
                         
        
                                        if (await _checkcount.updatecount() ==
                                            false) {

                                          DataService _requestfromuser =
                                              DataService(
                                                  uid: state.messInfo[index].messname!);
        
                                          _requestfromuser.requestuserdata(
                                              state.messInfo[index].emailid!,
                                              state.messInfo[index].messname!,
                                              userdata!.emailid.toString(),
                                              widget.namefromuserhome.toString(),
                                              userdata!.emailid.toString());
                                          _requestfromuser.requesteduserdata(
                                              state.messInfo[index].emailid!,
                                             state.messInfo[index].messname!,
                                              userdata!.emailid.toString(),
                                              widget.namefromuserhome.toString(),
                                              userdata!.emailid.toString()
                                             );

                           final userdocument=await FirebaseFirestore.instance.collection('users').doc(userdata!.emailid).get();
                           notificationfromuser _servicetorequestadmin = notificationfromuser();

                    
                         _servicetorequestadmin.sendNotification(
                              state.messInfo[index].tokenid.toString(),
                              'Request for mess change',
                              userdocument['name']+ ' has applied for '+state.messInfo[index].messname
                              ).then((value) {
                              notificationstatus=value;
                              });
                                  Fluttertoast.showToast(msg: notificationstatus.toString(),
                     toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      
                       backgroundColor: Colors.white,
                      textColor: Colors.black,
                        fontSize: 16.0);
                                          _checkcount.setcount(0);
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                  'Alert!',
                                                  style: TextStyle(fontSize: 20),
                                                ),
                                                content: Text(
                                                    'More than one request can not be made',
                                                    style:
                                                        TextStyle(fontSize: 20)),
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Text(
                                        'request',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
        ),
      ),
    );
  }
}
