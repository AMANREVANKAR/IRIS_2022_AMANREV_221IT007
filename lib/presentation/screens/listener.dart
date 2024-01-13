import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:messinfo/models/student.dart';
import 'package:messinfo/presentation/screens/loginscreen.dart';
import 'package:messinfo/presentation/home/userinfo/userhome.dart';
import 'package:messinfo/presentation/home/admininfo/adminhome.dart';

class listener extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    final user=Provider.of<student?>(context);
      Navigator.maybePop(context);
    // print(user!.emailid.toString());
    if(user!=null)
      {
         // print(user);
         if(user.emailid!.contains('admin'))
         {
             print(user.emailid);
             return adminhome();
         }
         else
           return userhome();
      }
      else
        return loginscreen();
  }

}