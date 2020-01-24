import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'Muscle.dart';

class Exercise extends Equatable {
  int id;
  int categoryId;
  int languageId;
  String description;
  String name;
  Image image;
  List<Muscle> muscles;

  Exercise({
    this.id,
    this.name,
    this.categoryId,
    this.languageId,
    this.description,
    this.image,
    this.muscles,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  @override
  List<Object> get props => [name];
}
