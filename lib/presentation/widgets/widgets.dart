import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:messinfo/data/services/database.dart';

class presentuserinfo extends StatelessWidget{
  var emailid;
  presentuserinfo({this.emailid});

  @override
  Widget build(BuildContext context) {
    List<String>data=[];

print('hello'+emailid.toString());

       DataService userinfo=DataService();
      userinfo.getData(emailid).then((List<String> value){
             data=value;
      });



   return Container(
    child: Text(data[0]),
   );
  }
    
}

