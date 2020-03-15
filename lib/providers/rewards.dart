import 'package:flutter/foundation.dart';

import '../services/reward_service.dart';
import '../models/reward.dart';

class Rewards with ChangeNotifier {
  final _rewardService = RewardService();
  List<Reward> _rewards = [];

  List<Reward> get rewards {
    return _rewards.map((r) => r).toList();
  }

  Future<void> fetchAndSetRewards() async {
    try {
      _rewards = await _rewardService.getAll();
    } catch (err) {
      throw err;
    }
  }
}
