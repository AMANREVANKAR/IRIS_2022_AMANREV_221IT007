import 'package:hive/hive.dart';
import 'package:messinfo/models/leaves.dart';

class calculateleaves{


  Future<double> noofdays(List<leave> datePairs) async {
     
    //  datePairs
    var box=await Hive.openBox('currleave');
    DateTime signedin =box.get('currdate');
    double? totalDays = 0;
      DateTime now = DateTime.now();
if(datePairs.length!=0)
{
  for (var pair in datePairs) {
 
   if( (now.isBefore(pair.datefrom!)) )
   {
     totalDays =totalDays!+ pair.dateto!.difference(now).inDays;
        break;
   }
  else
    totalDays =totalDays!+ pair.dateto!.difference(pair.datefrom!).inDays;
    
  }

  
     int daysFromNow = now.difference(signedin).inDays;
  
     print((totalDays! - daysFromNow).abs().toString());
  
       return (totalDays! - daysFromNow).abs() ;
}else{
    return 0;
  }

  }
      
}