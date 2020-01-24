import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();
}

class GetExercise extends ExerciseEvent {
  final String exerciseName;

  const GetExercise(this.exerciseName);

  @override
  List<Object> get props => [exerciseName];
}

class GetDetailedExercise extends ExerciseEvent {
  final String exerciseName;

  const GetDetailedExercise(this.exerciseName);

  @override
  List<Object> get props => [exerciseName];
}
