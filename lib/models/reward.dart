import 'package:flutter/foundation.dart';

class Reward {
  final int id;
  final String name;
  final String emoji;

  Reward({
    @required this.id,
    @required this.name,
    @required this.emoji,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'emoji': emoji,
      };

  factory Reward.fromMap(Map<String, dynamic> map) => Reward(
        id: map['id'] as int,
        name: map['name'] as String,
        emoji: map['emoji'] as String,
      );
}
