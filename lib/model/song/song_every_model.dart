// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
SongEveryModel songEveryModelFromJson(String str) => SongEveryModel.fromJson(json.decode(str));

String songEveryModelToJson(SongEveryModel data) => json.encode(data.toJson());

class SongEveryModel {
  SongEveryModel({
    required this.id,
    required this.type,
    required this.name,
     this.copywriter,
    required this.picUrl,
    required this.canDislike,
     this.trackNumberUpdateTime,
    required this.alg,
    required this.song,
  });

  int id;
  int type;
  SongEveryDay song;
  String name;
  dynamic copywriter;
  String picUrl;
  bool canDislike;
  dynamic trackNumberUpdateTime;
  String alg;

  factory SongEveryModel.fromJson(Map<String, dynamic> json) => SongEveryModel(
    id: json["id"] == null ? null : json["id"],
    song: SongEveryDay.fromJson(json['song']),
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? null : json["name"],
    copywriter: json["copywriter"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    canDislike: json["canDislike"] == null ? null : json["canDislike"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"],
    alg: json["alg"] == null ? null : json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "song": song.toJson(),
    "name": name == null ? null : name,
    "copywriter": copywriter,
    "picUrl": picUrl == null ? null : picUrl,
    "canDislike": canDislike == null ? null : canDislike,
    "trackNumberUpdateTime": trackNumberUpdateTime,
    "alg": alg == null ? null : alg,
  };
}



SongEveryDay songFromJson(String str) => SongEveryDay.fromJson(json.decode(str));

String songToJson(SongEveryDay data) => json.encode(data.toJson());

class SongEveryDay {
  SongEveryDay({
    required this.name,
    required this.id,
    required this.position,
    required this.alias,
    required this.status,
    required this.fee,
    required this.copyrightId,
    required this.disc,
    required this.no,
    required this.artists,
    required this.album,
    required this.starred,
    required this.popularity,
    required this.score,
    required this.starredNum,
    required this.duration,
    required this.playedNum,
    required this.dayPlays,
    required this.hearTime,
     this.sqMusic,
     this.hrMusic,
    required this.ringtone,
    required this.crbt,
    required this.audition,
    required this.copyFrom,
    required this.commentThreadId,
    required this.rtUrl,
    required this.ftype,
     this.rtUrls,
    required this.copyright,
    required this.transName,
    required this.sign,
    required this.mark,
    required this.originCoverType,
    required this.originSongSimpleData,
    required this.single,
    required this.noCopyrightRcmd,
    required this.rtype,
    required this.bMusic,
    required this.mp3Url,
    required this.hMusic,
    required this.mMusic,
    required this.lMusic,
    required this.mvid,
    required this.rurl,
    required this.exclusive,
    required this.privilege,
  });

  String name;
  int id;
  int position;
  List<String> alias;
  int status;
  int fee;
  int copyrightId;
  String disc;
  int no;
  List<Artist> artists;
  Album album;
  bool starred;
  int popularity;
  int score;
  int starredNum;
  int duration;
  int playedNum;
  int dayPlays;
  int hearTime;
  Music ? sqMusic;
  dynamic hrMusic;
  String ringtone;
  dynamic crbt;
  dynamic audition;
  String copyFrom;
  String commentThreadId;
  dynamic rtUrl;
  int ftype;
  List<dynamic> ? rtUrls;
  int copyright;
  dynamic transName;
  dynamic sign;
  int mark;
  int originCoverType;
  dynamic originSongSimpleData;
  int single;
  dynamic noCopyrightRcmd;
  int rtype;
  Music bMusic;
  dynamic mp3Url;
  Music ? hMusic;
  Music ? mMusic;
  Music ? lMusic;
  int mvid;
  dynamic rurl;
  bool exclusive;
  Privilege privilege;

  factory SongEveryDay.fromJson(Map<String, dynamic> json) => SongEveryDay(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    position: json["position"] == null ? null : json["position"],
    alias: List<String>.from(json["alias"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    fee: json["fee"] == null ? null : json["fee"],
    copyrightId: json["copyrightId"] == null ? null : json["copyrightId"],
    disc: json["disc"] == null ? null : json["disc"],
    no: json["no"] == null ? null : json["no"],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    album:Album.fromJson(json["album"]),
    starred: json["starred"] == null ? null : json["starred"],
    popularity: json["popularity"] == null ? null : json["popularity"],
    score: json["score"] == null ? null : json["score"],
    starredNum: json["starredNum"] == null ? null : json["starredNum"],
    duration: json["duration"] == null ? null : json["duration"],
    playedNum: json["playedNum"] == null ? null : json["playedNum"],
    dayPlays: json["dayPlays"] == null ? null : json["dayPlays"],
    hearTime: json["hearTime"] == null ? null : json["hearTime"],
    sqMusic:json["sqMusic"]==null?null:  Music.fromJson(json["sqMusic"]),
    hrMusic: json["hrMusic"],
    ringtone: json["ringtone"] == null ? null : json["ringtone"],
    crbt: json["crbt"],
    audition: json["audition"],
    copyFrom: json["copyFrom"] == null ? null : json["copyFrom"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    rtUrl: json["rtUrl"],
    ftype: json["ftype"] == null ? null : json["ftype"],
    rtUrls:json["rtUrls"]==null?null:List<dynamic>.from(json["rtUrls"].map((x) => x)),
    copyright: json["copyright"] == null ? null : json["copyright"],
    transName: json["transName"],
    sign: json["sign"],
    mark: json["mark"] == null ? null : json["mark"],
    originCoverType: json["originCoverType"] == null ? null : json["originCoverType"],
    originSongSimpleData: json["originSongSimpleData"],
    single: json["single"] == null ? null : json["single"],
    noCopyrightRcmd: json["noCopyrightRcmd"],
    rtype: json["rtype"] == null ? null : json["rtype"],
    bMusic:  Music.fromJson(json["bMusic"]),
    mp3Url: json["mp3Url"],
    hMusic:  Music.fromJson(json["hMusic"]),
    mMusic: Music.fromJson(json["mMusic"]),
    lMusic:  Music.fromJson(json["lMusic"]),
    mvid: json["mvid"] == null ? null : json["mvid"],
    rurl: json["rurl"],
    exclusive:  json["exclusive"],
    privilege:  Privilege.fromJson(json["privilege"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "position": position == null ? null : position,
    "alias": alias == null ? null : List<dynamic>.from(alias.map((x) => x)),
    "status": status == null ? null : status,
    "fee": fee == null ? null : fee,
    "copyrightId": copyrightId == null ? null : copyrightId,
    "disc": disc == null ? null : disc,
    "no": no == null ? null : no,
    "artists": artists == null ? null : List<dynamic>.from(artists.map((x) => x.toJson())),
    "album": album == null ? null : album.toJson(),
    "starred": starred == null ? null : starred,
    "popularity": popularity == null ? null : popularity,
    "score": score == null ? null : score,
    "starredNum": starredNum == null ? null : starredNum,
    "duration": duration == null ? null : duration,
    "playedNum": playedNum == null ? null : playedNum,
    "dayPlays": dayPlays == null ? null : dayPlays,
    "hearTime": hearTime == null ? null : hearTime,
    "sqMusic": sqMusic == null ? null : sqMusic!.toJson(),
    "hrMusic": hrMusic==null?null:hrMusic,
    "ringtone": ringtone == null ? null : ringtone,
    "crbt": crbt,
    "audition": audition,
    "copyFrom": copyFrom == null ? null : copyFrom,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "rtUrl": rtUrl,
    "ftype": ftype == null ? null : ftype,
    "rtUrls": rtUrls == null ? null : List<dynamic>.from(rtUrls!.map((x) => x)),
    "copyright": copyright == null ? null : copyright,
    "transName": transName,
    "sign": sign,
    "mark": mark == null ? null : mark,
    "originCoverType": originCoverType == null ? null : originCoverType,
    "originSongSimpleData": originSongSimpleData,
    "single": single == null ? null : single,
    "noCopyrightRcmd": noCopyrightRcmd,
    "rtype": rtype == null ? null : rtype,
    "bMusic": bMusic == null ? null : bMusic.toJson(),
    "mp3Url": mp3Url,
    "hMusic": hMusic == null ? null : hMusic!.toJson(),
    "mMusic": mMusic == null ? null : mMusic!.toJson(),
    "lMusic": lMusic == null ? null : lMusic!.toJson(),
    "mvid": mvid == null ? null : mvid,
    "rurl": rurl,
    "exclusive": exclusive == null ? null : exclusive,
    "privilege": privilege == null ? null : privilege.toJson(),
  };
}

class Album {
  Album({
     this.name,
    required this.id,
    required this.type,
    required this.size,
    required this.picId,
    required this.blurPicUrl,
    required this.companyId,
    required this.pic,
    required this.picUrl,
    required this.publishTime,
    required this.description,
    required this.tags,
    required this.company,
    required this.briefDesc,
     this.artist,
     this.songs,
     this.alias,
    required this.status,
    required this.copyrightId,
    required this.commentThreadId,
     this.artists,
    required this.subType,
     this.transName,
    required this.onSale,
    required this.mark,
    required this.gapless,
    required this.picIdStr,
  });

  String? name;
  int id;
  String ? type;
  int size;
  double picId;
  String ? blurPicUrl;
  int companyId;
  double pic;
  String picUrl;
  int publishTime;
  String description;
  String tags;
  String ? company;
  String ? briefDesc;
  Artist ? artist;
  List<dynamic> ? songs;
  List<dynamic> ? alias;
  int status;
  int copyrightId;
  String commentThreadId;
  List<Artist> ? artists;
  String ? subType;
  dynamic  transName;
  bool ? onSale;
  int ? mark;
  int ? gapless;
  String ? picIdStr;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    size: json["size"] == null ? null : json["size"],
    picId: json["picId"] == null ? null : json["picId"].toDouble(),
    blurPicUrl: json["blurPicUrl"] == null ? null : json["blurPicUrl"],
    companyId: json["companyId"] == null ? null : json["companyId"],
    pic: json["pic"] == null ? null : json["pic"].toDouble(),
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    description: json["description"] == null ? null : json["description"],
    tags: json["tags"] == null ? null : json["tags"],
    company: json["company"] == null ? null : json["company"],
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
    songs: json["songs"] == null ? null : List<dynamic>.from(json["songs"].map((x) => x)),
    alias: json["alias"] == null ? null : List<dynamic>.from(json["alias"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    copyrightId: json["copyrightId"] == null ? null : json["copyrightId"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    artists: json["artists"] == null ? null : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    subType: json["subType"] == null ? null : json["subType"],
    transName: json["transName"],
    onSale: json["onSale"] == null ? null : json["onSale"],
    mark: json["mark"] == null ? null : json["mark"],
    gapless: json["gapless"] == null ? null : json["gapless"],
    picIdStr: json["picId_str"] == null ? null : json["picId_str"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "size": size == null ? null : size,
    "picId": picId == null ? null : picId,
    "blurPicUrl": blurPicUrl == null ? null : blurPicUrl,
    "companyId": companyId == null ? null : companyId,
    "pic": pic == null ? null : pic,
    "picUrl": picUrl == null ? null : picUrl,
    "publishTime": publishTime == null ? null : publishTime,
    "description": description == null ? null : description,
    "tags": tags == null ? null : tags,
    "company": company == null ? null : company,
    "briefDesc": briefDesc == null ? null : briefDesc,
    "artist": artist == null ? null : artist!.toJson(),
    "songs": songs == null ? null : List<dynamic>.from(songs!.map((x) => x)),
    "alias": alias == null ? null : List<dynamic>.from(alias!.map((x) => x)),
    "status": status == null ? null : status,
    "copyrightId": copyrightId == null ? null : copyrightId,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "artists": artists == null ? null : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "subType": subType == null ? null : subType,
    "transName": transName,
    "onSale": onSale == null ? null : onSale,
    "mark": mark == null ? null : mark,
    "gapless": gapless == null ? null : gapless,
    "picId_str": picIdStr == null ? null : picIdStr,
  };
}

class Artist {
  Artist({
    required this.name,
    required this.id,
    required this.picId,
    required this.img1V1Id,
    required this.briefDesc,
    required this.picUrl,
    required this.img1V1Url,
    required this.albumSize,
     this.alias,
    required this.trans,
    required this.musicSize,
    required this.topicPerson,
  });

  String name;
  int id;
  int picId;
  int img1V1Id;
  String briefDesc;
  String picUrl;
  String img1V1Url;
  int albumSize;
  List<dynamic> ? alias;
  String trans;
  int musicSize;
  int topicPerson;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    picId: json["picId"] == null ? null : json["picId"],
    img1V1Id: json["img1v1Id"] == null ? null : json["img1v1Id"],
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    img1V1Url: json["img1v1Url"] == null ? null : json["img1v1Url"],
    albumSize: json["albumSize"] == null ? null : json["albumSize"],
    alias: json["alias"] == null ? null : List<dynamic>.from(json["alias"].map((x) => x)),
    trans: json["trans"] == null ? null : json["trans"],
    musicSize: json["musicSize"] == null ? null : json["musicSize"],
    topicPerson: json["topicPerson"] == null ? null : json["topicPerson"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "picId": picId == null ? null : picId,
    "img1v1Id": img1V1Id == null ? null : img1V1Id,
    "briefDesc": briefDesc == null ? null : briefDesc,
    "picUrl": picUrl == null ? null : picUrl,
    "img1v1Url": img1V1Url == null ? null : img1V1Url,
    "albumSize": albumSize == null ? null : albumSize,
    "alias": alias == null ? null : List<dynamic>.from(alias!.map((x) => x)),
    "trans": trans == null ? null : trans,
    "musicSize": musicSize == null ? null : musicSize,
    "topicPerson": topicPerson == null ? null : topicPerson,
  };
}

class Music {
  Music({
    required this.name,
    required this.id,
     this.size,
     this.extension,
     this.sr,
     this.dfsId,
     this.bitrate,
     this.playTime,
     this.volumeDelta,
  });

  dynamic name;
  int id;
  int ? size;
  String ?extension;
  int? sr;
  int? dfsId;
  int ?bitrate;
  int? playTime;
  int ?volumeDelta;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    name: json["name"],
    id: json["id"] == null ? null : json["id"],
    size: json["size"] == null ? null : json["size"],
    extension: json["extension"] == null ? null : json["extension"],
    sr: json["sr"] == null ? null : json["sr"],
    dfsId: json["dfsId"] == null ? null : json["dfsId"],
    bitrate: json["bitrate"] == null ? null : json["bitrate"],
    playTime: json["playTime"] == null ? null : json["playTime"],
    volumeDelta: json["volumeDelta"] == null ? null : json["volumeDelta"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id == null ? null : id,
    "size": size == null ? null : size,
    "extension": extension == null ? null : extension,
    "sr": sr == null ? null : sr,
    "dfsId": dfsId == null ? null : dfsId,
    "bitrate": bitrate == null ? null : bitrate,
    "playTime": playTime == null ? null : playTime,
    "volumeDelta": volumeDelta == null ? null : volumeDelta,
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
    required this.maxBrLevel,
    required this.playMaxBrLevel,
    required this.downloadMaxBrLevel,
    required this.plLevel,
    required this.dlLevel,
    required this.flLevel,
    required this.rscl,
     this.freeTrialPrivilege,
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
  String maxBrLevel;
  String playMaxBrLevel;
  String downloadMaxBrLevel;
  String plLevel;
  String dlLevel;
  String flLevel;
  dynamic rscl;
  FreeTrialPrivilege ? freeTrialPrivilege;
  List<ChargeInfoList> ? chargeInfoList;

  factory Privilege.fromJson(Map<String, dynamic> json) => Privilege(
    id: json["id"] == null ? null : json["id"],
    fee: json["fee"] == null ? null : json["fee"],
    payed: json["payed"] == null ? null : json["payed"],
    st: json["st"] == null ? null : json["st"],
    pl: json["pl"] == null ? null : json["pl"],
    dl: json["dl"] == null ? null : json["dl"],
    sp: json["sp"] == null ? null : json["sp"],
    cp: json["cp"] == null ? null : json["cp"],
    subp: json["subp"] == null ? null : json["subp"],
    cs: json["cs"] == null ? null : json["cs"],
    maxbr: json["maxbr"] == null ? null : json["maxbr"],
    fl: json["fl"] == null ? null : json["fl"],
    toast: json["toast"] == null ? null : json["toast"],
    flag: json["flag"] == null ? null : json["flag"],
    preSell: json["preSell"] == null ? null : json["preSell"],
    playMaxbr: json["playMaxbr"] == null ? null : json["playMaxbr"],
    downloadMaxbr: json["downloadMaxbr"] == null ? null : json["downloadMaxbr"],
    maxBrLevel: json["maxBrLevel"] == null ? null : json["maxBrLevel"],
    playMaxBrLevel: json["playMaxBrLevel"] == null ? null : json["playMaxBrLevel"],
    downloadMaxBrLevel: json["downloadMaxBrLevel"] == null ? null : json["downloadMaxBrLevel"],
    plLevel: json["plLevel"] == null ? null : json["plLevel"],
    dlLevel: json["dlLevel"] == null ? null : json["dlLevel"],
    flLevel: json["flLevel"] == null ? null : json["flLevel"],
    rscl: json["rscl"],
    freeTrialPrivilege: json["freeTrialPrivilege"] == null ? null : FreeTrialPrivilege.fromJson(json["freeTrialPrivilege"]),
    chargeInfoList: json["chargeInfoList"] == null ? null : List<ChargeInfoList>.from(json["chargeInfoList"].map((x) => ChargeInfoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "fee": fee == null ? null : fee,
    "payed": payed == null ? null : payed,
    "st": st == null ? null : st,
    "pl": pl == null ? null : pl,
    "dl": dl == null ? null : dl,
    "sp": sp == null ? null : sp,
    "cp": cp == null ? null : cp,
    "subp": subp == null ? null : subp,
    "cs": cs == null ? null : cs,
    "maxbr": maxbr == null ? null : maxbr,
    "fl": fl == null ? null : fl,
    "toast": toast == null ? null : toast,
    "flag": flag == null ? null : flag,
    "preSell": preSell == null ? null : preSell,
    "playMaxbr": playMaxbr == null ? null : playMaxbr,
    "downloadMaxbr": downloadMaxbr == null ? null : downloadMaxbr,
    "maxBrLevel": maxBrLevel == null ? null : maxBrLevel,
    "playMaxBrLevel": playMaxBrLevel == null ? null : playMaxBrLevel,
    "downloadMaxBrLevel": downloadMaxBrLevel == null ? null : downloadMaxBrLevel,
    "plLevel": plLevel == null ? null : plLevel,
    "dlLevel": dlLevel == null ? null : dlLevel,
    "flLevel": flLevel == null ? null : flLevel,
    "rscl": rscl,
    "freeTrialPrivilege": freeTrialPrivilege == null ? null : freeTrialPrivilege!.toJson(),
    "chargeInfoList": chargeInfoList == null ? null : List<dynamic>.from(chargeInfoList!.map((x) => x.toJson())),
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
    rate: json["rate"] == null ? null : json["rate"],
    chargeUrl: json["chargeUrl"],
    chargeMessage: json["chargeMessage"],
    chargeType: json["chargeType"] == null ? null : json["chargeType"],
  );

  Map<String, dynamic> toJson() => {
    "rate": rate == null ? null : rate,
    "chargeUrl": chargeUrl,
    "chargeMessage": chargeMessage,
    "chargeType": chargeType == null ? null : chargeType,
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

