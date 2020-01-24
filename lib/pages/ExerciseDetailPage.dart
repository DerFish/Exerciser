import 'package:exerciser/bloc/exercise_bloc.dart';
import 'package:exerciser/bloc/exercise_event.dart';
import 'package:exerciser/bloc/exercise_state.dart';
import 'package:exerciser/data/models/Exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseDetailPage extends StatefulWidget {
  ExerciseDetailPage({Key key, @required this.masterExercise})
      : super(key: key);
  final Exercise masterExercise;

  @override
  _ExerciseDetailPageState createState() => _ExerciseDetailPageState();
}

class _ExerciseDetailPageState extends State<ExerciseDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return buildLoading();
          } else if (state is ExerciseLoaded) {
            return buildColumnWithData(context, state.exercise);
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return Container(
      child: LinearProgressIndicator(),
    );
  }

  Widget buildColumnWithData(BuildContext context, Exercise exercise) {
    return Text(exercise.name);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<ExerciseBloc>(context)
        .add(GetDetailedExercise(widget.masterExercise.name));
  }
}
