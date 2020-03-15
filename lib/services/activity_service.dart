import '../models/activity.dart';

class ActivityService {
  final activities = [
    Activity(
      id: 1,
      name: 'Jogging',
      description: 'Go for a 1/2 hour jog',
      emoji: '🏃',
      credits: 2,
      aids: [Problem.Anxiety, Problem.Stress, Problem.Depression],
    ),
    Activity(
      id: 2,
      name: 'Breathing',
      description: 'Do 10 sets of breathing exercises',
      emoji: '🧘',
      credits: 1,
      aids: [Problem.Anxiety, Problem.Stress],
    ),
    Activity(
      id: 3,
      name: 'Write',
      description: 'Vent your anxiety through writing',
      emoji: '📝',
      credits: 3,
      aids: [Problem.Anxiety, Problem.Stress, Problem.Depression],
    ),
  ];

  Future<List<Activity>> getAll() async {
    return activities.map((a) => a).toList();
  }
}
