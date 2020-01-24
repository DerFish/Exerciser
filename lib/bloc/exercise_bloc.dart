import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:exerciser/data/services/ExerciseRepository.dart';
import './bloc.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;

  ExerciseBloc(this.repository);

  @override
  ExerciseState get initialState => InitialExerciseState();

  @override
  Stream<ExerciseState> mapEventToState(
    ExerciseEvent event,
  ) async* {
    yield ExerciseLoading();
    if (event is GetExercise) {
      final exercise = await repository.fetchExercise(187);
      yield ExerciseLoaded(exercise);
    } else if (event is GetDetailedExercise) {
      final exercise = await repository.fetchDetailedExercise(187);
      yield ExerciseLoaded(exercise);
    }
  }
}
