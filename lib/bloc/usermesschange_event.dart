// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'usermesschange_bloc.dart';

@immutable
sealed class UsermesschangeEvent {}

class messList extends UsermesschangeEvent {
  List<AdminMessInfo> listOfMess;
  messList({
    required this.listOfMess,
  });
}
