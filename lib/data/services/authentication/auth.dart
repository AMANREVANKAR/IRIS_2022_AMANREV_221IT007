import 'package:firebase_auth/firebase_auth.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/data/services/database.dart';
class Authservice {

final FirebaseAuth _auth=FirebaseAuth.instance;
student? _userfromfirebase(User? user){
    return user!=null ? student(uid:user.uid.toString(),emailid: user.email,):null;
}


// Auth change user stream
  Stream<student?> get user{
  return _auth.authStateChanges().map(_userfromfirebase);
  }



// sigin emailid and password

  Future siginuser(String email,String password) async
  {
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
    
     return _userfromfirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;

    }
  }



//register using emailid and password

  Future createuser(String email,String password,String name,String currmess,int messbalance,) async
  {
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
          User? user=result.user;
          if(user!=null)
          await DataService(uid: user.email).updateuserdata(name, currmess,messbalance );
      return _userfromfirebase(user);
    }catch(e)
    {
      print(e.toString());
      return null;

    }
  }

//siginout

Future signout() async
{
  try{
    return await _auth.signOut();
  }catch(e)
  {
     print(e.toString());
     return null;
  }
}

}