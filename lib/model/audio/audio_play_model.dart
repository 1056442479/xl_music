

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';

AudioPlayModel audioPlayModelFromJson(String str) => AudioPlayModel.fromJson(json.decode(str));

String audioPlayModelToJson(AudioPlayModel data) => json.encode(data.toJson());

class AudioPlayModel {
  AudioPlayModel({
    required this.song,
    required this.sysVersion,
    required this.sysName,
    required this.url,
    required this.install,
    this.versionInfo,
  });

  Song song;
  String sysVersion;
  String sysName;
  String url;
  int install;
  dynamic versionInfo;

  factory AudioPlayModel.fromJson(Map<String, dynamic> json) => AudioPlayModel(
    song: json["song"],
    sysVersion: json["sysVersion"],
    sysName: json["sysName"],
    url: json["url"],
    install: json["install"],
    versionInfo: json["versionInfo"],
  );

  Map<String, dynamic> toJson() => {
    "song": song,
    "sysVersion": sysVersion,
    "sysName": sysName,
    "url": url,
    "install": install,
    "versionInfo": versionInfo,
  };
}
