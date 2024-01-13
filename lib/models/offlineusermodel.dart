


import 'package:hive/hive.dart';
part 'offlineusermodel.g.dart';


@HiveType(typeId: 0)
class offlineusermodel extends HiveObject{

  @HiveField(0)
   String? name;


     @HiveField(1)
   String? emailid;

     @HiveField(2)
   String? Rollno;

     @HiveField(3)
   String? currmess;

     @HiveField(4)
   String? currbal;

  @HiveField(5)
  String? messbalanceperday;

  offlineusermodel({this.name,this.emailid,this.Rollno,this.currmess,this.currbal,this.messbalanceperday});
}