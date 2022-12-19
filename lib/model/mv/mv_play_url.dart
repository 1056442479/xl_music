// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


import 'dart:convert';

MvPlayUrlModel mvPlayUrlModelFromJson(String str) => MvPlayUrlModel.fromJson(json.decode(str));

String mvPlayUrlModelToJson(MvPlayUrlModel data) => json.encode(data.toJson());

class MvPlayUrlModel {
  MvPlayUrlModel({
    required this.id,
     this.url,
    required this.r,
    required this.size,
     this.md5,
    required this.code,
    required this.expi,
    required this.fee,
    required this.mvFee,
    required this.st,
     this.promotionVo,
     this.msg,
  });

  int id;
  String ? url;
  int r;
  int size;
  String ? md5;
  int code;
  int expi;
  int fee;
  int mvFee;
  int st;
  dynamic promotionVo;
  String ? msg;

  factory MvPlayUrlModel.fromJson(Map<String, dynamic> json) => MvPlayUrlModel(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    r: json["r"] == null ? null : json["r"],
    size: json["size"] == null ? null : json["size"],
    md5: json["md5"] == null ? null : json["md5"],
    code: json["code"] == null ? null : json["code"],
    expi: json["expi"] == null ? null : json["expi"],
    fee: json["fee"] == null ? null : json["fee"],
    mvFee: json["mvFee"] == null ? null : json["mvFee"],
    st: json["st"] == null ? null : json["st"],
    promotionVo: json["promotionVo"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "r": r == null ? null : r,
    "size": size == null ? null : size,
    "md5": md5 == null ? null : md5,
    "code": code == null ? null : code,
    "expi": expi == null ? null : expi,
    "fee": fee == null ? null : fee,
    "mvFee": mvFee == null ? null : mvFee,
    "st": st == null ? null : st,
    "promotionVo": promotionVo,
    "msg": msg == null ? null : msg,
  };
}
