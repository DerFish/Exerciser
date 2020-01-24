import 'package:exerciser/bloc/exercise_bloc.dart';
import 'package:exerciser/bloc/exercise_event.dart';
import 'package:exerciser/bloc/exercise_state.dart';
import 'package:exerciser/data/models/Exercise.dart';
import 'package:exerciser/data/services/ExerciseRepository.dart';
import 'package:exerciser/pages/ExerciseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseSearchPage extends StatelessWidget {
  final repository = ApiExerciseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ExerciseSearch'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: <Widget>[
            BlocListener<ExerciseBloc, ExerciseState>(
              listener: (context, state) {
                if (state is ExerciseError) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                  ));
                }
              },
              child: BlocBuilder<ExerciseBloc, ExerciseState>(
                builder: (context, state) {
                  if (state is InitialExerciseState) {
                    return buildInitialInput();
                  } else if (state is ExerciseLoading) {
                    return buildLoading();
                  } else if (state is ExerciseLoaded) {
                    return buildColumnWithData(context, state.exercise);
                  }
                  return Container();
                },
              ),
            ),
            SizedBox(
              height: 500,
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(snapshot.data[index].name));
                        },
                        shrinkWrap: true,
                      ),
                    );
                  } else {
                    return buildLoading();
                  }
                },
                future: repository.fetchExercises(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: ExerciseInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Exercise exercise) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          exercise.name,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: BlocProvider.of<ExerciseBloc>(context),
                child: ExerciseDetailPage(
                  masterExercise: exercise,
                ),
              ),
            ));
          },
        ),
        ExerciseInputField(),
      ],
    );
  }
}

class ExerciseListView extends StatelessWidget {
  final List<Exercise> exercises;
  const ExerciseListView({Key key, this.exercises}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('test'),
    );
  }
}

class ExerciseInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitExerciseName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a Exercise",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitExerciseName(BuildContext context, String name) {
    final exerciseBloc = BlocProvider.of<ExerciseBloc>(context);
    exerciseBloc.add(GetExercise(name));
  }
}
