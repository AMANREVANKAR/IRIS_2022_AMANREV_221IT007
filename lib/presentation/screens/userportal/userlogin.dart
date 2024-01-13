import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:messinfo/data/services/authentication/auth.dart';
import 'package:messinfo/presentation/home/userinfo/userhome.dart';
import 'package:messinfo/shared/loading.dart';
class userlogin extends StatefulWidget {
  const userlogin({Key? key}) : super(key: key);

  @override
  State<userlogin> createState() => _userLoginState();
}

class _userLoginState extends State<userlogin> {
  bool _passwordVisible = true;

  bool loadingvalue=false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Authservice _auth = Authservice();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loadingvalue ? loading() : Scaffold(
      appBar: AppBar(
        title: Text('User Login'),
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
                                  controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email id';
                                    } else if (value
                                        .toString()
                                        .contains('admin')) {
                                      return ' Email id must not contain admin';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    labelText: 'Email',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    errorStyle: TextStyle(fontSize: 18.0),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
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
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                prefixIcon: Icon(
                                  Icons.key,
                                  color: Colors.black,
                                ),
                                errorStyle: TextStyle(fontSize: 18.0),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.lock
                                        : Icons.lock_open,
                                    color: Colors.black,
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
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                color: Colors.lime,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 60,
                              width: 500,
                              child: TextButton(
                                onPressed: () async {
                                 
                                  if (_formkey.currentState!.validate()) {
                                     setState(() {
                                    loadingvalue=true;
                                  });
                                    dynamic result = await _auth.siginuser(
                                        emailController.text.toString(),
                                        passwordController.text.toString());

                                    if (result == null) {
                                      setState(() {
                                        loadingvalue=false;
                                      });
                                      Fluttertoast.showToast(
                                          msg: "Unable to login");
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: result.toString(),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: Text(
                                  'LOGIN',
                                  style: new TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
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
