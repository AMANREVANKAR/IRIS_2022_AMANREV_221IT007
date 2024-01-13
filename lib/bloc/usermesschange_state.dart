part of 'usermesschange_bloc.dart';

@immutable
sealed class UsermesschangeState {
  final bool isFetching;
  final bool isError;
  final List<AdminMessInfo> messInfo;

  UsermesschangeState({required this.isFetching, required this.isError, required this.messInfo});

}

final class UsermesschangeInitial extends UsermesschangeState {
  UsermesschangeInitial({required super.isFetching, required super.isError, required super.messInfo});
}

final class fetched extends UsermesschangeState{
  fetched({required super.isFetching, required super.isError, required super.messInfo});
}