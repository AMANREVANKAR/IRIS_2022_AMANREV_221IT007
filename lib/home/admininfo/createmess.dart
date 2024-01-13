import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:messinfo/services/authentication/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinfo/home/admininfo/createmess.dart';
import 'package:messinfo/home/admininfo/requestuser.dart';
import 'package:messinfo/services/authentication/auth.dart';
import 'package:messinfo/screens/loginscreen.dart';
import 'package:messinfo/models/admin.dart';
import 'package:messinfo/services/databaseadminservice.dart';
import 'package:messinfo/models/student.dart';
import 'package:provider/provider.dart';
class createmesspage extends StatefulWidget{
    const createmesspage({super.key});
  @override
  State<createmesspage> createState()=>_createmesspage();

}

class _createmesspage extends State<createmesspage>{
   final _formkey = GlobalKey<FormState>();
   

  List<admin> _admins = [];
  int _count = 0;

  void _incrementCounter() {
    setState(() {
      _count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    final adminuser = Provider.of<student?>(context);

    Future opendialog() => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            // insetPadding: EdgeInsets.fromLTRB(50,0,50,450),
            content: Builder(builder: (context) {
               TextEditingController messname = TextEditingController();
  TextEditingController type = TextEditingController();
    TextEditingController noofseats = TextEditingController();
  TextEditingController mpd = TextEditingController();
  TextEditingController mon = TextEditingController();
  TextEditingController tue = TextEditingController();
  TextEditingController wed = TextEditingController();
  TextEditingController thr = TextEditingController();
  TextEditingController fri = TextEditingController();
  TextEditingController sat = TextEditingController();
  TextEditingController sun = TextEditingController();
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Container(
             
                    height: height - 300,
                    width: width - 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Text(
                            'Create Mess',
                            style: TextStyle(fontSize: 22),
                          ),
                          TextFormField(
                            controller: messname,
                             validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter messname'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'Mess name',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: type,
                              validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter type'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'Veg or Non Veg or Veg/Non Veg',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: mpd,
                       keyboardType: TextInputType.number,
                                  validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter messbalanceperday'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'messbalanceperday',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: noofseats,
                               validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter total number of seats'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'no of seats ',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: mon,
                                  validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter mondays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'mondays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: tue,
                                  validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter tuedays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'tuedays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: wed,
                            validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter wednesdays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'wednesdays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: thr,
                               validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter thrusdays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'thrusdays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: fri,
                               validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter fridays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'fridays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: sat,
                              validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter saturdays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'saturdays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          TextFormField(
                            controller: sun,
                               validator: MultiValidator([
                                  RequiredValidator(
                                      errorText: 'Please enter sundays menu'),
                                ]),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(hintText: 'sundays menu',
                                          focusedBorder: UnderlineInputBorder(      
                          borderSide: BorderSide(color: Colors.black),   
                          ),),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(45,0,30,0),
                            child: Row(
                              children:[ MaterialButton(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  onPressed: () async{
                                                var box=await Hive.openBox(adminuser!.emailid.toString());
                                    if (_formkey.currentState!.validate()) {
                                      _admins.add(admin(
                                        messanme: messname.text.toString(),
                                        type: type.text.toString(),
                                        mpd: int.parse(mpd.text),
                                        mon: mon.text.toString(),
                                        tue: tue.text.toString(),
                                        wed: wed.text.toString(),
                                        thur: thr.text.toString(),
                                        fri: fri.text.toString(),
                                        sat: sat.text.toString(),
                                        sun: sun.text.toString(),

                                      )
                                      );
                                      
                                      adminservice _admin = adminservice(
                                          adminname: messname.text.toString(),
                                          adminemailid: adminuser.emailid.toString());

                                          
                                      // await _admin.updateadmindata(
                                      //     messname.text.toString(),
                                      //     type.text.toString(),
                                      //     int.parse(mpd.text),
                                      //     mon.text.toString(),
                                      //     tue.text.toString(),
                                      //     wed.text.toString(),
                                      //     thr.text.toString(),
                                      //     fri.text.toString(),
                                      //     sat.text.toString(),
                                      //     sun.text.toString());


                                        await _admin.createmessrqueststatus(adminuser!.emailid.toString(),type.text, noofseats.text,1,int.parse(mpd.text),
                                          mon.text.toString(),
                                          tue.text.toString(),
                                          wed.text.toString(),
                                          thr.text.toString(),
                                          fri.text.toString(),
                                          sat.text.toString(),
                                          sun.text.toString(),
                                         box.get('tokenid') );
                                      Navigator.pop(context);
                              
                              
                                      _incrementCounter();
                                      
                                      // print(admindata!.docs);
                                    } 
                                  },
                                  child: Text('Create',style: TextStyle(color: Colors.white),)),
                           SizedBox(
              width: 20,
            ),
                                  MaterialButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                    color: Colors.black,
                                    onPressed: ()
                                  { Navigator.pop(context);
                                  }, child: Text('Cancel',style: TextStyle(color:Colors.white),))
                              ],
                            
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );

    final Authservice _auth = Authservice();




    return Scaffold(
  
      body: 
         SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Text(
                'Mess',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection(adminuser!.emailid.toString()).doc('cretemess').collection('messes')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Text('PLease Wait');
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot adminsdata =
                                    snapshot.data.docs[index];
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
                                  child: Container(
                                    height: 130,
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
                                      border:Border.all(
                                        color: Colors.black87,
                                        width:1.5, 
                                      ),
                                      // color: Colors.black,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(                                    
                                      children: [
                                        Container(
                                                 margin:
                                              EdgeInsets.fromLTRB(15, 10, 15, 0),
                                         
                                  
                                          child: Row(
                                            children:[ 
                                              Container(
                                            
                                              margin: EdgeInsets.fromLTRB(10, 0, 40, 0),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                adminsdata['messname'].toString()+'('+adminsdata['type']+')',
                                                style: TextStyle(fontSize: 25,  color:Colors.black,),
                                              ),
                                            ),
                                              Container(
                                               alignment: Alignment.centerRight,
                                              child: Text(
                                                'nos:'+adminsdata['noofseats'].toString(),
                                                style: TextStyle(fontSize: 25,  color:Colors.black,),
                                              ),
                                                                                      ),
                                            ]
                                          ),
                                        ),
                                        Container(
                                                margin:
                                              EdgeInsets.fromLTRB(32, 15, 32, 10),
                                            child: Row(
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius: BorderRadius.all(
                                                        
                                                          Radius.circular(15)),
                                                    ),
                                                   // margin: EdgeInsets.only(left: 13),
                                                    child: TextButton(
                                                      onPressed: () async{
                                                                                                 var box=await Hive.openBox(adminuser.emailid.toString());
                                                        adminservice _requestservice=adminservice(adminemailid: adminuser.emailid.toString(),adminname: adminsdata['messname']
                                                                  .toString() );
                                                                  _requestservice.reqestadmindata(adminuser.emailid.toString(), adminsdata['messname'], 
                                                                  adminsdata['type'],int.parse(adminsdata['mpd']), 
                                                                  adminsdata['mon'], adminsdata['tue'], adminsdata['wed'], 
                                                                  adminsdata['thur'], adminsdata['fri'], adminsdata['sat'], adminsdata['sun'],box.get('tokenid'));

                                        
                                                            if(adminsdata['status']=='Request')
                                                            {

                                                             
                                                             _requestservice.createmessrqueststatus(adminuser.emailid.toString(), 
                                                                  adminsdata['type'],'0',0,int.parse(adminsdata['mpd']), 
                                                                  adminsdata['mon'], adminsdata['tue'], adminsdata['wed'], 
                                                                  adminsdata['thur'], adminsdata['fri'], adminsdata['sat'], adminsdata['sun'],box.get('tokenid'));


                                                                  }
                                                            else
                                                            if(adminsdata['status']=='Cancel Request')
                                                            {
                                                             _requestservice.createmessrqueststatus(adminuser.emailid.toString(), 
                                                                  adminsdata['type'],'0',1,int.parse(adminsdata['mpd']), 
                                                                  adminsdata['mon'], adminsdata['tue'], adminsdata['wed'], 
                                                                  adminsdata['thur'], adminsdata['fri'], adminsdata['sat'], adminsdata['sun'],box.get('tokenid'));
                                                                  }
                                                      },
                                                      child: Text(
                                                        adminsdata['status'],
                                                        style: TextStyle(fontSize: 15,color: Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                       border: Border.all(
                                                        color: Colors.black,
                                                      ),
                                                      borderRadius: BorderRadius.all(
                                                          Radius.circular(15)),
                                                    ),
                                                   // margin: EdgeInsets.only(left: 13),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          adminservice _admin =
                                                              adminservice();
                                                          _admin.deletedocument(
                                                              adminsdata['messname']
                                                                  .toString(),adminuser.emailid.toString());
                                                        // print(adminsdata['messname'].toString());
                                                          // _admins.removeAt(index);
                                                        });
                                                      },
                                                      child: Text(
                                                        'Remove',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                
                                                    ),
                                                  ),
                                                ],
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
      
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          opendialog();
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
  
}