import 'package:exerciser/bloc/bloc.dart';
import 'package:exerciser/data/services/ExerciseRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/ExerciseSearchPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exerciser',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        builder: (context) => ExerciseBloc(ApiExerciseRepository()),
        child: ExerciseSearchPage(),
      ),
    );
  }
}
