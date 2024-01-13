import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/data/services/database.dart';
import 'package:provider/provider.dart';

class approval extends StatefulWidget {
  @override
  State<approval> createState() => _approvalstate();
}

class _approvalstate extends State<approval> {
  @override
  Widget build(BuildContext context) {
    final approvaluser = Provider.of<student?>(context);
    Widget? _buttonstatus(String messname, String adminemailid) {
      return TextButton(
        onPressed: () async {
          final DocumentReference getdocument = await FirebaseFirestore.instance
              .collection(approvaluser!.emailid.toString())
              .doc('requested')
              .collection('requests')
              .doc(messname);
          await getdocument.delete();
          
          DataService _checkcount =
              DataService(uid: approvaluser!.emailid.toString());
          _checkcount.setcount(1);
          final DocumentReference getdocumentadmin = await FirebaseFirestore
              .instance
              .collection(adminemailid.toString())
              .doc('requested')
              .collection('requests')
              .doc(approvaluser!.emailid.toString()+messname.toString());
          await getdocumentadmin.delete();

          // final DocumentReference getdocumentadmin = await FirebaseFirestore
          //     .instance
          //     .collection(adminemailid.toString())
          //     .doc('requested')
          //     .collection('requests')
          //     .doc(messname);
          // await getdocumentadmin.delete();




        },
        child: Text(
          'Cancel Request',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: StreamBuilder(
        stream: FirebaseFirestore.instance
                .collection(approvaluser!.emailid.toString())
                .doc('requested')
                .collection('requests')
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData){
                return Text('PLease Wait');
              }
              if(snapshot.connectionState==ConnectionState.none){return Text('Check your connection');}else {
                return Center(
                  child: ListView.builder(

                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot requesteddata =
                            snapshot.data.docs[index];
                
                        if (requesteddata['status'].toString() == 'Approved' || requesteddata['status'].toString() == 'Rejected') {
                          String s = requesteddata.id.toString();
                          final updateusermessinfo=FirebaseFirestore.instance.collection('users').doc(approvaluser.emailid.toString());
                          updateusermessinfo.set({
                              'name':requesteddata['name'],
                              'emailid':requesteddata['emailid'],
                              'messname':requesteddata['messname'],
                              'messstatus':true,
                          }

                          );
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                
                                border: Border.all(color: Colors.black, width: 2),
                                color: Colors.lime,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    s,
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Status:' + requesteddata['status'].toString(),
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ),
                              ]),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                                color: Colors.lime,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      requesteddata.id.toString(),
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Status:' + requesteddata['status'],
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    margin: EdgeInsets.only(left: 13, bottom: 15),
                                    child: _buttonstatus(
                                        requesteddata['messname'],
                                        requesteddata['adminemailid']),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                );
              }
            }),
      ),
    );
  }
}
