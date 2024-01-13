import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/data/services/databaseadminservice.dart';
import 'package:provider/provider.dart';

class requestmesspage extends StatefulWidget{
  @override
  State<requestmesspage> createState()=>_requestmesspage();

}

class _requestmesspage extends State<requestmesspage>{
  @override
  Widget build(BuildContext context) {
        final adminuser = Provider.of<student?>(context);

     
    return Scaffold(
      body:SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(adminuser!.emailid.toString()).doc('requested').collection('requests')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) {
                        return Text('PLease Wait');
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentSnapshot usersdata =
                                  snapshot.data.docs[index];
                             if(usersdata['status'].toString()=='Accepted' || usersdata['status'].toString()=='Rejected')
                             {
                                   return Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                             gradient: LinearGradient(
            stops:const [
             0.003,
             0.7,
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
                                    ),
                                    color: Colors.lime,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(18, 10, 0, 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Name:'+
                                          usersdata['name'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(18, 0, 0, 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Appiled for:'+
                                          usersdata['messname'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),

                                      Container(
                                        alignment: Alignment.center,
                                             width: 140,
                                                height: 40,
                                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                  ),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15)),
                                                ),
                                                  child: Text(
                                                    usersdata['status'],
                                                    style: TextStyle(fontSize: 22,color: Colors.black),
                                                  ),
                                      ),
                                    ]
                                  ),
                                ),
                                  );
                             }
         

                              return Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Container(
                                  height: 165,
                                  decoration: BoxDecoration(
                            
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
                                        margin:
                                            EdgeInsets.fromLTRB(18, 10, 0, 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Name:'+
                                          usersdata['name'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(18, 0, 0, 0),
                                        alignment: Alignment.centerLeft,
                                        child: Text('Appiled for:'+
                                          usersdata['messname'].toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(80,10,80,10),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 100,
                                             
                                                decoration: BoxDecoration(
                                                  
                                                  border: Border.all(
                                                    color: Colors.black
                                                  ),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15)),
                                                ),
                                                // margin: EdgeInsets.only(left: 13),
                                                child: TextButton(
                                                  onPressed: () {
                                                  

                                                    adminservice _updatedrequestiinfo=adminservice(adminname:usersdata['messname'],adminemailid: adminuser.emailid  );
                                                   _updatedrequestiinfo.updaterequesteduser(usersdata['name'],usersdata['emailid'],1);
                                                   adminservice _updatedrequestiinfoadmin=adminservice(adminname:usersdata['messname'],adminemailid: adminuser.emailid );
                                                  _updatedrequestiinfoadmin.updaterequestadmin(usersdata['name'], usersdata['emailid'], 1);
                                                  },
                                                  child: Text(
                                                    'Accept',
                                                    style: TextStyle(fontSize: 15,color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                                     SizedBox(
                                                      width: 20,
                                                     ),                     
                                                Container(
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15)),
                                                ),
                                                // margin: EdgeInsets.only(left: 13),
                                                child: TextButton(
                                                  onPressed: () {
                                                      adminservice _updatedrequestiinfo=adminservice(adminname:usersdata['messname'],adminemailid: usersdata['emailid'] );
                                                   _updatedrequestiinfo.updaterequesteduser(usersdata['name'],usersdata['emailid'],0);
                                                    adminservice _updatedrequestiinfoadmin=adminservice(adminname:usersdata['messname'],adminemailid: adminuser.emailid );
                                                  _updatedrequestiinfoadmin.updaterequestadmin(usersdata['name'], usersdata['emailid'], 0);
                                                  },
                                                  child: Text(
                                                    'Reject',
                                                    style: TextStyle(fontSize: 15,color: Colors.white),
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
                              );
                            });
                      }
                    }),
              ),
            ),
         
    );
  }
  
}