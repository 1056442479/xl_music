// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:qq_music/model/dj/dj_details.dart';

DjUserCreateModel djUserCreateModelFromJson(String str) => DjUserCreateModel.fromJson(json.decode(str));

String djUserCreateModelToJson(DjUserCreateModel data) => json.encode(data.toJson());

class DjUserCreateModel {
  DjUserCreateModel({
    required this.dj,
    required this.category,
    required this.secondCategory,
    required this.buyed,
    required this.price,
    required this.originalPrice,
    required this.discountPrice,
    required this.purchaseCount,
     this.lastProgramName,
    required this.videos,
    required this.finished,
    required this.underShelf,
    required this.liveInfo,
    required this.playCount,
    required this.privacy,
    required this.icon,
    required this.manualTagsDto,
     this.descPicList,
    required this.welcomeDynamic,
    required this.shortName,
    required this.categoryId,
    required this.taskId,
    required this.programCount,
    required this.picId,
    required this.subCount,
    required this.feeScope,
    required this.lastProgramId,
    required this.lastProgramCreateTime,
    required this.radioFeeType,
    required this.intervenePicUrl,
    required this.picUrl,
    required this.intervenePicId,
    required this.desc,
    required this.createTime,
    required this.name,
    required this.id,
    required this.rcmdtext,
  });

  Dj dj;
  String category;
  String secondCategory;
  bool buyed;
  int price;
  int originalPrice;
  dynamic discountPrice;
  int purchaseCount;
  String ? lastProgramName;
  dynamic videos;
  bool ? finished;
  bool ? underShelf;
  dynamic liveInfo;
  int playCount;
  bool ? privacy;
  dynamic icon;
  dynamic manualTagsDto;
  List<dynamic> ? descPicList;
  bool ? welcomeDynamic;
  dynamic shortName;
  int categoryId;
  int ? taskId;
  int programCount;
  double picId;
  int subCount;
  int ? feeScope;
  int ? lastProgramId;
  int ? lastProgramCreateTime;
  int radioFeeType;
  String ? intervenePicUrl;
  String picUrl;
  double ? intervenePicId;
  String desc;
  int createTime;
  String name;
  int id;
  dynamic rcmdtext;

  factory DjUserCreateModel.fromJson(Map<String, dynamic> json) => DjUserCreateModel(
    dj: Dj.fromJson(json["dj"]),
    category: json["category"] == null ? null : json["category"],
    secondCategory: json["secondCategory"] == null ? null : json["secondCategory"],
    buyed: json["buyed"] == null ? null : json["buyed"],
    price: json["price"] == null ? null : json["price"],
    originalPrice: json["originalPrice"] == null ? null : json["originalPrice"],
    discountPrice: json["discountPrice"],
    purchaseCount: json["purchaseCount"] == null ? null : json["purchaseCount"],
    lastProgramName: json["lastProgramName"] == null ? null : json["lastProgramName"],
    videos: json["videos"],
    finished: json["finished"] == null ? null : json["finished"],
    underShelf: json["underShelf"] == null ? null : json["underShelf"],
    liveInfo: json["liveInfo"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    icon: json["icon"],
    manualTagsDto: json["manualTagsDTO"],
    descPicList: json["descPicList"]==null?null:List<dynamic>.from(json["descPicList"].map((x) => x)),
    welcomeDynamic: json["dynamic"] == null ? null : json["dynamic"],
    shortName: json["shortName"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    taskId: json["taskId"] == null ? null : json["taskId"],
    programCount: json["programCount"] == null ? null : json["programCount"],
    picId: json["picId"] == null ? null : json["picId"].toDouble(),
    subCount: json["subCount"] == null ? null : json["subCount"],
    feeScope: json["feeScope"] == null ? null : json["feeScope"],
    lastProgramId: json["lastProgramId"] == null ? null : json["lastProgramId"],
    lastProgramCreateTime: json["lastProgramCreateTime"] == null ? null : json["lastProgramCreateTime"],
    radioFeeType: json["radioFeeType"] == null ? null : json["radioFeeType"],
    intervenePicUrl: json["intervenePicUrl"] == null ? null : json["intervenePicUrl"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    intervenePicId: json["intervenePicId"] == null ? null : json["intervenePicId"].toDouble(),
    desc: json["desc"] == null ? null : json["desc"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    rcmdtext: json["rcmdtext"],
  );

  Map<String, dynamic> toJson() => {
    "dj": dj == null ? null : dj.toJson(),
    "category": category == null ? null : category,
    "secondCategory": secondCategory == null ? null : secondCategory,
    "buyed": buyed == null ? null : buyed,
    "price": price == null ? null : price,
    "originalPrice": originalPrice == null ? null : originalPrice,
    "discountPrice": discountPrice,
    "purchaseCount": purchaseCount == null ? null : purchaseCount,
    "lastProgramName": lastProgramName == null ? null : lastProgramName,
    "videos": videos,
    "finished": finished == null ? null : finished,
    "underShelf": underShelf == null ? null : underShelf,
    "liveInfo": liveInfo,
    "playCount": playCount == null ? null : playCount,
    "privacy": privacy == null ? null : privacy,
    "icon": icon,
    "manualTagsDTO": manualTagsDto,
    "descPicList": descPicList == null ? null : List<dynamic>.from(descPicList!.map((x) => x)),
    "dynamic": welcomeDynamic == null ? null : welcomeDynamic,
    "shortName": shortName,
    "categoryId": categoryId == null ? null : categoryId,
    "taskId": taskId == null ? null : taskId,
    "programCount": programCount == null ? null : programCount,
    "picId": picId == null ? null : picId,
    "subCount": subCount == null ? null : subCount,
    "feeScope": feeScope == null ? null : feeScope,
    "lastProgramId": lastProgramId == null ? null : lastProgramId,
    "lastProgramCreateTime": lastProgramCreateTime == null ? null : lastProgramCreateTime,
    "radioFeeType": radioFeeType == null ? null : radioFeeType,
    "intervenePicUrl": intervenePicUrl == null ? null : intervenePicUrl,
    "picUrl": picUrl == null ? null : picUrl,
    "intervenePicId": intervenePicId == null ? null : intervenePicId,
    "desc": desc == null ? null : desc,
    "createTime": createTime == null ? null : createTime,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "rcmdtext": rcmdtext,
  };
}

