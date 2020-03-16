import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/activity.dart';

class Activities with ChangeNotifier {
  final Database _database;
  List<Activity> _activities = [];

  Activities(this._database);

  List<Activity> get activities {
    return _activities.map((a) => a).toList();
  }

  Future<void> fetchAndSetActivities() async {
    try {
      final results = await _database.query('activities');
      _activities = results.map((a) => Activity.fromMap(a)).toList();
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }
}
