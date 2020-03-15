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

class Activity {
  final int id;
  final String name;
  final String description;
  final String emoji;
  final int credits;
  final List<Problem> aids;

  Activity({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.emoji,
    @required this.credits,
    @required this.aids,
  });
}
