import 'dart:convert';

import 'package:exerciser/data/models/Exercise.dart';
import 'package:http/http.dart' as http;

abstract class ExerciseRepository {
  Future<List<Exercise>> fetchExercises();
  Future<Exercise> fetchExercise(int id);
  Future<Exercise> fetchDetailedExercise(int id);
}

class ApiExerciseRepository implements ExerciseRepository {
  final String standardApi =
      "https://wger.de/api/v2/exercise/?language=1&status=2";

  @override
  Future<Exercise> fetchDetailedExercise(int id) {
    return Future.delayed(Duration(seconds: 1), () {
      return Exercise(name: 'Test Detail');
    });
  }

  @override
  Future<Exercise> fetchExercise(int id) {
    return Future.delayed(Duration(seconds: 1), () {
      return Exercise(name: 'Test');
    });
  }

  @override
  Future<List<Exercise>> fetchExercises() async {
    final response = await http.get(standardApi);
    List<Exercise> exercises = [];
    var js = json.decode(response.body);
    var results = js['results'];
    for (var item in results) {
      var exercise = Exercise.fromJson(item);
      exercises.add(exercise);
    }

    return exercises;
  }
}
