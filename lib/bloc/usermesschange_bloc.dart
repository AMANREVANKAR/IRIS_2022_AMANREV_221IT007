import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messinfo/models/adminmessdata.dart';
import 'package:meta/meta.dart';

part 'usermesschange_event.dart';
part 'usermesschange_state.dart';

class UsermesschangeBloc extends Bloc<UsermesschangeEvent, UsermesschangeState> {
  UsermesschangeBloc() : super(UsermesschangeInitial(isError: false,isFetching: false,messInfo:[] )) {
    FirebaseFirestore.instance.collection("messoffer").snapshots().listen((event) {
                 List<AdminMessInfo> list=  event.docs.map(docsToObject).toList();
                 add(messList(listOfMess: list));
                });
    on<messList>((event, emit) {
        emit(fetched(isFetching: false, isError: false, messInfo: event.listOfMess));
    });
  }
}

AdminMessInfo docsToObject(QueryDocumentSnapshot snap){
 return AdminMessInfo.fromMap(snap.data() as Map<String,dynamic>);
}



