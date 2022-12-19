// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SongFansModel songFansModelFromJson(String str) => SongFansModel.fromJson(json.decode(str));

String songFansModelToJson(SongFansModel data) => json.encode(data.toJson());

class SongFansModel {
  SongFansModel({
    required this.isFollow,
    required  this.fansCnt,
    required   this.followCnt,
    required  this.followDay,
    required  this.follow,
  });

  bool isFollow;
  int fansCnt;
  int followCnt;
  String followDay;
  bool follow;

  factory SongFansModel.fromJson(Map<String, dynamic> json) => SongFansModel(
    isFollow: json["isFollow"] == null ? null : json["isFollow"],
    fansCnt: json["fansCnt"] == null ? null : json["fansCnt"],
    followCnt: json["followCnt"] == null ? null : json["followCnt"],
    followDay: json["followDay"] == null ? null : json["followDay"],
    follow: json["follow"] == null ? null : json["follow"],
  );

  Map<String, dynamic> toJson() => {
    "isFollow": isFollow == null ? null : isFollow,
    "fansCnt": fansCnt == null ? null : fansCnt,
    "followCnt": followCnt == null ? null : followCnt,
    "followDay": followDay == null ? null : followDay,
    "follow": follow == null ? null : follow,
  };
}
