
import 'dart:convert';

DjCateListModel djCateListModelFromJson(String str) => DjCateListModel.fromJson(json.decode(str));

String djCateListModelToJson(DjCateListModel data) => json.encode(data.toJson());

///电台分类列表
class DjCateListModel {
  DjCateListModel({
    required this.pic56X56IdStr,
    required this.pic56X56Url,
    required this.pic96X96IdStr,
    required this.pic96X96Url,
    required this.pic84X84IdUrl,
    required this.picPcWhiteStr,
    required this.picPcWhiteUrl,
    required this.picPcBlackStr,
    required this.picPcBlackUrl,
    required this.picWebStr,
    required this.picWebUrl,
    required this.picMacId,
    required this.picMacUrl,
    required this.picUwpId,
    required this.picUwpUrl,
    required this.picIPadStr,
    required this.picIPadUrl,
    required this.picPcWhite,
    required this.picPcBlack,
    required this.picWeb,
    required this.picIPad,
    required this.pic84X84Id,
    required this.pic56X56Id,
    required this.pic96X96Id,
    required this.name,
    required this.id,
  });

  String pic56X56IdStr;
  String pic56X56Url;
  String pic96X96IdStr;
  String pic96X96Url;
  String pic84X84IdUrl;
  String picPcWhiteStr;
  String picPcWhiteUrl;
  String picPcBlackStr;
  String picPcBlackUrl;
  String picWebStr;
  String picWebUrl;
  String picMacId;
  String picMacUrl;
  String picUwpId;
  String picUwpUrl;
  String picIPadStr;
  String picIPadUrl;
  double picPcWhite;
  double picPcBlack;
  double picWeb;
  double picIPad;
  double pic84X84Id;
  double pic56X56Id;
  double pic96X96Id;
  String name;
  int id;

  factory DjCateListModel.fromJson(Map<String, dynamic> json) => DjCateListModel(
    pic56X56IdStr: json["pic56x56IdStr"] == null ? null : json["pic56x56IdStr"],
    pic56X56Url: json["pic56x56Url"] == null ? null : json["pic56x56Url"],
    pic96X96IdStr: json["pic96x96IdStr"] == null ? null : json["pic96x96IdStr"],
    pic96X96Url: json["pic96x96Url"] == null ? null : json["pic96x96Url"],
    pic84X84IdUrl: json["pic84x84IdUrl"] == null ? null : json["pic84x84IdUrl"],
    picPcWhiteStr: json["picPCWhiteStr"] == null ? null : json["picPCWhiteStr"],
    picPcWhiteUrl: json["picPCWhiteUrl"] == null ? null : json["picPCWhiteUrl"],
    picPcBlackStr: json["picPCBlackStr"] == null ? null : json["picPCBlackStr"],
    picPcBlackUrl: json["picPCBlackUrl"] == null ? null : json["picPCBlackUrl"],
    picWebStr: json["picWebStr"] == null ? null : json["picWebStr"],
    picWebUrl: json["picWebUrl"] == null ? null : json["picWebUrl"],
    picMacId: json["picMacId"] == null ? null : json["picMacId"],
    picMacUrl: json["picMacUrl"] == null ? null : json["picMacUrl"],
    picUwpId: json["picUWPId"] == null ? null : json["picUWPId"],
    picUwpUrl: json["picUWPUrl"] == null ? null : json["picUWPUrl"],
    picIPadStr: json["picIPadStr"] == null ? null : json["picIPadStr"],
    picIPadUrl: json["picIPadUrl"] == null ? null : json["picIPadUrl"],
    picPcWhite: json["picPCWhite"] == null ? null : json["picPCWhite"].toDouble(),
    picPcBlack: json["picPCBlack"] == null ? null : json["picPCBlack"].toDouble(),
    picWeb: json["picWeb"] == null ? null : json["picWeb"].toDouble(),
    picIPad: json["picIPad"] == null ? null : json["picIPad"].toDouble(),
    pic84X84Id: json["pic84x84Id"] == null ? null : json["pic84x84Id"].toDouble(),
    pic56X56Id: json["pic56x56Id"] == null ? null : json["pic56x56Id"].toDouble(),
    pic96X96Id: json["pic96x96Id"] == null ? null : json["pic96x96Id"].toDouble(),
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "pic56x56IdStr": pic56X56IdStr == null ? null : pic56X56IdStr,
    "pic56x56Url": pic56X56Url == null ? null : pic56X56Url,
    "pic96x96IdStr": pic96X96IdStr == null ? null : pic96X96IdStr,
    "pic96x96Url": pic96X96Url == null ? null : pic96X96Url,
    "pic84x84IdUrl": pic84X84IdUrl == null ? null : pic84X84IdUrl,
    "picPCWhiteStr": picPcWhiteStr == null ? null : picPcWhiteStr,
    "picPCWhiteUrl": picPcWhiteUrl == null ? null : picPcWhiteUrl,
    "picPCBlackStr": picPcBlackStr == null ? null : picPcBlackStr,
    "picPCBlackUrl": picPcBlackUrl == null ? null : picPcBlackUrl,
    "picWebStr": picWebStr == null ? null : picWebStr,
    "picWebUrl": picWebUrl == null ? null : picWebUrl,
    "picMacId": picMacId == null ? null : picMacId,
    "picMacUrl": picMacUrl == null ? null : picMacUrl,
    "picUWPId": picUwpId == null ? null : picUwpId,
    "picUWPUrl": picUwpUrl == null ? null : picUwpUrl,
    "picIPadStr": picIPadStr == null ? null : picIPadStr,
    "picIPadUrl": picIPadUrl == null ? null : picIPadUrl,
    "picPCWhite": picPcWhite == null ? null : picPcWhite,
    "picPCBlack": picPcBlack == null ? null : picPcBlack,
    "picWeb": picWeb == null ? null : picWeb,
    "picIPad": picIPad == null ? null : picIPad,
    "pic84x84Id": pic84X84Id == null ? null : pic84X84Id,
    "pic56x56Id": pic56X56Id == null ? null : pic56X56Id,
    "pic96x96Id": pic96X96Id == null ? null : pic96X96Id,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
  };
}
