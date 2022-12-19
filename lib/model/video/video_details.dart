
import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';

VideoDetailsModel welcomeFromJson(String str) => VideoDetailsModel.fromJson(json.decode(str));

String welcomeToJson(VideoDetailsModel data) => json.encode(data.toJson());

class VideoDetailsModel {
  VideoDetailsModel({
    required this.type,
    required this.displayed,
    required this.alg,
    required this.extAlg,
    required this.data,
  });

  int type;
  bool displayed;
  String alg;
  dynamic extAlg;
  Data data;

  factory VideoDetailsModel.fromJson(Map<String, dynamic> json) => VideoDetailsModel(
    type: json["type"] == null ? null : json["type"],
    displayed: json["displayed"] == null ? null : json["displayed"],
    alg: json["alg"] == null ? null : json["alg"],
    extAlg: json["extAlg"],
    data:  Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "displayed": displayed == null ? null : displayed,
    "alg": alg == null ? null : alg,
    "extAlg": extAlg,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    required this.alg,
    required this.scm,
    required this.threadId,
    required this.coverUrl,
    required this.height,
    required this.width,
    required this.title,
    required this.description,
    required this.commentCount,
    required this.shareCount,
    required this.resolutions,
    required this.creator,
    required this.urlInfo,
    required this.videoGroup,
    required this.previewUrl,
    required this.previewDurationms,
    required this.hasRelatedGameAd,
    required this.markTypes,
    required this.relateSong,
    required this.relatedInfo,
    required this.videoUserLiveInfo,
    required this.vid,
    required this.durationms,
    required this.playTime,
    required this.praisedCount,
    required this.praised,
    required this.subscribed,
  });

  String alg;
  String scm;
  String threadId;
  String coverUrl;
  int height;
  int width;
  String title;
  String ? description;
  int commentCount;
  int shareCount;
  List<Resolution> resolutions;
  Creator creator;
  dynamic urlInfo;
  List<VideoGroup> videoGroup;
  String ? previewUrl;
  int previewDurationms;
  bool hasRelatedGameAd;
  dynamic markTypes;
  List<RelateSong> relateSong;
  dynamic relatedInfo;
  dynamic videoUserLiveInfo;
  String ? vid;
  int durationms;
  int playTime;
  int praisedCount;
  bool praised;
  bool subscribed;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    alg: json["alg"] == null ? null : json["alg"],
    scm: json["scm"] == null ? null : json["scm"],
    threadId: json["threadId"] == null ? null : json["threadId"],
    coverUrl: json["coverUrl"] == null ? null : json["coverUrl"],
    height: json["height"] == null ? null : json["height"],
    width: json["width"] == null ? null : json["width"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
    shareCount: json["shareCount"] == null ? null : json["shareCount"],
    resolutions:  List<Resolution>.from(json["resolutions"].map((x) => Resolution.fromJson(x))),
    creator: Creator.fromJson(json["creator"]),
    urlInfo: json["urlInfo"],
    videoGroup:List<VideoGroup>.from(json["videoGroup"].map((x) => VideoGroup.fromJson(x))),
    previewUrl: json["previewUrl"] == null ? null : json["previewUrl"],
    previewDurationms: json["previewDurationms"] == null ? null : json["previewDurationms"],
    hasRelatedGameAd: json["hasRelatedGameAd"] == null ? null : json["hasRelatedGameAd"],
    markTypes: json["markTypes"],
    relateSong:  List<RelateSong>.from(json["relateSong"].map((x) => RelateSong.fromJson(x))),
    relatedInfo: json["relatedInfo"],
    videoUserLiveInfo: json["videoUserLiveInfo"],
    vid: json["vid"] == null ? null : json["vid"],
    durationms: json["durationms"] == null ? null : json["durationms"],
    playTime: json["playTime"] == null ? null : json["playTime"],
    praisedCount: json["praisedCount"] == null ? null : json["praisedCount"],
    praised: json["praised"] == null ? null : json["praised"],
    subscribed: json["subscribed"] == null ? null : json["subscribed"],
  );

  Map<String, dynamic> toJson() => {
    "alg": alg == null ? null : alg,
    "scm": scm == null ? null : scm,
    "threadId": threadId == null ? null : threadId,
    "coverUrl": coverUrl == null ? null : coverUrl,
    "height": height == null ? null : height,
    "width": width == null ? null : width,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "commentCount": commentCount == null ? null : commentCount,
    "shareCount": shareCount == null ? null : shareCount,
    "resolutions": resolutions == null ? null : List<dynamic>.from(resolutions.map((x) => x.toJson())),
    "creator": creator == null ? null : creator.toJson(),
    "urlInfo": urlInfo,
    "videoGroup": videoGroup == null ? null : List<dynamic>.from(videoGroup.map((x) => x.toJson())),
    "previewUrl": previewUrl == null ? null : previewUrl,
    "previewDurationms": previewDurationms == null ? null : previewDurationms,
    "hasRelatedGameAd": hasRelatedGameAd == null ? null : hasRelatedGameAd,
    "markTypes": markTypes,
    "relateSong": relateSong == null ? null : List<dynamic>.from(relateSong.map((x) => x.toJson())),
    "relatedInfo": relatedInfo,
    "videoUserLiveInfo": videoUserLiveInfo,
    "vid": vid == null ? null : vid,
    "durationms": durationms == null ? null : durationms,
    "playTime": playTime == null ? null : playTime,
    "praisedCount": praisedCount == null ? null : praisedCount,
    "praised": praised == null ? null : praised,
    "subscribed": subscribed == null ? null : subscribed,
  };
}

