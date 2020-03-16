import 'package:flutter/foundation.dart';

enum Problem { Anxiety, Stress, Depression }

class ProblemDetails {
  final Problem type;
  final String noun;
  final String adjective;

  ProblemDetails(
    this.type,
    this.noun,
    this.adjective,
  );
}

ProblemDetails getProblemDetails(Problem type) {
  switch (type) {
    case Problem.Anxiety:
      return ProblemDetails(Problem.Anxiety, 'anxiety', 'anxious');
    case Problem.Stress:
      return ProblemDetails(Problem.Stress, 'stress', 'stressed');
    case Problem.Depression:
      return ProblemDetails(Problem.Depression, 'depression', 'depressed');
    default:
      throw Exception('Problem type is not recognised.');
  }
}

ProblemDetails getProblemDetailsByNoun(String noun) {
  switch (noun) {
    case 'anxiety':
      return getProblemDetails(Problem.Anxiety);
    case 'stress':
      return getProblemDetails(Problem.Stress);
    case 'depression':
      return getProblemDetails(Problem.Depression);
    default:
      throw Exception('Problem noun is not recognised.');
  }
}

class Activity {
  final int id;
  final String name;
  final String description;
  final String emoji;
  final int credits;

  Activity({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.emoji,
    @required this.credits,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'emoji': emoji,
        'credits': credits,
      };

  factory Activity.fromMap(Map<String, dynamic> map) => Activity(
        id: map['id'] as int,
        name: map['name'] as String,
        description: map['description'] as String,
        emoji: map['emoji'] as String,
        credits: map['credits'] as int,
      );
}
