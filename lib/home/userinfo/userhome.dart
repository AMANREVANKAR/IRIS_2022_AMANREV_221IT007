import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:messinfo/home/userinfo/registermess.dart';
import 'package:messinfo/home/userinfo/topup.dart';
import 'package:messinfo/home/userinfo/usermesschange.dart';
import 'package:messinfo/home/userinfo/usersmesinfo.dart';
import 'package:messinfo/home/userinfo/usersuggestion.dart';
import 'package:messinfo/models/leaves.dart';
import 'package:messinfo/models/leaves.dart';
import 'package:messinfo/models/offlineusermodel.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/services/Hiveservices/boxes.dart';
import 'package:messinfo/services/authentication/auth.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:messinfo/services/balancecalculation.dart';
import 'package:messinfo/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../models/leaves.dart';


class userhome extends StatefulWidget{
  
  @override
  State<userhome> createState()=>_userhome();
}



class _userhome extends State<userhome>{
  
String? messname;
       
TextEditingController mess=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
        
    
double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<leave> leaveinfo=[];
    var leavesbox=boxes.getDataofleaves();
     for (var i = 0; i < leavesbox.length; i++) {
    var data = leavesbox.getAt(i) as leave;
    leaveinfo.add(data);
  }


   calculateleaves _leave=calculateleaves();
   _leave.noofdays(leaveinfo);


    final userhome = Provider.of<student?>(context);





