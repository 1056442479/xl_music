// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SongUrlDetails songUrlDetailsFromJson(String str) => SongUrlDetails.fromJson(json.decode(str));

String songUrlDetailsToJson(SongUrlDetails data) => json.encode(data.toJson());

class SongUrlDetails {
  SongUrlDetails({
    required this.id,
    required this.url,
    required this.br,
    required this.size,
     this.md5,
    required this.code,
    required this.expi,
     this.type,
    required this.gain,
     this.peak,
    required this.fee,
     this.uf,
    required this.payed,
    required this.flag,
    required this.canExtend,
     this.freeTrialInfo,
     this.level,
     this.encodeType,
     this.freeTrialPrivilege,
    required this.freeTimeTrialPrivilege,
    required this.urlSource,
    required this.rightSource,
     this.podcastCtrp,
     this.effectTypes,
    required this.time,
  });

  int id;
  dynamic url;
  int br;
  int size;
  String ? md5;
  int code;
  int expi;
  String ? type;
  double gain;
  double ? peak;
  int fee;
  dynamic uf;
  int payed;
  int flag;
  bool canExtend;
  dynamic freeTrialInfo;
  String ? level;
  String ? encodeType;
  FreeTrialPrivilege ? freeTrialPrivilege;
  FreeTimeTrialPrivilege ? freeTimeTrialPrivilege;
  int urlSource;
  int rightSource;
  dynamic podcastCtrp;
  dynamic effectTypes;
  int time;

  factory SongUrlDetails.fromJson(Map<String, dynamic> json) => SongUrlDetails(
    id: json["id"] == null ? null : json["id"],
    url: json["url"]==null?null: json["url"],
    br: json["br"] == null ? null : json["br"],
    size: json["size"] == null ? null : json["size"],
    md5: json["md5"] == null ? null : json["md5"],
    code: json["code"] == null ? null : json["code"],
    expi: json["expi"] == null ? null : json["expi"],
    type: json["type"] == null ? null : json["type"],
    gain: json["gain"] == null ? null : json["gain"].toDouble(),
    peak:json["peak"]==null?null:  double.parse(json["peak"]!.toString()) ,
    fee: json["fee"] == null ? null : json["fee"],
    uf: json["uf"],
    payed: json["payed"] == null ? null : json["payed"],
    flag: json["flag"] == null ? null : json["flag"],
    canExtend: json["canExtend"] == null ? null : json["canExtend"],
    freeTrialInfo: json["freeTrialInfo"],
    level: json["level"] == null ? null : json["level"],
    encodeType: json["encodeType"] == null ? null : json["encodeType"],
    freeTrialPrivilege: json["freeTrialPrivilege"] == null ? null : FreeTrialPrivilege.fromJson(json["freeTrialPrivilege"]),
    freeTimeTrialPrivilege: json["freeTimeTrialPrivilege"] == null ? null : FreeTimeTrialPrivilege.fromJson(json["freeTimeTrialPrivilege"]),
    urlSource: json["urlSource"] == null ? null : json["urlSource"],
    rightSource: json["rightSource"] == null ? null : json["rightSource"],
    podcastCtrp: json["podcastCtrp"],
    effectTypes: json["effectTypes"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "br": br == null ? null : br,
    "size": size == null ? null : size,
    "md5": md5 == null ? null : md5,
    "code": code == null ? null : code,
    "expi": expi == null ? null : expi,
    "type": type == null ? null : type,
    "gain": gain == null ? null : gain,
    "peak": peak == null ? null : peak,
    "fee": fee == null ? null : fee,
    "uf": uf,
    "payed": payed == null ? null : payed,
    "flag": flag == null ? null : flag,
    "canExtend": canExtend == null ? null : canExtend,
    "freeTrialInfo": freeTrialInfo,
    "level": level == null ? null : level,
    "encodeType": encodeType == null ? null : encodeType,
    "freeTrialPrivilege": freeTrialPrivilege == null ? null : freeTrialPrivilege!.toJson(),
    "freeTimeTrialPrivilege": freeTimeTrialPrivilege == null ? null : freeTimeTrialPrivilege!.toJson(),
    "urlSource": urlSource == null ? null : urlSource,
    "rightSource": rightSource == null ? null : rightSource,
    "podcastCtrp": podcastCtrp,
    "effectTypes": effectTypes,
    "time": time == null ? null : time,
  };
}

class FreeTimeTrialPrivilege {
  FreeTimeTrialPrivilege({
    required this.resConsumable,
    required this.userConsumable,
    required this.type,
    required this.remainTime,
  });

  bool resConsumable;
  bool userConsumable;
  int type;
  int remainTime;

  factory FreeTimeTrialPrivilege.fromJson(Map<String, dynamic> json) => FreeTimeTrialPrivilege(
    resConsumable: json["resConsumable"] == null ? null : json["resConsumable"],
    userConsumable: json["userConsumable"] == null ? null : json["userConsumable"],
    type: json["type"] == null ? null : json["type"],
    remainTime: json["remainTime"] == null ? null : json["remainTime"],
  );

  Map<String, dynamic> toJson() => {
    "resConsumable": resConsumable == null ? null : resConsumable,
    "userConsumable": userConsumable == null ? null : userConsumable,
    "type": type == null ? null : type,
    "remainTime": remainTime == null ? null : remainTime,
  };
}

class FreeTrialPrivilege {
  FreeTrialPrivilege({
    required this.resConsumable,
    required this.userConsumable,
     this.listenType,
  });

  bool resConsumable;
  bool userConsumable;
  dynamic listenType;

  factory FreeTrialPrivilege.fromJson(Map<String, dynamic> json) => FreeTrialPrivilege(
    resConsumable: json["resConsumable"] == null ? null : json["resConsumable"],
    userConsumable: json["userConsumable"] == null ? null : json["userConsumable"],
    listenType: json["listenType"],
  );

  Map<String, dynamic> toJson() => {
    "resConsumable": resConsumable == null ? null : resConsumable,
    "userConsumable": userConsumable == null ? null : userConsumable,
    "listenType": listenType,
  };
}
