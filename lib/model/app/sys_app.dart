
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SysAppPo welcomeFromJson(String str) => SysAppPo.fromJson(json.decode(str));

String welcomeToJson(SysAppPo data) => json.encode(data.toJson());

class SysAppPo {
  SysAppPo({
    required this.id,
    required this.sysVersion,
    required this.sysName,
    required this.url,
    required this.install,
    this.versionInfo,
  });

  int id;
  String sysVersion;
  String sysName;
  String url;
  int install;
  dynamic versionInfo;

  factory SysAppPo.fromJson(Map<String, dynamic> json) => SysAppPo(
    id: json["id"],
    sysVersion: json["sysVersion"],
    sysName: json["sysName"],
    url: json["url"],
    install: json["install"],
    versionInfo: json["versionInfo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sysVersion": sysVersion,
    "sysName": sysName,
    "url": url,
    "install": install,
    "versionInfo": versionInfo,
  };
}
