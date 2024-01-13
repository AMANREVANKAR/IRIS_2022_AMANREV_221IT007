import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinfo/presentation/home/admininfo/createmess.dart';
import 'package:messinfo/presentation/home/admininfo/requestuser.dart';
import 'package:messinfo/presentation/home/userinfo/userapproval.dart';
import 'package:messinfo/presentation/home/userinfo/usermesschange.dart';
import 'package:messinfo/data/services/authentication/auth.dart';
import 'package:messinfo/presentation/screens/loginscreen.dart';
import 'package:messinfo/models/admin.dart';
import 'package:messinfo/data/services/databaseadminservice.dart';
import 'package:messinfo/models/student.dart';
import 'package:provider/provider.dart';

class usermessinfo extends StatefulWidget {
  var namefromuserhome;
   usermessinfo ({this.namefromuserhome});
  @override
  State<usermessinfo > createState() => _usermessinfo();
}

class _usermessinfo  extends State<usermessinfo > {
  
    int _currentIndex = 0;

    void _onItemTapped(int index) {
    setState(() {
      print(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

     final List<Widget> _pages = [
    messchange(namefromuserhome: widget.namefromuserhome,),
    approval(),
  ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mess Change Portal'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
       bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        unselectedLabelStyle: TextStyle(color:Colors.black),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.request_page_rounded,color: Colors.black,),
            label: 'Apply',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Status',
          ),
        ],
      ),
     
       body:_pages[_currentIndex],
        
  
    );
  }
}