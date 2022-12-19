
import 'dart:convert';

DjCategoryListModel djCategoryListModelFromJson(String str) => DjCategoryListModel.fromJson(json.decode(str));

String djCategoryListModelToJson(DjCategoryListModel data) => json.encode(data.toJson());

class DjCategoryListModel {
  DjCategoryListModel({
    required this.categoryId,
    required this.categoryName,
    required this.radios,
  });

  int categoryId;
  String categoryName;
  List<Radio> radios;

  factory DjCategoryListModel.fromJson(Map<String, dynamic> json) => DjCategoryListModel(
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    categoryName: json["categoryName"] == null ? null : json["categoryName"],
    radios: List<Radio>.from(json["radios"].map((x) => Radio.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId == null ? null : categoryId,
    "categoryName": categoryName == null ? null : categoryName,
    "radios": radios == null ? null : List<dynamic>.from(radios.map((x) => x.toJson())),
  };
}

class Radio {
  Radio({
    required this.id,
    required this.name,
    required this.rcmdText,
    required this.radioFeeType,
    required this.feeScope,
    required this.picUrl,
    required this.programCount,
    required this.subCount,
    required this.subed,
    required this.playCount,
    required this.alg,
    required this.originalPrice,
    required this.discountPrice,
    required this.lastProgramName,
    required this.traceId,
    required this.icon,
  });

  int id;
  String name;
  String rcmdText;
  int radioFeeType;
  int feeScope;
  String picUrl;
  int programCount;
  int subCount;
  bool subed;
  int playCount;
  String alg;
  dynamic originalPrice;
  dynamic discountPrice;
  String lastProgramName;
  dynamic traceId;
  Icon ? icon;

  factory Radio.fromJson(Map<String, dynamic> json) => Radio(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    rcmdText: json["rcmdText"] == null ? null : json["rcmdText"],
    radioFeeType: json["radioFeeType"] == null ? null : json["radioFeeType"],
    feeScope: json["feeScope"] == null ? null : json["feeScope"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    programCount: json["programCount"] == null ? null : json["programCount"],
    subCount: json["subCount"] == null ? null : json["subCount"],
    subed: json["subed"] == null ? null : json["subed"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    alg: json["alg"] == null ? null : json["alg"],
    originalPrice: json["originalPrice"],
    discountPrice: json["discountPrice"],
    lastProgramName: json["lastProgramName"] == null ? null : json["lastProgramName"],
    traceId: json["traceId"],
    icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "rcmdText": rcmdText == null ? null : rcmdText,
    "radioFeeType": radioFeeType == null ? null : radioFeeType,
    "feeScope": feeScope == null ? null : feeScope,
    "picUrl": picUrl == null ? null : picUrl,
    "programCount": programCount == null ? null : programCount,
    "subCount": subCount == null ? null : subCount,
    "subed": subed == null ? null : subed,
    "playCount": playCount == null ? null : playCount,
    "alg": alg == null ? null : alg,
    "originalPrice": originalPrice,
    "discountPrice": discountPrice,
    "lastProgramName": lastProgramName == null ? null : lastProgramName,
    "traceId": traceId,
    "icon": icon == null ? null : icon!.toJson(),
  };
}

class Icon {
  Icon({
    required this.type,
    required this.value,
    required this.color,
  });

  String type;
  String value;
  String color;

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
    type: json["type"] == null ? null : json["type"],
    value: json["value"] == null ? null : json["value"],
    color: json["color"] == null ? null : json["color"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "value": value == null ? null : value,
    "color": color == null ? null : color,
  };
}
