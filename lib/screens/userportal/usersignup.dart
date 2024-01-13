import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:messinfo/models/offlineusermodel.dart';
import 'package:messinfo/services/Hiveservices/boxes.dart';
import 'package:messinfo/services/authentication/auth.dart';
import 'package:messinfo/home/userinfo/userhome.dart';
import 'package:messinfo/services/database.dart';
import 'package:messinfo/services/notification_services.dart';
import 'package:messinfo/shared/loading.dart';
class usersignup extends StatefulWidget {
  const usersignup({Key? key}) : super(key: key);

  @override
  State<usersignup> createState() => _usersignup();
}


class _usersignup extends State<usersignup> {

    String _selectedItem = 'vindya';
   List<String> _dropdownItems = [
       'karavli',
              'aravali',
              'niligri',
              'vindya',
              'satpura',
              'megamess',
              'trishul',
  ];

  bool loadingvalue=false;
    bool  _passwordVisible = true;
 final _formkey = GlobalKey<FormState>();
   String? _validateemail(String value) {
  if (value.contains('admin')) {
    print(value.toString());
    return "Email must not contain admin";
    // return "Email should contain admin";
  }
  return null;
 
}

  TextEditingController nameController = TextEditingController();
   TextEditingController rollnoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currmess = TextEditingController();
  TextEditingController messbalance = TextEditingController();
  TextEditingController mpd = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Authservice _auth=Authservice();

