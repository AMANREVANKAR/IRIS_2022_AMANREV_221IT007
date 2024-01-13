import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:messinfo/data/services/database.dart';

class suggestions extends StatefulWidget {
  var currmess;
  suggestions({this.currmess});
  @override
  State<suggestions> createState() => _suggestions();
}

class _suggestions extends State<suggestions> {
  final _formkey = GlobalKey<FormState>();

  Future opendialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Builder(builder: (context) {
            TextEditingController suggestion = TextEditingController();

            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;

            return SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Container(
                  height: height - 750,
                  width: width - 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(
                          'Add a suggestion',
                          style: TextStyle(fontSize: 22),
                        ),
                        TextFormField(
                          controller: suggestion,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Please enter the suggestion'),
                          ]),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Suggestion',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          color: Colors.black,
                          onPressed: () async {
                            var now = new DateTime.now();
                            var formatter = new DateFormat('dd-MMMM-yyyy');
                            String formattedDate = formatter.format(now);

                            DataService suggestionservice = DataService();
                            suggestionservice.createsuggestion(widget.currmess,
                                suggestion.text, formattedDate);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Add',
                            style: TextStyle(color: Colors.white),
                          ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suggestions'),
        backgroundColor: Colors.green,
      ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          opendialog();
        },
        // foregroundColor: customizations[index].$1,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
