

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messinfo/models/admin.dart';

class adminservice{

    final String? adminname;
    final String? adminemailid;
  adminservice({this.adminname,this.adminemailid});

  final CollectionReference admincoll=FirebaseFirestore.instance.collection('admins');

     Future updateadmindata(String messname,String  type,int mpd,
     String mon,String tue,String wed,String thur,String fri,String sat,String sun)async
  {

    if(adminname!=null)
    {
      final DocumentReference admincoll=FirebaseFirestore.instance.collection(adminemailid.toString()).doc(adminname);
        return await admincoll.set({
          'messname':messname,
          'type':type,
          'mpd':mpd.toString(),
          'mon':mon,
          'tue':tue,
          'wed':wed,
          'thur':thur,
          'fri':fri,
          'sat':sat,
          'sun':sun,
        });
    }
  }

  void deletedocument(String adminname,String adminemailid)async
  {
    print(adminname.toString());
    print(adminemailid.toString());
          final DocumentReference admincolldelete=FirebaseFirestore.instance.collection(adminemailid.toString()).doc('cretemess').collection('messes').doc(adminname);
      return await admincolldelete.delete();
  }

   Future reqestadmindata(String adminemailid,String messname,String  type,int mpd,
     String mon,String tue,String wed,String thur,String fri,String sat,String sun,String tokenid,String noofseats)async
  {

    if(adminname!=null)
    {
      final DocumentReference admincoll=FirebaseFirestore.instance.collection('messoffer').doc(adminemailid+messname);
        return await admincoll.set({
          'emailid':adminemailid,
          'messname':messname,
          'type':type,
          'mpd':mpd.toString(),
          'mon':mon,
          'tue':tue,
          'wed':wed,
          'thur':thur,
          'fri':fri,
          'sat':sat,
          'sun':sun,
          'tokenid':tokenid,
           'noofseats':noofseats,

        });
    }
  }


  Future updaterequesteduser(String name,String studentemailid,int status) async
  {
     final DocumentReference admincoll=FirebaseFirestore.instance.collection(studentemailid.toString())
     .doc('requested').collection('requests').doc(adminname);
       
       if(status==1)
       {
        return await admincoll.set({
         'name':name,
          'emailid':studentemailid,
          'messname':adminname,
          'status':'Approved',
        });
       }else{
           return await admincoll.set({
         'name':name,
          'emailid':studentemailid,
          'messname':adminname,
          'status':'Rejected',
        });
       }
  }




  Future  createmessrqueststatus(String adminemailid,String type,String noofseats,int status,int mpd,
     String mon,String tue,String wed,String thur,String fri,String sat,String sun,String tokenid) async
  {
     final DocumentReference admincoll=FirebaseFirestore.instance.collection(adminemailid.toString()).doc('cretemess').collection('messes').doc(adminname);
        if(status==1)
        {

        admincoll.set({
          'emailid':adminemailid,
           'messname':adminname,
           'type':type,
           'noofseats':noofseats,
          'mpd':mpd.toString(),
          'mon':mon,
          'tue':tue,
          'wed':wed,
          'thur':thur,
          'fri':fri,
          'sat':sat,
          'sun':sun,
          'tokenid':tokenid,
          'status':'Request',
        });
               
        print('hello');
        print(adminemailid+adminname.toString());
       final DocumentReference admincolldelete=FirebaseFirestore.instance.collection('messoffer').doc(adminemailid+adminname.toString());
      return await admincolldelete.delete();
        }
       else
       if(status==0)
       {
       
          return await admincoll.set({
            'emailid':adminemailid,
           'messname':adminname,
           'type':type,
           'noofseats':noofseats,
          'mpd':mpd.toString(),
          'mon':mon,
          'tue':tue,
          'wed':wed,
          'thur':thur,
          'fri':fri,
          'sat':sat,
          'sun':sun,
           'tokenid':tokenid,
           'status':'Cancel Request',
        });   
       }
  }


 Future updaterequestadmin(String name,String studentemailid,int status) async
  {
 
     final DocumentReference admincoll=FirebaseFirestore.instance.
     collection(adminemailid.toString()).doc('requested').collection('requests').doc(studentemailid!+adminname.toString());
       
   

   
       if(status==1)
       {
        final DocumentSnapshot updatenoofseats =  await FirebaseFirestore.
     instance.collection(adminemailid.toString())
     .doc('cretemess').collection('messes').doc(adminname).get();

     updatenoofseats['noofseats']!=(int.parse(updatenoofseats['noofseats'])-1).toString();

        return await admincoll.set({
         'name':name,
          'emailid':studentemailid,
          'messname':adminname,
          'status':'Accepted',
        });
       }else{
           return await admincoll.set({
         'name':name,
          'emailid':studentemailid,
          'messname':adminname,
          'status':'Rejected',
        });
       }
  }


    Future updateuserinfo(String name,String emailid) async
    {
        final DocumentReference userinfo = FirebaseFirestore.instance.collection('users').doc(emailid.toString());
    return await userinfo.set({
      'name':name,
      'emailid':emailid,
      'messname':'none',
      'messstatus':false,
    });
    }

}