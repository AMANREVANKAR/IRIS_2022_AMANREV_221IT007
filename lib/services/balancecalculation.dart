import 'package:hive/hive.dart';
import 'package:messinfo/models/leaves.dart';

class calculateleaves{


  Future<double> noofdays(List<leave> datePairs) async {

    var box=await Hive.openBox('currleave');
    DateTime signedin =box.get('currdate');
    double? totalDays = 0;

  for (var pair in datePairs) {
    print(pair.dateto);
    print(pair.datefrom);
    if(pair.dateto!=null && pair.datefrom!=null)
    totalDays =totalDays!+ pair.dateto!.difference(pair.datefrom!).inDays;
    
  }

    DateTime now = DateTime.now();
     int daysFromNow = now.difference(signedin).inDays;
     print(totalDays);
     print(daysFromNow);
     print('aman'+(totalDays! - daysFromNow).toString());
       
       if(daysFromNow>totalDays)
       return totalDays - daysFromNow;
       else
       return 0;
  }
      
}