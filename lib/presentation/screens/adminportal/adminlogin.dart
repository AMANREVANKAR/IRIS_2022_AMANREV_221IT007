import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:messinfo/data/services/authentication/auth.dart';
import 'package:messinfo/data/services/databasesearchservice.dart';
import 'package:messinfo/presentation/home/admininfo/adminhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messinfo/data/services/notification_services.dart';
import 'package:messinfo/shared/loading.dart';
class adminlogin extends StatefulWidget {
  const adminlogin({Key? key}) : super(key: key);

  @override
  State<adminlogin> createState() => _LoginState();
}

class _LoginState extends State<adminlogin> {
  bool loadingvalue=false;
   bool  _passwordVisible = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
   Authservice _auth=Authservice();
  databasesearch _search=databasesearch();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loadingvalue ? loading() : Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
      iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text('Admin Login',style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                style: TextStyle(color:Colors.white),
                                controller: emailController,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: 'Enter email address'),
                                           PatternValidator(r'admin',
                                    errorText:
                                    'Emial must contain admin'),
                                    EmailValidator(
                                        errorText:
                                        'Please correct email filled'),
                                  ]),
                                  decoration: InputDecoration(
                                    
                                      hintText: 'Email',
                                      labelText: 'Email',
                                      labelStyle: TextStyle(color: Colors.white),
                                         enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                   ),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.white,
                                      ),
                                      errorStyle: TextStyle(fontSize: 18.0,color: Colors.white),
                                      // border: OutlineInputBorder(
                                      //     borderSide:
                                      //     BorderSide(color: Colors.red),
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.circular(9.0)))
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              obscureText:  _passwordVisible,
                                  style: TextStyle(color:Colors.white),
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
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                 labelStyle: TextStyle(color: Colors.white),
                                   enabledBorder: UnderlineInputBorder(      
                      borderSide: BorderSide(color: Colors.white),   
                      ),
                      focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                   ),
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.white,
                                ),
                                errorStyle: TextStyle(fontSize: 18.0,color: Colors.white),

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
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(22.0),
                            child:  Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                color:  Colors.lime,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 50,
                              width: 500,
                              child: TextButton(
                                onPressed: () async {
                                 

                                  if (_formkey.currentState!.validate()) {
                                     setState(() {
                                    loadingvalue=true;
                                  });
                          dynamic result = await _auth.siginuser(emailController.text.toString(), passwordController.text.toString());
                       if(result!=null)
                  {
                    Hive.openBox(emailController.text.toString());
                    var box= await Hive.openBox(emailController.text.toString());

                    notificationervices tokenidadmin=notificationervices();
                   tokenidadmin.getdevicetoken().then((value){
                     box.put('tokenid',value.toString());
                   });
        
                    Fluttertoast.showToast(msg: 'Login Sucessfull',
                     toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                       backgroundColor: Colors.white,
                      textColor: Colors.black,
                        fontSize: 16.0);
                  
                 }else{
                         setState(() {
                           loadingvalue=false;
                         });
                      Fluttertoast.showToast(msg: "Unable to login");
                        }
                              
                                  }
                                },
                                child: Text('LOGIN', style: new TextStyle(
                                  fontSize: 20.0,
                                color: Colors.black
                                ),),
                              ),
                            ),
                          ),
                        ]),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
