part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetInitial extends InternetState {}

class ConnectedState extends InternetState {
  final String message;

  ConnectedState({required this.message});
}

class NotConnectedState extends InternetState {
  final String message;

  NotConnectedState({required this.message});
}