import 'package:equatable/equatable.dart';
import 'package:exerciser/data/models/Exercise.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();
}

class InitialExerciseState extends ExerciseState {
  @override
  List<Object> get props => [];
}

class ExerciseLoading extends ExerciseState {
  @override
  List<Object> get props => [];
}

class ExerciseLoaded extends ExerciseState {
  final Exercise exercise;
  const ExerciseLoaded(this.exercise);
  @override
  List<Object> get props => [];
}

class ExerciseError extends ExerciseState {
  final String message;
  const ExerciseError(this.message);
  @override
  List<Object> get props => [];
}
