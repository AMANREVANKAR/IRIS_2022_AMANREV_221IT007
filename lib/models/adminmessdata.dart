// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminMessInfo {
  String? messname;
  String? type;
  String? mpd;
  String? noofseats;
  String? mon;
  String? tue;
  String? wed;
  String? thur;
  String? fri;
  String? sat;
  String? sun;
  String? emailid;
  String? tokenid;

  AdminMessInfo({this.messname,this.type,this.mpd,this.noofseats,this.mon,this.tue,this.wed,
  this.thur,this.fri,this.sat,this.sun,this.emailid,this.tokenid});



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messname': messname,
      'type': type,
      'mpd': mpd,
      'mon': mon,
      'tue': tue,
      'wed': wed,
      'thur': thur,
      'fri': fri,
      'sat': sat,
      'sun': sun,
      'emailid':emailid,
      'tokenid':tokenid,
      'noofseats':noofseats,

    };
  }

  factory AdminMessInfo.fromMap(Map<String, dynamic> map) {
    return AdminMessInfo(
      messname: map['messname'] != null ? map['messname'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      mpd: map['mpd'] != null ? map['mpd'] as String : null,
      mon: map['mon'] != null ? map['mon'] as String : null,
      tue: map['tue'] != null ? map['tue'] as String : null,
      wed: map['wed'] != null ? map['wed'] as String : null,
      thur: map['thur'] != null ? map['thur'] as String : null,
      fri: map['fri'] != null ? map['fri'] as String : null,
      sat: map['sat'] != null ? map['sat'] as String : null,
      sun: map['sun'] != null ? map['sun'] as String : null,
      emailid: map['emailid'] != null ? map['emailid'] as String : null,
      tokenid: map['tokenid'] != null ? map['tokenid'] as String : null,
      noofseats: map['noofseats'] != null ? map['noofseats'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminMessInfo.fromJson(String source) => AdminMessInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
