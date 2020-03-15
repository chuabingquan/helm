import 'package:flutter/foundation.dart';

import '../services/activity_service.dart';
import '../models/activity.dart';

class Activities with ChangeNotifier {
  final _activityService = ActivityService();
  List<Activity> _activities = [];

  List<Activity> get activities {
    return _activities.map((a) => a).toList();
  }

  Future<void> fetchAndSetActivities() async {
    try {
      _activities = await _activityService.getAll();
    } catch (err) {
      throw err;
    }
  }
}
