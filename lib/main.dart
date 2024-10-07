import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:plantiful/app.dart';
import 'package:plantiful/core/bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
