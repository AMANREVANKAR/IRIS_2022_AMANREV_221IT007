import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:messinfo/data/services/database.dart';

class adminsuggestions extends StatefulWidget {
  var currmess;
  adminsuggestions({this.currmess});
  @override
  State<adminsuggestions> createState() => _adminsuggestions();
}

class _adminsuggestions extends State<adminsuggestions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('suggestion').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot suggestiondocument =
                        snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.all(15),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.lime,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 5, 36, 0),
                                width: 80,
                                child: Text(
                                  suggestiondocument['currmess'],
                                  style: TextStyle(fontSize: 21),
                                ),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  suggestiondocument['date'],
                                  style: TextStyle(fontSize: 21),
                                ),
                              ),
                            ],
                          ),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                suggestiondocument['suggestion'],
                                style: TextStyle(fontSize: 21),
                              )),
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Text('Please wait'),
              );
            }
          }),
    );
  }
}
