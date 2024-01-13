import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class registermess extends StatefulWidget{
var emailid;
var name;
  registermess({this.name,this.emailid});
  @override
  State<registermess> createState()=> _registermess();

}

class _registermess extends State<registermess>
{
    String _selectedItem = 'vindya'; // Default selected item

  // List of dropdown items
  List<String> _dropdownItems = [
       'karavli',
              'aravali',
              'niligri',
              'vindya',
              'satpura',
              'megamess',
              'trishul',
  ];
  @override
  Widget build(BuildContext context) {
   return Scaffold( 
    appBar: AppBar(
      backgroundColor: Colors.green,
    ),
    body:Center(
    child: Container(
      decoration: BoxDecoration(
           color: Colors.lime,
        border: Border.all(
          color: Colors.black
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 250,
      height:160,
    
      child: Center(
        child: Column(
          children: [
            
            Container(
              padding: EdgeInsets.all(10),
              width: 160,
              height: 45,
              decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
              ),
              
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: DropdownButton<String>(
                dropdownColor: Colors.white,
          
                  isExpanded: true,
                 underline: SizedBox(),
                focusColor: Colors.lime,
                iconEnabledColor: Colors.black,
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
                    });
                  },
                ),
            ),

              Container(
                margin:EdgeInsets.fromLTRB(0, 10, 0, 0),
               child:ElevatedButton(onPressed: () async {
             final userupdate= await FirebaseFirestore.instance.collection('users').doc(widget.emailid.toString());
              userupdate.set(
                {
                  'messname':_selectedItem,
                  'messstatus':true,
                  'name':widget.name,
                  'email':widget.emailid,
                }
              );
             

              Navigator.pop(context);
              
              }, child: Text('OK'))),
          ],
        ),
      ),
      ),
   ),
    );
  
  }

}