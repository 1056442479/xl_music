// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SongListDetails songListDetailsFromJson(String str) => SongListDetails.fromJson(json.decode(str));

String songListDetailsToJson(SongListDetails data) => json.encode(data.toJson());

///歌单详情
class SongListDetails {
  SongListDetails({
    required this.songs,
    required this.privileges,
    required this.code,
  });

  List<Song> songs;
  List<Privilege> privileges;
  int code;

  factory SongListDetails.fromJson(Map<String, dynamic> json) => SongListDetails(
    songs: List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
    privileges: List<Privilege>.from(json["privileges"].map((x) => Privilege.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
    "privileges": List<dynamic>.from(privileges.map((x) => x.toJson())),
    "code": code,
  };
}

class Privilege {
  Privilege({
    required this.id,
    required this.fee,
    required this.payed,
    required this.st,
    required this.pl,
    required this.dl,
    required this.sp,
    required this.cp,
    required this.subp,
    required this.cs,
    required this.maxbr,
    required this.fl,
    required this.toast,
    required this.flag,
    required this.preSell,
    required this.playMaxbr,
    required this.downloadMaxbr,
//    required this.maxBrLevel,
//    required this.playMaxBrLevel,
//    required this.downloadMaxBrLevel,
//    required this.plLevel,
//    required this.dlLevel,
//    required this.flLevel,
    required this.rscl,
    required this.freeTrialPrivilege,
     this.chargeInfoList,
  });

  int id;
  int fee;
  int payed;
  int st;
  int pl;
  int dl;
  int sp;
  int cp;
  int subp;
  bool cs;
  int maxbr;
  int fl;
  bool toast;
  int flag;
  bool preSell;
  int playMaxbr;
  int downloadMaxbr;
//  MaxBrLevel maxBrLevel;
//  MaxBrLevel playMaxBrLevel;
//  MaxBrLevel downloadMaxBrLevel;
//  LLevel plLevel;
//  DlLevel dlLevel;
//  LLevel flLevel;
  dynamic rscl;
  FreeTrialPrivilege freeTrialPrivilege;
  List<ChargeInfoList> ? chargeInfoList;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
    id: json["id"],
    fee: json["fee"],
    payed: json["payed"],
    st: json["st"],
    pl: json["pl"],
    dl: json["dl"],
    sp: json["sp"],
    cp: json["cp"],
    subp: json["subp"],
    cs: json["cs"],
    maxbr: json["maxbr"],
    fl: json["fl"],
    toast: json["toast"],
    flag: json["flag"],
    preSell: json["preSell"],
    playMaxbr: json["playMaxbr"],
    downloadMaxbr: json["downloadMaxbr"],
//    maxBrLevel: maxBrLevelValues.map[json["maxBrLevel"]],
//    playMaxBrLevel: maxBrLevelValues.map[json["playMaxBrLevel"]],
//    downloadMaxBrLevel: maxBrLevelValues.map[json["downloadMaxBrLevel"]],
//    plLevel: lLevelValues.map[json["plLevel"]],
//    dlLevel: dlLevelValues.map[json["dlLevel"]],
//    flLevel: lLevelValues.map[json["flLevel"]],
    rscl: json["rscl"],
    freeTrialPrivilege: FreeTrialPrivilege.fromJson(json["freeTrialPrivilege"]),
    chargeInfoList: json["chargeInfoList"]==null?null: List<ChargeInfoList>.from(json["chargeInfoList"].map((x) => ChargeInfoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fee": fee,
    "payed": payed,
    "st": st,
    "pl": pl,
    "dl": dl,
    "sp": sp,
    "cp": cp,
    "subp": subp,
    "cs": cs,
    "maxbr": maxbr,
    "fl": fl,
    "toast": toast,
    "flag": flag,
    "preSell": preSell,
    "playMaxbr": playMaxbr,
    "downloadMaxbr": downloadMaxbr,
//    "maxBrLevel": maxBrLevelValues.reverse[maxBrLevel],
//    "playMaxBrLevel": maxBrLevelValues.reverse[playMaxBrLevel],
//    "downloadMaxBrLevel": maxBrLevelValues.reverse[downloadMaxBrLevel],
//    "plLevel": lLevelValues.reverse[plLevel],
//    "dlLevel": dlLevelValues.reverse[dlLevel],
//    "flLevel": lLevelValues.reverse[flLevel],
    "rscl": rscl,
    "freeTrialPrivilege": freeTrialPrivilege.toJson(),
    "chargeInfoList":chargeInfoList==null?null: List<dynamic>.from(chargeInfoList!.map((x) => x.toJson())),
  };
}

class ChargeInfoList {
  ChargeInfoList({
    required this.rate,
    required this.chargeUrl,
    required this.chargeMessage,
    required this.chargeType,
  });

  int rate;
  dynamic chargeUrl;
  dynamic chargeMessage;
  int chargeType;

  factory ChargeInfoList.fromJson(Map<String, dynamic> json) => ChargeInfoList(
    rate: json["rate"],
    chargeUrl: json["chargeUrl"],
    chargeMessage: json["chargeMessage"],
    chargeType: json["chargeType"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate,
    "chargeUrl": chargeUrl,
    "chargeMessage": chargeMessage,
    "chargeType": chargeType,
  };
}


class FreeTrialPrivilege {
  FreeTrialPrivilege({
    required this.resConsumable,
    required this.userConsumable,
    required this.listenType,
  });

  bool resConsumable;
  bool userConsumable;
  dynamic listenType;

  factory FreeTrialPrivilege.fromJson(Map<String, dynamic> json) => FreeTrialPrivilege(
    resConsumable: json["resConsumable"],
    userConsumable: json["userConsumable"],
    listenType: json["listenType"],
  );

  Map<String, dynamic> toJson() => {
    "resConsumable": resConsumable,
    "userConsumable": userConsumable,
    "listenType": listenType,
  };
}

///[rtype] -1:那么表示播放的本地文件，自己定义的
class Song {
  Song({
    required this.name,
    required this.id,
     this.pst,
     this.t,
    required this.ar,
     this.alia,
     this.pop,
     this.st,
//    required this.rt,
    required this.fee,
     this.v,
     this.crbt,
     this.cf,
    required this.al,
    required this.dt,
     this.h,
     this.m,
     this.l,
     this.sq,
     this.hr,
     this.a,
     this.cd,
     this.no,
     this.rtUrl,
     this.ftype,
     this.rtUrls,
     this.djId,
     this.copyright,
     this.sId,
     this.mark,
     this.originCoverType,
     this.originSongSimpleData,
     this.tagPicList,
     this.resourceState,
     this.version,
     this.songJumpInfo,
     this.entertainmentTags,
     this.awardTags,
     this.single,
     this.noCopyrightRcmd,
     this.rtype,
     this.rurl,
     this.mst,
     this.cp,
    required this.mv,
     this.publishTime,
//    required this.tns,
  });

  String name;
  int id;
  int ? pst;
  int ? t;
  List<Ar> ar;
  List<String> ? alia;
  int ? pop;
  int ? st;
//  Rt rt;
  int fee;
  int ? v;
  dynamic crbt;
  String ? cf;
  Al al;
  int dt;
  H ? h;
  H ? m;
  H ? l;
  H ? sq;
  H ? hr;
  dynamic a;
  String ? cd;
  int ? no;
  dynamic  rtUrl;
  int ? ftype;
  List<dynamic> ? rtUrls;
  int ? djId;
  int ? copyright;
  int ? sId;
  int ? mark;
  int ? originCoverType;
  OriginSongSimpleData ? originSongSimpleData;
  dynamic tagPicList;
  bool ? resourceState;
  int ? version;
  dynamic songJumpInfo;
  dynamic entertainmentTags;
  dynamic  awardTags;
  int ? single;
  dynamic noCopyrightRcmd;
  int ? rtype;
  dynamic rurl;
  int ? mst;
  int ? cp;
  int mv;
  int ? publishTime;
//  List<String> tns;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
    name: json["name"]==null?"佚名": json["name"],
    id: json["id"],
    pst: json["pst"],
    t: json["t"],
    ar: List<Ar>.from(json["ar"].map((x) => Ar.fromJson(x))),
    alia:json["alia"]==null?null: List<String>.from(json["alia"].map((x) => x)),
    pop: json["pop"],
    st: json["st"],
//    rt: json["rt"] == null ? null : rtValues.map[json["rt"]],
    fee: json["fee"],
    v: json["v"],
    crbt: json["crbt"],
    cf: json["cf"],
    al: Al.fromJson(json["al"]),
    dt: json["dt"],
    h:json["h"]==null?null: H.fromJson(json["h"]),
    m: json["m"]==null?null: H.fromJson(json["m"]),
    l:json["l"]==null?null: H.fromJson(json["l"]),
    sq: json["sq"] == null ? null : H.fromJson(json["sq"]),
    hr: json["hr"] == null ? null : H.fromJson(json["hr"]),
    a: json["a"],
    cd: json["cd"],
    no: json["no"],
    rtUrl: json["rtUrl"],
    ftype: json["ftype"],
    rtUrls:json["rtUrls"]==null?null: List<dynamic>.from(json["rtUrls"].map((x) => x)),
    djId: json["djId"],
    copyright: json["copyright"] ?? null,
    sId: json["s_id"] ?? null,
    mark: json["mark"] ?? null,
    originCoverType: json["originCoverType"] ?? null,
    originSongSimpleData: json["originSongSimpleData"]==null?null: OriginSongSimpleData.fromJson(json["originSongSimpleData"]) ,
    tagPicList: json["tagPicList"],
    resourceState: json["resourceState"] ?? null,
    version: json["version"] ?? null,
    songJumpInfo: json["songJumpInfo"],
    entertainmentTags: json["entertainmentTags"],
    awardTags: json["awardTags"] ?? null,
    single: json["single"] ?? null,
    noCopyrightRcmd: json["noCopyrightRcmd"],
    rtype: json["rtype"],
    rurl: json["rurl"],
    mst: json["mst"],
    cp: json["cp"],
    mv: json["mv"],
    publishTime: json["publishTime"] ?? null,

//    sq: null,
//    tns: List<String>.from(json["tns"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name ,
    "id": id,
    "pst": pst,
    "t": t,
    "ar": List<dynamic>.from(ar.map((x) => x.toJson())),
    "alia": alia==null?null: List<dynamic>.from(alia!.map((x) => x)),
    "pop": pop,
    "st": st,
//    "rt": rt == null ? null : rtValues.reverse[rt],
    "fee": fee,
    "v": v,
    "crbt": crbt,
    "cf": cf,
    "al": al.toJson(),
    "dt": dt,
    "h": h==null?null: h!.toJson(),
    "m": m==null?null: m!.toJson(),
    "l": l==null?null: l!.toJson(),
    "sq": null,
    "hr": hr == null ? null : hr!.toJson(),
    "a": a,
    "cd": cd,
    "no": no,
    "rtUrl": rtUrl,
    "ftype": ftype,
    "rtUrls":rtUrls==null?null: List<dynamic>.from(rtUrls!.map((x) => x)),
    "djId": djId,
    "copyright": copyright ?? null,
    "s_id": sId ?? null,
    "mark": mark ?? null,
    "originCoverType": originCoverType ?? null,
    "originSongSimpleData": originSongSimpleData == null ? null : originSongSimpleData!.toJson(),
    "tagPicList": tagPicList,
    "resourceState": resourceState ?? null,
    "version": version ?? null,
    "songJumpInfo": songJumpInfo,
    "entertainmentTags": entertainmentTags,
    "awardTags": awardTags ?? null,
    "single": single ?? null,
    "noCopyrightRcmd": noCopyrightRcmd,
    "rtype": rtype,
    "rurl": rurl,
    "mst": mst,
    "cp": cp,
    "mv": mv,
    "publishTime": publishTime ?? null,
//    "tns": tns == null ? null : List<dynamic>.from(tns.map((x) => x)),
  };
}

class Al {
  Al({
    required this.id,
    required this.name,
     this.picUrl,
     this.tns,
     this.picStr,
    required this.pic,
  });

  int id;
  String name;
  String ? picUrl;
  List<String> ? tns;
  String ? picStr;
  double pic;

  factory Al.fromJson(Map<String, dynamic> json) => Al(
    id: json["id"],
    name: json["name"],
    picUrl: json["picUrl"],
    tns: json["tns"]==null?null: List<String>.from(json["tns"]!.map((x) => x)),
    picStr: json["pic_str"] == null ? null : json["pic_str"]!,
    pic: json["pic"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picUrl": picUrl,
    "tns": tns==null?null:List<dynamic>.from(tns!.map((x) => x)),
    "pic_str": picStr == null ? null : picStr!,
    "pic": pic,
  };
}

class Ar {
  Ar({
    required this.id,
    required this.name,
     this.tns,
     this.alias,
  });

  int id;
  String name;
  List<dynamic> ? tns;
  List<dynamic> ? alias;

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
    id: json["id"],
    name: json["name"],
    tns: json["tns"]==null?null: List<dynamic>.from(json["tns"].map((x) => x)),
    alias:json["alias"]==null?null: List<dynamic>.from(json["alias"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "tns":  tns==null?null: List<dynamic>.from(tns!.map((x) => x)),
    "alias":alias ==null?null: List<dynamic>.from(alias!.map((x) => x)),
  };
}

class H {
  H({
    required this.br,
    required this.fid,
    required this.size,
    required this.vd,
    required this.sr,
  });

  dynamic br;
  dynamic fid;
  dynamic size;
  dynamic vd;
  int ? sr;

  factory H.fromJson(Map<String, dynamic> json) => H(
    br: json["br"],
    fid: json["fid"],
    size: json["size"],
    vd: json["vd"],
    sr: json["sr"],
  );

  Map<String, dynamic> toJson() => {
    "br": br,
    "fid": fid,
    "size": size,
    "vd": vd,
    "sr": sr,
  };
}

class OriginSongSimpleData {
  OriginSongSimpleData({
    required this.songId,
     this.name,
    required this.artists,
    required this.albumMeta,
  });

  int songId;
  String ? name;
  List<AlbumMeta> artists;
  AlbumMeta albumMeta;

  factory OriginSongSimpleData.fromJson(Map<String, dynamic> json) => OriginSongSimpleData(
    songId: json["songId"],
    name: json["name"],
    artists: List<AlbumMeta>.from(json["artists"].map((x) => AlbumMeta.fromJson(x))),
    albumMeta: AlbumMeta.fromJson(json["albumMeta"]),
  );

  Map<String, dynamic> toJson() => {
    "songId": songId,
    "name": name,
    "artists": List<dynamic>.from(artists.map((x) => x.toJson())),
    "albumMeta": albumMeta.toJson(),
  };
}

class AlbumMeta {
  AlbumMeta({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory AlbumMeta.fromJson(Map<String, dynamic> json) => AlbumMeta(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

