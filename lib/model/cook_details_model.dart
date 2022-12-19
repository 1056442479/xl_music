// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CookDetailsModel cookDetailsModelFromJson(String str) => CookDetailsModel.fromJson(json.decode(str));

String cookDetailsModelToJson(CookDetailsModel data) => json.encode(data.toJson());

class CookDetailsModel {
  CookDetailsModel({
    required this.id,
    required this.classId,
    required this.name,
    required this.peopleNum,
    required this.prepareTime,
    required this.cookingTime,
    required  this.content,
    required this.pic,
    required this.tag,
    required this.material,
    required this.materialList,
    required this.process,
    required this.processList,
  });

  int id;
  int classId;
  String name;
  String peopleNum;
  String prepareTime;
  String cookingTime;
  String content;
  String pic;
  String tag;
  String material;
  List<MaterialList> materialList;
  String process;
  List<ProcessList> processList;

  factory CookDetailsModel.fromJson(Map<String, dynamic> json) => CookDetailsModel(
    id: json["id"],
    classId: json["classId"],
    name: json["name"],
    peopleNum: json["peopleNum"],
    prepareTime: json["prepareTime"],
    cookingTime: json["cookingTime"],
    content: json["content"],
    pic: json["pic"],
    tag: json["tag"],
    material: json["material"],
    materialList: List<MaterialList>.from(json["materialList"].map((x) => MaterialList.fromJson(x))),
    process: json["process"],
    processList: List<ProcessList>.from(json["processList"].map((x) => ProcessList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "classId": classId,
    "name": name,
    "peopleNum": peopleNum,
    "prepareTime": prepareTime,
    "cookingTime": cookingTime,
    "content": content,
    "pic": pic,
    "tag": tag,
    "material": material,
    "materialList": List<dynamic>.from(materialList.map((x) => x.toJson())),
    "process": process,
    "processList": List<dynamic>.from(processList.map((x) => x.toJson())),
  };
}

class MaterialList {
  MaterialList({
    required this.mname,
    required  this.type,
    required  this.amount,
  });

  String mname;
  int type;
  String amount;

  factory MaterialList.fromJson(Map<String, dynamic> json) => MaterialList(
    mname: json["mname"],
    type: json["type"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "mname": mname,
    "type": type,
    "amount": amount,
  };
}

class ProcessList {
  ProcessList({
    required this.pcontent,
    required this.pic,
  });

  String pcontent;
  String pic;

  factory ProcessList.fromJson(Map<String, dynamic> json) => ProcessList(
    pcontent: json["pcontent"],
    pic: json["pic"],
  );

  Map<String, dynamic> toJson() => {
    "pcontent": pcontent,
    "pic": pic,
  };
}
