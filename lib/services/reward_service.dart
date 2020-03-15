import '../models/reward.dart';

class RewardService {
  final rewards = [
    Reward(
      id: 1,
      name: 'Ice Cream',
      emoji: '🍦',
    ),
    Reward(
      id: 2,
      name: 'Personal Praise',
      emoji: '🙌',
    ),
  ];

  Future<List<Reward>> getAll() async {
    return rewards.map((r) => r).toList();
  }
}
