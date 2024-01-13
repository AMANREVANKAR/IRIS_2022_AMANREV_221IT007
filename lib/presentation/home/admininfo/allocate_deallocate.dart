import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messinfo/data/services/databaseadminservice.dart';

class AllocateReallocate extends StatefulWidget{
  @override
  State<AllocateReallocate> createState() =>_AllocateReallocate();

}


class _AllocateReallocate extends State<AllocateReallocate>{



    Widget build(BuildContext context) {
   

      return  Scaffold(
        appBar: AppBar(backgroundColor: Colors.lightGreen),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: StreamBuilder(
        stream: FirebaseFirestore.instance
                .collection('users')
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
                                    child: Text('Name: '+
                                      requesteddata['name'],
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'currmess: ' + requesteddata['messname'],
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.fromLTRB(150
                                    , 0, 0, 10),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                      
                                         MaterialButton(onPressed: (){
                                          adminservice _updateuserstatus=adminservice();
                                          _updateuserstatus.updateuserinfo(requesteddata['name'],
                                           requesteddata['emailid']);
                                         },
                                        color: Colors.white,
                                        child: Text('deallocate'),)
                                      ],
                                    ),
                                  )
                             
                                ],
                              ),
                            ),
                          );
                        
                      }),
                );
              }
            }),
      ),
    );

    



    }



   
}