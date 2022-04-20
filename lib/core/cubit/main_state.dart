import 'package:flutter/material.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

class ChangeModeState extends MainState {}

class ChangeLocalLanguageState extends MainState {}


///SignOut
class SignOutLoadingState extends MainState{}
class SignOutSuccessState extends MainState {}
class SignOutErrorState extends MainState{}
///SignOut