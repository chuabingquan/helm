import 'package:flutter/foundation.dart';

import './activity.dart';
import './reward.dart';

class Challenge {
  final int id;
  final int initialLevel;
  final int idealLevel;
  final int updatedLevel;
  final Set<Activity> activities;
  final Reward reward;
  final DateTime createdOn;

  Challenge({
    @required this.id,
    @required this.initialLevel,
    @required this.idealLevel,
    this.updatedLevel,
    @required this.activities,
    @required this.reward,
    @required this.createdOn,
  });
}