  @override
  Widget build(BuildContext context) {

    return loadingvalue ? loading() : Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
         iconTheme: IconThemeData(color: Colors.white),
     
        backgroundColor: Colors.black,),
        body: Form(
                   key: _formkey,
          child: ListView(
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'UserSignup',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
        
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  
                  controller: nameController,
                  validator: MultiValidator([
                           RequiredValidator(
                                      errorText: 'Please enter user name'),
                                ]),
                  cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white),  //<-- HERE
                  decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.white,
              ),
                    labelText: 'User Name',
           
                  ),
                ),
              ),
               Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  
                  controller: rollnoController,
                  validator: MultiValidator([
                           RequiredValidator(
                                      errorText: 'Please enter user name'),
                                ]),
                  cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white),  //<-- HERE
                  decoration: const InputDecoration(
                    
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.white,
              ),
                    labelText: 'Roll No',
           
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                       controller: emailController,
                        validator: (value) {
                              if (value == null || value.isEmpty) {
                                    return 'Please enter email id';
                                     }
                                     else
                                     if(value.toString().contains('admin'))
                                     {
                                          return ' Email id must not contain admin';
                                     }
                                  return null;
                                 },
        
                  cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white),  //<-- HERE
                  decoration:  InputDecoration(
                    errorText: _validateemail(emailController.text.toString()),
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.white,
              ),
                    //border: OutlineInputBorder(),
                    labelText: 'Email Id',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  obscureText: _passwordVisible,
                  controller: passwordController,
                   validator: MultiValidator([
                           RequiredValidator(
                                      errorText: 'Please enter Password'),
                                  MinLengthValidator(8,
                                      errorText:
                                      'Password must be atlist 8 digit'),
                                  PatternValidator(r'(?=.*?[#!@$%^&*-])',
                                      errorText:
                                      'Password must be atlist one special character')
                                ]),
                 cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white),  //<-- HERE
                  decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.white,
              ),
               suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
               _passwordVisible
               ? Icons.lock
               :  Icons.lock_open,
               color: Colors.white,
               ),
            onPressed: () {
               // Update the state i.e. toogle the state of passwordVisible variable
               setState(() {
                   _passwordVisible = !_passwordVisible;
               });
             },
            ),
                   // border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                 child: DropdownButton<String>(
                dropdownColor: Colors.black,
            style: TextStyle(color: Colors.white,fontSize: 18),
                  isExpanded: true,
                //  underline: SizedBox(),
                focusColor: Colors.lime,
                iconEnabledColor: Colors.white,
                alignment: Alignment.centerLeft,
              elevation: 18,
              
              borderRadius: BorderRadius.all(Radius.circular(5),),
                  value: _selectedItem,
                  items: _dropdownItems.map((String value) {
                    return DropdownMenuItem<String>(
                     
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                      currmess.text=newValue;
                    });
                  },
                ),
            //     child: TextFormField(
            //       obscureText: false,
            //       controller: currmess,
                
            //       validator: MultiValidator([
            //                RequiredValidator(
            //                           errorText: 'Please enter currmess'),
            //                     ]),
            // cursorColor: Colors.white,
            //        style: TextStyle(color: Colors.white),  //<-- HERE
            //       decoration: const InputDecoration(
            //                   enabledBorder: UnderlineInputBorder(      
            //             borderSide: BorderSide(color: Colors.white),   
            //             ),
            //             focusedBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white),
            //          ),
            //                       labelStyle:  TextStyle(
            // color:  Colors.white,
            //   ),
            //        // border: OutlineInputBorder(),
            //         labelText: 'Currmess',
            //       ),
            //     ),
              ),
                  Container(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: TextFormField(
                  obscureText: false,
                  controller: messbalance,
                  keyboardType: TextInputType.number,
                  validator: MultiValidator([
                           RequiredValidator(
                                      errorText: 'Please enter messbalance'),
                                ]),
             cursorColor: Colors.white,
                   style: TextStyle(color: Colors.white),  //<-- HERE
                  decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.white),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.white,
              ),
                   // border: OutlineInputBorder(),
                    labelText: 'Mess balance',
                  ),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              //   child: TextFormField(
              //     obscureText: false,
              //     controller: mpd,
              //     validator: MultiValidator([
              //       RequiredValidator(
              //           errorText: 'Please enter mess charge per day'),
              //     ]),
              //     cursorColor: Colors.white,
              //     style: TextStyle(color: Colors.white),  //<-- HERE
              //     decoration: const InputDecoration(

              //       enabledBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //       ),
              //       focusedBorder: UnderlineInputBorder(
              //         borderSide: BorderSide(color: Colors.white),
              //       ),
              //       labelStyle:  TextStyle(
              //         color:  Colors.white,
              //       ),
              //       // border: OutlineInputBorder(),
              //       labelText: 'Mess charge per day',
              //     ),
              //   ),
              // ),
          
              Container(
                margin: EdgeInsets.fromLTRB(30,40,30,20),
                decoration: BoxDecoration(
                  color:  Colors.lime,
                  borderRadius: BorderRadius.circular(25),
                ),
                height: 70,
                width: 80,
                child: TextButton(
                  onPressed: () async {
                 
                 if (_formkey.currentState!.validate()) {
                     setState(() {
                      loadingvalue=true;
                    });
                dynamic result = await _auth.createuser(emailController.text.toString(), passwordController.text.toString(),
                nameController.text.toString(),currmess.text.toString(),int.parse(messbalance.text));

          DataService _userservice=DataService();
          _userservice.createuserinfo(nameController.text.toString(), emailController.text.toString(), currmess.text.toString(), messbalance.text.toString());
 final DocumentSnapshot usersigup=await FirebaseFirestore.instance.collection('messes').doc(_selectedItem.toString()).get();
                  mpd.text=usersigup['mcpd'].toString();
                  print(mpd.text.toString());
                  final data=  offlineusermodel(name:nameController.text.toString(),
                  emailid: emailController.text.toString(),
                  Rollno: rollnoController.text.toString(),
                  currmess: currmess.text.toString(),
                  currbal: messbalance.text.toString(),
                    messbalanceperday: mpd.text.toString(),
                   );

                   var box=boxes.getData();
                  box.add(data);

                  var hiveresult=data.save();
                  print(hiveresult);

                  print(box.values.last.name);


                if(result==null)
                  {
                    setState(() {
                      loadingvalue=false;
                    });
                    Fluttertoast.showToast(msg: "Unable to create account");
                 }else{


      

                      String? idtoken;
                  notificationervices _servicegetidtoken=notificationervices();
                  _servicegetidtoken.getdevicetoken().then((value) {
                    idtoken=value.toString();
                  });




               

               var leavesbox=await Hive.openBox('currleave');
               leavesbox.put('currdate',DateTime.now());


                       DataService _setcount=  DataService(uid:emailController.text.toString());
                       _setcount.setcount(1);

                  Fluttertoast.showToast(msg: result.toString(),
                     toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      
                       backgroundColor: Colors.white,
                      textColor: Colors.black,
                        fontSize: 16.0);
                        }
                 }
                   },
        
                  child: Text('USER SIGNUP', style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black
                  ),),
                ),
              ),
            ],
          ),
        ));
  }
}