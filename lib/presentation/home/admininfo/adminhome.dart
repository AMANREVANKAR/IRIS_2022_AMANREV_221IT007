import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messinfo/presentation/home/admininfo/adminsuggestion.dart';
import 'package:messinfo/presentation/home/admininfo/allocate_deallocate.dart';
import 'package:messinfo/presentation/home/admininfo/createmess.dart';
import 'package:messinfo/presentation/home/admininfo/requestuser.dart';
import 'package:messinfo/data/services/authentication/auth.dart';
import 'package:messinfo/presentation/screens/loginscreen.dart';
import 'package:messinfo/models/admin.dart';
import 'package:messinfo/data/services/databaseadminservice.dart';
import 'package:messinfo/models/student.dart';
import 'package:provider/provider.dart';

class adminhome extends StatefulWidget {
  const adminhome({super.key});
  @override
  State<adminhome> createState() => _adminhome();
}

class _adminhome extends State<adminhome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    createmesspage(),
    requestmesspage(),
    adminsuggestions(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      print(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Authservice _auth = Authservice();
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            SizedBox(
              height: 150,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lime,
                ), //BoxDecoration
                child: Text(
                  'Info',
                  style: TextStyle(fontSize: 25),
                ), //UserAccountDrawerHeader
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 50,
              child: MaterialButton(
                  color: Colors.lime,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllocateReallocate()),
                    );
                  },
                  child: Text('Deallocate')),
            ),
          ],
        ),
      ),
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Admin Portal',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              onPressed: () async {
                // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: Text('This is a Appbar Icon example')));
                await _auth.signout();
              },
            ),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.request_page,
            ),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
            ),
            label: 'Suggestions',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
