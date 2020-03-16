import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/challenge.dart';

class Challenges with ChangeNotifier {
  final Database _database;
  Challenge _latestChallengeToday;

  Challenges(this._database) {
    fetchAndSetLatestChallenge();
  }

  Challenge get latestChallenge {
    return _latestChallengeToday;
  }

  Future<void> fetchAndSetLatestChallenge() async {
    try {
      final challengeResults = await _database.query(
        'challenges',
        where:
            "DATE(created_at/1000, 'unixepoch', 'localtime')=Date('now', 'localtime') AND updated_level IS NULL",
        orderBy: 'created_at DESC',
        limit: 1,
      );

      if (challengeResults.length < 1) {
        _latestChallengeToday = null;
        return;
      }

      final challengeId = challengeResults[0]['id'] as int;
      final activityResults = await _database.query(
        'activities',
        where:
            'id IN (SELECT activity_id FROM challenges_activities WHERE challenge_id=?)',
        whereArgs: [challengeId],
      );

      final rewardResults = await _database.query(
        'rewards',
        where: 'id=?',
        whereArgs: [challengeResults[0]['reward_id'] as int],
      );

      _latestChallengeToday = Challenge.fromMap({
        ...challengeResults[0],
        'activities': activityResults,
        'reward': rewardResults[0],
      });

      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> create(Challenge challenge) async {
    try {
      await _database.transaction((tx) async {
        var newChallengeId = 1;
        final mostRecentChallengeList =
            await tx.query('challenges', orderBy: 'id DESC', limit: 1);

        if (mostRecentChallengeList.length > 0) {
          newChallengeId = (mostRecentChallengeList[0]['id'] as int) + 1;
        }

        final batch = tx.batch();

        final challengeToInsert = challenge.toMap();
        challengeToInsert['id'] = newChallengeId;
        challengeToInsert['created_at'] = DateTime.now().millisecondsSinceEpoch;
        batch.insert('challenges', challengeToInsert);

        challenge.activities.forEach((a) {
          batch.insert('challenges_activities', {
            'challenge_id': newChallengeId,
            'activity_id': a.id,
          });
        });

        await batch.commit();
      });
      await fetchAndSetLatestChallenge();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

  Future<void> endChallenge(int challengeId, int updatedLevel) async {
    try {
      await _database.update(
        'challenges',
        {'updated_level': updatedLevel},
        where: 'id=?',
        whereArgs: [challengeId],
      );
      await fetchAndSetLatestChallenge();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
