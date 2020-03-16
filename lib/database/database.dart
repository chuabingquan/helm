import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/activity.dart';
import '../models/reward.dart';

final _defaultRewards = [
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
  Reward(
    id: 3,
    name: 'Mobile Game',
    emoji: '🎮',
  ),
];

final _defaultActivities = [
  Activity(
    id: 1,
    name: 'Jogging',
    description: 'Go for a 1/2 hour jog',
    emoji: '🏃',
    credits: 2,
  ),
  Activity(
    id: 2,
    name: 'Breathing',
    description: 'Do 10 sets of breathing exercises',
    emoji: '🧘',
    credits: 1,
  ),
  Activity(
    id: 3,
    name: 'Writing',
    description: 'Vent your anxiety through writing',
    emoji: '📝',
    credits: 3,
  ),
];

Future<Database> connectToDB(String dbName) async {
  try {
    return await openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) async {
        try {
          final batch = db.batch();

          // Create and insert default rewards into database.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS rewards(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, emoji TEXT NOT NULL);');
          _defaultRewards.forEach((reward) {
            batch.insert('rewards', reward.toMap());
          });

          // Create and insert default activities into database.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS activities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, description TEXT NOT NULL, emoji TEXT NOT NULL, credits INTEGER NOT NULL);');
          _defaultActivities.forEach((activity) {
            batch.insert('activities', activity.toMap());
          });

          await batch.commit();
        } catch (err) {
          throw err;
        }
      },
      version: 2,
    );
  } catch (err) {
    throw err;
  }
}
