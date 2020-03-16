import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/reward.dart';

class Rewards with ChangeNotifier {
  final Database _database;
  List<Reward> _rewards = [];

  Rewards(this._database);

  List<Reward> get rewards {
    return _rewards.map((r) => r).toList();
  }

  Future<void> fetchAndSetRewards() async {
    try {
      final results = await _database.query('rewards');
      _rewards = results.map((r) => Reward.fromMap(r)).toList();
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
