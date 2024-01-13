import 'package:cloud_firestore/cloud_firestore.dart';


class databasesearch{



  Future<bool> searchfromfirebase(String emailid) async
  {
    final CollectionReference emailcoll=FirebaseFirestore.instance.collection('admins');
      final result=emailcoll.where('email',isEqualTo: emailid
      ).get();

      if(result==null)
        return false;
      else
        return true;
  }

}