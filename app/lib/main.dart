import "package:app/application.dart";
import 'package:app/blocs/bloc_module.dart';
import 'package:app/blocs/login_bloc/login_bloc.dart';
import 'package:app/blocs/test_bloc/test_bloc.dart';
import 'package:data/di/data_module.dart';
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:get_it/get_it.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerServices();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TestBloc>(create: (context) => GetIt.I.get<TestBloc>()),
      BlocProvider<LoginBloc>(create: (context) => GetIt.I.get<LoginBloc>()),
    ],
    child: Application(),
  ));
}

void registerServices() {
  BlocModule();
  DataModule();
}
