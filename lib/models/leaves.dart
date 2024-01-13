


import 'package:hive/hive.dart';
part 'leaves.g.dart';


@HiveType(typeId: 1)
class leave{

@HiveField(0)
DateTime? datefrom;

@HiveField(1)
DateTime? dateto;

leave({this.datefrom,this.dateto});
}