import 'package:app/blocs/test_bloc/test_bloc.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              context.read<TestBloc>().add(TestGetData());
            },
            child: const Text("PRESS ME")),
      ),
    ));
  }
}
