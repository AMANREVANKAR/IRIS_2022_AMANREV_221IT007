import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:messinfo/models/offlineusermodel.dart';

class topup extends StatefulWidget{
  var email;
  offlineusermodel? model;
  topup({this.email,this.model});
  @override
  State<topup> createState() =>_topup();

}

class _topup extends State<topup>
{
  int sum=0;
  TextEditingController topup=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Topup'),
        backgroundColor: Colors.green,
      ),

      body: Center(
        child: Column(children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                width: 130,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                   textAlign: TextAlign.center,
                   
                   keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: topup,
                  validator: MultiValidator([
                           RequiredValidator(
                                      errorText: 'Please enter messbalance'),
                                ]),
             cursorColor: Colors.black,
                   style: TextStyle(color: Colors.black,fontSize: 25),  //<-- HERE
                  decoration: const InputDecoration(
                      alignLabelWithHint: true, 
                              enabledBorder: UnderlineInputBorder(      
                        borderSide: BorderSide(color: Colors.black),   
                        ),
                        focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                     ),
                                  labelStyle:  TextStyle(
            color:  Colors.black,
              ),
                   // border: OutlineInputBorder(),
                    labelText: 'Top up',
                  ),
                ),
              ),

              MaterialButton(onPressed: ()async{
               
                print(widget.email.toString());
                 sum= int.parse(topup.text)+int.parse(widget.model!.currbal!);
                 print(sum);
                 widget.model!.currbal=sum.toString();
                  await widget.model!.save();
                    var now = new DateTime.now();
                  var formatter = new DateFormat('dd-MMMM-yyyy');
                   String formattedDate = formatter.format(now);

                  FirebaseFirestore.instance.collection(widget.email.toString())
                  .doc('money').collection('transaction').doc(DateTime.now().toString()).set({
                    'messbalance':sum.toString(),
                    'date':formattedDate.toString(),
                    'topup':topup.text.toString(),
                  });
                   setState(() {
                  topup.text='';
                });
              },
              color: Colors.green,
              child: Text('Add'),),
                 
                 
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Text('Transactions',style: TextStyle(fontSize: 22),),
              ),

              Expanded(child: Container(
                color: Colors.white,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection(
                    widget.email.toString()).doc('money').collection('transaction').snapshots(),
                  builder:(context,AsyncSnapshot snapshot)
                  {
                    if(snapshot.hasData){
                    return ListView.builder(
         
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) { 
                          DocumentSnapshot usermoney= snapshot.data.docs[index];
                        return ListTile(
                          leading: Container(
                            width: 35,
                            child: Text('+'+usermoney['topup'],
                            textScaleFactor: 1.2,
                            style: TextStyle(color: Colors.green,
                            ),
                            ),
                          ) ,
                title: Text(
                  'messbal:  '+usermoney['messbalance']+'Rs',
                  textScaleFactor: 1.1,
                  
                ),
                trailing: Text(usermoney['date'],style: TextStyle(
                  fontSize: 17
                ),),
                        );
                       },
                    );
                    }else{
                      return Center(child: Text('Please wait'));
                    }
                    
                  }
    )
              )),
        ]),
      ),
    );
  }
  
}