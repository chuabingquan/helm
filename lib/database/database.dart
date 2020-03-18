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
    name: 'Volunteer',
    emoji: '🙋',
  ),
  Reward(
    id: 3,
    name: 'Personal Praise',
    emoji: '🙌',
  ),
  Reward(
    id: 4,
    name: 'Mobile Game',
    emoji: '🎮',
  ),
  Reward(
    id: 5,
    name: 'Buy something nice',
    emoji: '🛒',
  ),
  Reward(
    id: 6,
    name: 'Nap',
    emoji: '😴',
  ),
];

final _defaultActivities = [
  Activity(
    id: 1,
    name: 'Meditate',
    description: 'Do 10 sets of breathing exercises',
    emoji: '🧘',
    credits: 1,
  ),
  Activity(
    id: 2,
    name: 'Watch a TED Talk',
    description: 'Keep yourself motivated!',
    emoji: '📺',
    credits: 1,
  ),
  Activity(
    id: 3,
    name: 'Jog',
    description: 'Go for a 1/2 hour jog',
    emoji: '🏃',
    credits: 2,
  ),
  Activity(
    id: 4,
    name: 'Read',
    description: 'Keep your mind focused on some other literature',
    emoji: '📚',
    credits: 2,
  ),
  Activity(
    id: 5,
    name: 'Stroll',
    description: 'Take a short break and enjoy the scenery',
    emoji: '🚶🏻‍♀️',
    credits: 2,
  ),
  Activity(
    id: 6,
    name: 'Write',
    description: 'Vent your anxiety through writing',
    emoji: '📝',
    credits: 3,
  ),
  Activity(
    id: 7,
    name: 'Bake',
    description: 'Bake a cake',
    emoji: '🎂',
    credits: 3,
  ),
  Activity(
    id: 8,
    name: 'Talk to a friend',
    description: 'A listening ear helps!',
    emoji: '🗣',
    credits: 4,
  ),
  Activity(
    id: 9,
    name: 'Do someone a favour',
    description: 'Helping others helps you to feel better',
    emoji: '💪',
    credits: 4,
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

          // Create challenges table.
          batch.execute(
              "CREATE TABLE IF NOT EXISTS challenges(id INTEGER PRIMARY KEY AUTOINCREMENT, initial_level INTEGER NOT NULL, ideal_level INTEGER NOT NULL, updated_level INTEGER, reward_id INTEGER NOT NULL, created_at INTEGER NOT NULL, remind_at INTEGER NOT NULL, condition TEXT NOT NULL, FOREIGN KEY(reward_id) REFERENCES rewards(id));");

          // Create challenges_activities table.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS challenges_activities(id INTEGER PRIMARY KEY AUTOINCREMENT, challenge_id INTEGER NOT NULL, activity_id INTEGER NOT NULL)');

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
