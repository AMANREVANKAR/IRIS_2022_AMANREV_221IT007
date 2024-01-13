import 'package:hive/hive.dart';
import 'package:messinfo/models/leaves.dart';
import 'package:messinfo/models/offlineusermodel.dart';

class boxes{
  static Box<offlineusermodel> getData()=>Hive.box<offlineusermodel>('users');


  static Box<leave> getDataofleaves()=>Hive.box<leave>('leaves');
}