   Future takedates(String emailid) => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // insetPadding: EdgeInsets.fromLTRB(50,0,50,450),
            content: Builder(builder: (context) {
               TextEditingController pickedDateto = TextEditingController();
  TextEditingController pickedDatefrom = TextEditingController();
          DateTime? pickedDate1;
          DateTime? pickedDate2;
         
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return SingleChildScrollView(
                child: Form(

                  child: Container(
                    height: height - 700,
                    width: width - 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(
                            'Set dates',
                            style: TextStyle(fontSize: 22),
                          ),
                          TextFormField(
                           onTap: ()async{
    pickedDate1 = await showDatePicker(
    context: context,
    lastDate: DateTime(2025),
    firstDate: DateTime.now(),
    initialDate: DateTime.now(),
  );
 if (pickedDate1 == null) return;
  pickedDatefrom.text = DateFormat('dd-MM-yyyy').format(pickedDate1!);
                           },
                            controller: pickedDatefrom,
                               readOnly: true,
                            //  keyboardType: TextInputType.datetime,
                             validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter date'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'From',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                          onTap: ()async{
    pickedDate2 = await showDatePicker(
    context: context,
    lastDate: DateTime(2025),
    firstDate: DateTime.now(),
    initialDate: DateTime.now(),
  );
 if (pickedDate2 == null) return;
  pickedDateto.text = DateFormat('dd-MM-yyyy').format(pickedDate2!);
                           },
                            controller: pickedDateto ,
                              validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter Date'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'To',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                       SizedBox(
                          height: 10,
                       ),
                          MaterialButton
                          (
                            color: Colors.lime,
                            onPressed: ()async  { 
                   print(emailid);
                            
                            if(pickedDate1!=null && pickedDate2!=null){
                              var data=leave(datefrom:pickedDate1,dateto:pickedDate2);
           
                              var leavesbox=boxes.getDataofleaves();
                              leavesbox.add(data);}
                                     Navigator.of(context).pop();
                            },
                          child: Text('Set',style: TextStyle(color:Colors.black),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
  
   final userhomedata = Provider.of<student?>(context);


    final Authservice _auth = Authservice();
  bool val=true;
    
 
Future<String?> getmessname()async
{
  DocumentSnapshot updatemessinfo= await FirebaseFirestore.instance.collection('users').doc(userhome!.emailid.toString()).get();
  return updatemessinfo['messname'].toString();


}



    return LiquidPullToRefresh(
      onRefresh: () async{ 
          
          DocumentSnapshot updatemessinfo= await FirebaseFirestore.instance.collection('users').doc(userhome!.emailid.toString()).get();
        messname=updatemessinfo['messname'];
          
       },
      child: Scaffold(
        backgroundColor: Colors.lime,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('User Portal',style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
           actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.logout_rounded,
          color: Colors.black,
        ),
        onPressed: ()async {
           await _auth.signout();
        },
      )
        ],
        ),
           drawer: Drawer(
                 child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              SizedBox(
                height:150,
                child: const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.lime,
                  ), //BoxDecoration
                  child: Text('Leaves took',style: TextStyle(fontSize: 25),),//UserAccountDrawerHeader
                ),
              ), 
                //  Container(
                //   alignment: Alignment.center,
                //   height: 50,
                //   child: Text('Leaves Info',style:TextStyle(fontSize: 20)),
                // ),
      
                Container(
                height: 500,
      
                   child: ValueListenableBuilder(
                  valueListenable: leavesbox.listenable(),
                      builder:(context,leavebox,_){
                        var data=leavebox.values.toList();
                   if(leavebox.isNotEmpty)
                   {
                  
                       return  ListView.builder(
                           // physics: NeverScrollableScrollPhysics(),
                           itemCount: data.length,
                           itemBuilder: (context,index){
                            if(data[index].datefrom!=null){
                            
                      
                             return Container(
                               margin: EdgeInsets.only(bottom:10,left: 13),
                               height:30,
                              //  color: Colors.blue,
                               child: Row(
                                 children: [
                                 Text('From:'+DateFormat('dd-MM-yyyy').format(data[index].datefrom!)
      ,style:TextStyle(fontSize: 16)),
                                 SizedBox(
                                  width: 15,
                                 ),
                                  Text('To:'+DateFormat('dd-MM-yyyy').format(data[index].dateto!),style:TextStyle(fontSize: 16))                                   
                               ]),
                             );}
                           }              
                       );
                   }else
                   return Center(child: Text('No leaves have been took',style: TextStyle(color: Colors.black),));
                      
                      }),
                  ),
            ],
                 ),
               ), 
        body: SingleChildScrollView(
          child: Container(

            child: SafeArea(
              child:Column(
                children: [
                  Icon(Icons.person,
                    size: 230,
                    color: Colors.black,
                  ),
                   ValueListenableBuilder(
                    valueListenable: boxes.getData().listenable(),
                    builder:(context,box,_){
                       var data=box.values.toList();
                      if(box.isNotEmpty){
                              if(true)
                              {   
                               messname=data.last.currmess.toString();
                               getmessname().then((value){
                                 data.last.currmess=value;
                                 data.last.save();
                               });
                                 
                              }
                         
                     return Center(
                       child: Container(
                        margin: EdgeInsets.fromLTRB(0,0,0,0),
                        height: height*0.70,
                        width:width,
                        decoration: BoxDecoration(
                           border: Border.all(
                                  color: Colors.black,
                                ),
                               color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Column(children: [
      
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text('Name :       ',style: TextStyle(fontSize: 22,color: Colors.black),)),
                                   Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                alignment: Alignment.centerRight,
                                child: Text(data.last.name.toString(),style: TextStyle(fontSize: 22,color: Colors.black),)),
                            ],
                          ),
                   Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text('Email id :  ',style: TextStyle(fontSize: 24,color: Colors.black),)),
                                   Container(
                                    width: 265,
                                    // color: Colors.amberAccent,
                                    margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
                                     child: SingleChildScrollView(
      
                                      scrollDirection: Axis.horizontal,
                                      child: Text(data.last.emailid.toString(),style: TextStyle(fontSize: 24,color: Colors.black),)),
                                   ),
                            ],
                          ),
                         Container(
                            margin: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Text('Roll No :    '+data.last.Rollno.toString(),style: TextStyle(fontSize: 24,color: Colors.black),)),
      
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 0, 0),
                            alignment: Alignment.centerLeft,
                            child: Text('Mess :       '+data.last.currmess.toString(),style: TextStyle(fontSize: 24,color: Colors.black),)),
                             Container(
                            margin: EdgeInsets.fromLTRB(20, 15, 0, 20),
                            alignment: Alignment.centerLeft,
                            child: Text('Bal :           '+data.last.currbal.toString(),style: TextStyle(fontSize: 24,color: Colors.black),)),
                                      
                               
                             Container(
                              margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                             height: 46,
                             width: width*0.6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                       color: Colors.lime,
                                borderRadius: BorderRadius.circular(10)
                              ),
                               child: TextButton(
                                        onPressed: () async{
                                                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  usermessinfo(namefromuserhome:data.last.name.toString(),)),
                          );
                                               },
                                child: Text('Apply for mess change',style: TextStyle(fontSize: 20,color:Colors.black)
                                              ,),
                                               
                               ),
                             ),
                             SizedBox(
                              height: 20,
                             ),
                                 Container(
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                             height: 46,
                              width: width*0.6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                       color: Colors.lime,
                                borderRadius: BorderRadius.circular(10)
                              ),
                               child: TextButton(
                                        onPressed: () {
                                                takedates(data.last.emailid.toString());
                                               },
                                child: Text('Apply for Leaves',style: TextStyle(fontSize: 20,color:Colors.black)
                                              ,),
                                               
                               ),
                             ),
                             SizedBox(
                              height: 20,
                             ),
      
                                Container(
                                    margin: EdgeInsets.fromLTRB(20, 10, 20, 30),
                             height: 46,
                             width: width*0.6,
                              decoration: BoxDecoration(
                                 border: Border.all(
                                  color: Colors.black,
                                ),
                                       color: Colors.lime,
                                borderRadius: BorderRadius.circular(10)
                              ),
                               child: TextButton(
                                               onPressed: () async{
            final checkusermessstatus=await FirebaseFirestore.instance.collection('users').doc(userhome!.emailid.toString()).get();
                            if(checkusermessstatus['messstatus']==false)
                                 {
                                   Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  registermess(name:data.last.name.toString(), emailid:userhome.emailid.toString(),),),);
                          
                                }else{
                                   Fluttertoast.showToast(msg: 'You Are Already Registered',
                       toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        
                         backgroundColor: Colors.white,
                        textColor: Colors.black,
                          fontSize: 16.0);
                                }
                                           
                                               },
                                child: Text('Register for mess',style: TextStyle(fontSize: 20,color:Colors.black)
                                              ,),
                                               
                               ),
                             ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                             height: 46,
                             width: width*0.6,
                              decoration: BoxDecoration(
                                 border: Border.all(
                                  color: Colors.black,
                                ),
                                       color: Colors.lime,
                                borderRadius: BorderRadius.circular(10)
                              ),
                               child: TextButton(
                                               onPressed: () async{
                   Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => topup(email: userhome!.emailid.toString(),model:data.last) ));
                                           
                                               },
                                child: Text('Top up',style: TextStyle(fontSize: 20,color:Colors.black)
                                              ,),
                                               
                               ),
                             ),
                               ]),
                                 ),
                     );
                      }else
                      return Center(child: Text('Please wait ',style: TextStyle(fontSize: 22),));
                      
            }
                   ),
                        
                         
                      ]
                    ),
                   
                   ),
          ),
        ),

         floatingActionButton: FloatingActionButton(
        onPressed: ()async  {
        DocumentSnapshot updatemessinfo= await FirebaseFirestore.instance.collection('users').doc(userhome!.emailid.toString()).get();
        messname=updatemessinfo['messname'];
              Navigator.push(
              context,
          MaterialPageRoute(builder: (context) => suggestions(currmess: messname,) ));
        },
        // foregroundColor: customizations[index].$1,
       backgroundColor: Colors.black,
       shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(80)),
     ),
        child:  Icon(Icons.message_outlined),
      ),
            
      ),
    );
  }
}




