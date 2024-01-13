import 'package:cloud_firestore/cloud_firestore.dart';

class DataService{

  final String? uid;
  DataService({this.uid});

  Future updateuserdata(String name,String messname,int messbalance)async
  {
    
  final CollectionReference usercollection = FirebaseFirestore.instance.collection(uid.toString());
        return await usercollection.doc('info').set({
          'name':name,
          'messname':messname,
          'messbalance':messbalance,
        });
  }

    Future requestuserdata(String adminemailid,String messname,String studentemailid,
    String name,String currmessname)async
  {
    // final DocumentReference usercollection = FirebaseFirestore.instance.collection('request').doc('request'
    // +adminemailid).collection('requests').doc(studentemailid.toString());

        final DocumentReference usercollection = FirebaseFirestore.instance.collection(adminemailid).doc('requested'
        ).collection('requests').doc(studentemailid+messname);
        return await usercollection.set({
          'name':name,
          'emailid':studentemailid,
            'adminemailid':adminemailid,
          'messname':messname,
          'status':'Requested',
       
        });
  }

     Future requesteduserdata(String adminemailid,String messname,String studentemailid,
    String name,String currmessname)async
  {
    final DocumentReference usercollection = FirebaseFirestore.instance.collection(studentemailid).doc('requested').collection('requests').doc(messname.toString());
        return await usercollection.set({
          'name':name,
          'emailid':studentemailid,
          'messname':messname,
          'adminemailid':adminemailid,
          'status':'Requested',
        });
  }



  Future createuserinfo(String name,String emailid,String currmess,String messbalancecharge)async
  {
    final DocumentReference userinfo = FirebaseFirestore.instance.collection('users').doc(emailid.toString());
    return await userinfo.set({
      'name':name,
      'emailid':emailid,
      'messname':currmess,
      'messstatus':true,
    });
  }

   Future createsuggestion(String currmess,String suggestion,String date)async
  {
    final DocumentReference userinfo = FirebaseFirestore.instance.collection('suggestion').doc();
    return await userinfo.set({
      'currmess':currmess,
      'suggestion':suggestion,
      'date':date,
     
    });
  }
 





// void deleteallrequesteddocuments(String messname)
// {
//   FirebaseFirestore.instance.collection(uid!).doc('requested').collection('requests').get().then((snapshots){
//     for (DocumentSnapshot ds in snapshots.docs){
//       if(ds['messname']==messname)
//       continue;
//       else
//     ds.reference.delete();
//   };
//   });
 
// }

Future<String?> updatecount()async
{
      final DocumentSnapshot getdocument = await FirebaseFirestore.instance.collection(uid!).doc('count').get();
      return getdocument['status'];
}

void setcount(int status)async
{
  final DocumentReference usercollection = FirebaseFirestore.instance.collection(uid!).doc('count');

     if(status==1){
        return await usercollection.set({
          'status':'false',
        });
     }else{
        return await usercollection.set({
          'status':'true',
        });
     }
}


  Future<List<String>> getData(String emailid) async {
     
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users') 
          .doc(emailid.toString())
          .get();

    List<String> data=[];
    
    print(documentSnapshot['name']);
  
    data.add(documentSnapshot['name']);
    data.add(documentSnapshot['messname']);
     
      return data;
  }







  

}