class Creator {
  Creator({
    required this.defaultAvatar,
    required this.province,
    required this.authStatus,
    required this.followed,
    required this.avatarUrl,
    required this.accountStatus,
    required this.gender,
    required this.city,
    required this.birthday,
    required this.userId,
    required this.userType,
    required this.nickname,
    required this.signature,
    required this.description,
    required this.detailDescription,
    required this.avatarImgId,
    required this.backgroundImgId,
    required this.backgroundUrl,
    required this.authority,
    required this.mutual,
    required this.expertTags,
    required this.experts,
    required this.djStatus,
    required this.vipType,
    required this.remarkName,
    required this.backgroundImgIdStr,
    required this.avatarImgIdStr,
  });

  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  double avatarImgId;
  double backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  String backgroundImgIdStr;
  String avatarImgIdStr;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    defaultAvatar: json["defaultAvatar"] == null ? null : json["defaultAvatar"],
    province: json["province"] == null ? null : json["province"],
    authStatus: json["authStatus"] == null ? null : json["authStatus"],
    followed: json["followed"] == null ? null : json["followed"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    accountStatus: json["accountStatus"] == null ? null : json["accountStatus"],
    gender: json["gender"] == null ? null : json["gender"],
    city: json["city"] == null ? null : json["city"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    userId: json["userId"] == null ? null : json["userId"],
    userType: json["userType"] == null ? null : json["userType"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    signature: json["signature"] == null ? null : json["signature"],
    description: json["description"] == null ? null : json["description"],
    detailDescription: json["detailDescription"] == null ? null : json["detailDescription"],
    avatarImgId: json["avatarImgId"] == null ? null : json["avatarImgId"].toDouble(),
    backgroundImgId: json["backgroundImgId"] == null ? null : json["backgroundImgId"].toDouble(),
    backgroundUrl: json["backgroundUrl"] == null ? null : json["backgroundUrl"],
    authority: json["authority"] == null ? null : json["authority"],
    mutual: json["mutual"] == null ? null : json["mutual"],
    expertTags: json["expertTags"],
    experts: json["experts"],
    djStatus: json["djStatus"] == null ? null : json["djStatus"],
    vipType: json["vipType"] == null ? null : json["vipType"],
    remarkName: json["remarkName"],
    backgroundImgIdStr: json["backgroundImgIdStr"] == null ? null : json["backgroundImgIdStr"],
    avatarImgIdStr: json["avatarImgIdStr"] == null ? null : json["avatarImgIdStr"],
  );

  Map<String, dynamic> toJson() => {
    "defaultAvatar": defaultAvatar == null ? null : defaultAvatar,
    "province": province == null ? null : province,
    "authStatus": authStatus == null ? null : authStatus,
    "followed": followed == null ? null : followed,
    "avatarUrl": avatarUrl == null ? null : avatarUrl,
    "accountStatus": accountStatus == null ? null : accountStatus,
    "gender": gender == null ? null : gender,
    "city": city == null ? null : city,
    "birthday": birthday == null ? null : birthday,
    "userId": userId == null ? null : userId,
    "userType": userType == null ? null : userType,
    "nickname": nickname == null ? null : nickname,
    "signature": signature == null ? null : signature,
    "description": description == null ? null : description,
    "detailDescription": detailDescription == null ? null : detailDescription,
    "avatarImgId": avatarImgId == null ? null : avatarImgId,
    "backgroundImgId": backgroundImgId == null ? null : backgroundImgId,
    "backgroundUrl": backgroundUrl == null ? null : backgroundUrl,
    "authority": authority == null ? null : authority,
    "mutual": mutual == null ? null : mutual,
    "expertTags": expertTags,
    "experts": experts,
    "djStatus": djStatus == null ? null : djStatus,
    "vipType": vipType == null ? null : vipType,
    "remarkName": remarkName,
    "backgroundImgIdStr": backgroundImgIdStr == null ? null : backgroundImgIdStr,
    "avatarImgIdStr": avatarImgIdStr == null ? null : avatarImgIdStr,
  };
}

class RelateSong {
  RelateSong({
    required this.name,
    required this.id,
    required this.pst,
    required this.t,
    required this.ar,
    required this.alia,
    required this.pop,
    required this.st,
    required this.rt,
    required this.fee,
    required this.v,
    required this.crbt,
    required this.cf,
    required this.al,
    required this.dt,
    required this.h,
    required this.m,
    required this.l,
    required this.a,
    required this.cd,
    required this.no,
    required this.rtUrl,
    required this.ftype,
    required this.rtUrls,
    required this.djId,
    required this.copyright,
    required this.sId,
    required this.rtype,
    required this.rurl,
    required this.cp,
    required this.mv,
    required this.mst,
    required this.publishTime,
    required this.privilege,
  });

  String name;
  int id;
  int pst;
  int t;
  List<Ar> ar;
  List<dynamic> alia;
  int pop;
  int st;
  String ? rt;
  int fee;
  int v;
  dynamic crbt;
  String ? cf;
  Al al;
  int dt;
  dynamic h;
  dynamic m;
  L l;
  dynamic a;
  String ? cd;
  int no;
  dynamic rtUrl;
  int ftype;
  List<dynamic> rtUrls;
  int djId;
  int copyright;
  int sId;
  int rtype;
  dynamic rurl;
  int cp;
  int mv;
  int mst;
  int publishTime;
  Privilege privilege;

  factory RelateSong.fromJson(Map<String, dynamic> json) => RelateSong(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    pst: json["pst"] == null ? null : json["pst"],
    t: json["t"] == null ? null : json["t"],
    ar:  List<Ar>.from(json["ar"].map((x) => Ar.fromJson(x))),
    alia: List<dynamic>.from(json["alia"].map((x) => x)),
    pop: json["pop"] == null ? null : json["pop"],
    st: json["st"] == null ? null : json["st"],
    rt: json["rt"] == null ? null : json["rt"],
    fee: json["fee"] == null ? null : json["fee"],
    v: json["v"] == null ? null : json["v"],
    crbt: json["crbt"],
    cf: json["cf"] == null ? null : json["cf"],
    al: Al.fromJson(json["al"]),
    dt: json["dt"] == null ? null : json["dt"],
    h: json["h"],
    m: json["m"],
    l:  L.fromJson(json["l"]),
    a: json["a"],
    cd: json["cd"] == null ? null : json["cd"],
    no: json["no"] == null ? null : json["no"],
    rtUrl: json["rtUrl"],
    ftype: json["ftype"] == null ? null : json["ftype"],
    rtUrls:  List<dynamic>.from(json["rtUrls"].map((x) => x)),
    djId: json["djId"] == null ? null : json["djId"],
    copyright: json["copyright"] == null ? null : json["copyright"],
    sId: json["s_id"] == null ? null : json["s_id"],
    rtype: json["rtype"] == null ? null : json["rtype"],
    rurl: json["rurl"],
    cp: json["cp"] == null ? null : json["cp"],
    mv: json["mv"] == null ? null : json["mv"],
    mst: json["mst"] == null ? null : json["mst"],
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    privilege:  Privilege.fromJson(json["privilege"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "pst": pst == null ? null : pst,
    "t": t == null ? null : t,
    "ar": ar == null ? null : List<dynamic>.from(ar.map((x) => x.toJson())),
    "alia": alia == null ? null : List<dynamic>.from(alia.map((x) => x)),
    "pop": pop == null ? null : pop,
    "st": st == null ? null : st,
    "rt": rt == null ? null : rt,
    "fee": fee == null ? null : fee,
    "v": v == null ? null : v,
    "crbt": crbt,
    "cf": cf == null ? null : cf,
    "al": al == null ? null : al.toJson(),
    "dt": dt == null ? null : dt,
    "h": h,
    "m": m,
    "l": l == null ? null : l.toJson(),
    "a": a,
    "cd": cd == null ? null : cd,
    "no": no == null ? null : no,
    "rtUrl": rtUrl,
    "ftype": ftype == null ? null : ftype,
    "rtUrls": rtUrls == null ? null : List<dynamic>.from(rtUrls.map((x) => x)),
    "djId": djId == null ? null : djId,
    "copyright": copyright == null ? null : copyright,
    "s_id": sId == null ? null : sId,
    "rtype": rtype == null ? null : rtype,
    "rurl": rurl,
    "cp": cp == null ? null : cp,
    "mv": mv == null ? null : mv,
    "mst": mst == null ? null : mst,
    "publishTime": publishTime == null ? null : publishTime,
    "privilege": privilege == null ? null : privilege.toJson(),
  };
}



class L {
  L({
    required this.br,
    required this.fid,
    required this.size,
    required this.vd,
  });

  int br;
  int fid;
  int size;
  int vd;

  factory L.fromJson(Map<String, dynamic> json) => L(
    br: json["br"] == null ? null : json["br"],
    fid: json["fid"] == null ? null : json["fid"],
    size: json["size"] == null ? null : json["size"],
    vd: json["vd"] == null ? null : json["vd"],
  );

  Map<String, dynamic> toJson() => {
    "br": br == null ? null : br,
    "fid": fid == null ? null : fid,
    "size": size == null ? null : size,
    "vd": vd == null ? null : vd,
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
  };
}

class Resolution {
  Resolution({
    required this.resolution,
    required this.size,
  });

  int resolution;
  int size;

  factory Resolution.fromJson(Map<String, dynamic> json) => Resolution(
    resolution: json["resolution"] == null ? null : json["resolution"],
    size: json["size"] == null ? null : json["size"],
  );

  Map<String, dynamic> toJson() => {
    "resolution": resolution == null ? null : resolution,
    "size": size == null ? null : size,
  };
}

class VideoGroup {
  VideoGroup({
    required this.id,
    required this.name,
    required this.alg,
  });

  int id;
  String name;
  dynamic alg;

  factory VideoGroup.fromJson(Map<String, dynamic> json) => VideoGroup(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    alg: json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "alg": alg,
  };
}
