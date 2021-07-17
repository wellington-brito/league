import 'package:flutter/cupertino.dart';

class PlayedSummoner {
  String wasPlayed;
  String puuid;
  String name;

  PlayedSummoner(
      {required this.wasPlayed, required this.puuid, required this.name});

  factory PlayedSummoner.fromJson(Map<String, dynamic> json) {
    return PlayedSummoner(
        wasPlayed: json['wasPlayed'], puuid: json['puuid'], name: json['name']);
  }
}
