// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CookGroupModel cookGroupModelFromJson(String str) => CookGroupModel.fromJson(json.decode(str));

String cookGroupModelToJson(CookGroupModel data) => json.encode(data.toJson());

class CookGroupModel {
  CookGroupModel({
   required this.classId,
    required  this.name,
    required  this.parentId,
    required  this.weight,
    required   this.img,
    required  this.children,
  });

  int classId;
  String name;
  int parentId;
  int weight;
  String img;
  List<CookGroupModel> children;

  factory CookGroupModel.fromJson(Map<String, dynamic> json) => CookGroupModel(
    classId: json["classId"],
    name: json["name"],
    parentId: json["parentId"],
    weight: json["weight"],
    img: json["img"],
    children: List<CookGroupModel>.from(json["children"].map((x) => CookGroupModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "classId": classId,
    "name": name,
    "parentId": parentId,
    "weight": weight,
    "img": img,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
  };
}
