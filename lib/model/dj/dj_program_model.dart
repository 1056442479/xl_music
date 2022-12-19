
import 'package:qq_music/model/dj/dj_details.dart';
import 'dart:convert';

import 'package:qq_music/model/song/song_every_model.dart';

DjProgramModel djProgramModelFromJson(String str) => DjProgramModel.fromJson(json.decode(str));

String djProgramModelToJson(DjProgramModel data) => json.encode(data.toJson());

class DjProgramModel {
  DjProgramModel({
    required this.mainSong,
    required this.songs,
    required this.dj,
    required this.blurCoverUrl,
    required this.radio,
    required this.duration,
    required this.authDto,
    required this.buyed,
    required this.programDesc,
    required this.h5Links,
    required this.canReward,
    required this.auditStatus,
    required this.videoInfo,
    required this.score,
    required this.liveInfo,
    required this.alg,
    required this.disPlayStatus,
    required this.auditDisPlayStatus,
    required this.categoryName,
    required this.secondCategoryName,
    required this.existLyric,
    required this.djPlayRecordVo,
    required this.recommended,
    required this.icon,
    required this.adIconInfo,
    required this.trackCount,
    required this.titbitImages,
    required this.isPublish,
    required this.privacy,
    required this.channels,
    required this.categoryId,
    required this.createEventId,
    required this.listenerCount,
    required this.scheduledPublishTime,
    required this.serialNum,
    required this.coverId,
    required this.coverUrl,
    required this.smallLanguageAuditStatus,
    required this.bdAuditStatus,
    required this.secondCategoryId,
    required this.pubStatus,
    required this.subscribedCount,
    required this.programFeeType,
    required this.mainTrackId,
    required this.titbits,
    required this.feeScope,
    required this.commentThreadId,
    required this.reward,
    required this.description,
    required this.createTime,
    required this.name,
    required this.id,
    required this.shareCount,
    required this.subscribed,
    required this.likedCount,
    required this.commentCount,
  });

  MainSong mainSong;
  dynamic songs;
  Dj dj;
  String blurCoverUrl;
  Radio radio;
  int duration;
  dynamic authDto;
  bool buyed;
  dynamic programDesc;
  dynamic h5Links;
  bool canReward;
  int auditStatus;
  dynamic videoInfo;
  int score;
  dynamic liveInfo;
  dynamic alg;
  dynamic disPlayStatus;
  int auditDisPlayStatus;
  dynamic categoryName;
  dynamic secondCategoryName;
  bool existLyric;
  dynamic djPlayRecordVo;
  bool recommended;
  dynamic icon;
  dynamic adIconInfo;
  int trackCount;
  dynamic titbitImages;
  bool isPublish;
  bool privacy;
  List<dynamic> channels;
  int categoryId;
  int createEventId;
  int listenerCount;
  int scheduledPublishTime;
  int serialNum;
  double coverId;
  String coverUrl;
  int smallLanguageAuditStatus;
  int bdAuditStatus;
  int secondCategoryId;
  int pubStatus;
  int subscribedCount;
  int programFeeType;
  int mainTrackId;
  dynamic titbits;
  int feeScope;
  String commentThreadId;
  bool reward;
  String description;
  int createTime;
  String name;
  int id;
  int shareCount;
  bool subscribed;
  int likedCount;
  int commentCount;

  factory DjProgramModel.fromJson(Map<String, dynamic> json) => DjProgramModel(
    mainSong:  MainSong.fromJson(json["mainSong"]),
    songs: json["songs"],
    dj:  Dj.fromJson(json["dj"]),
    blurCoverUrl: json["blurCoverUrl"] == null ? null : json["blurCoverUrl"],
    radio: Radio.fromJson(json["radio"]),
    duration: json["duration"] == null ? null : json["duration"],
    authDto: json["authDTO"],
    buyed: json["buyed"] == null ? null : json["buyed"],
    programDesc: json["programDesc"],
    h5Links: json["h5Links"],
    canReward: json["canReward"] == null ? null : json["canReward"],
    auditStatus: json["auditStatus"] == null ? null : json["auditStatus"],
    videoInfo: json["videoInfo"],
    score: json["score"] == null ? null : json["score"],
    liveInfo: json["liveInfo"],
    alg: json["alg"],
    disPlayStatus: json["disPlayStatus"],
    auditDisPlayStatus: json["auditDisPlayStatus"] == null ? null : json["auditDisPlayStatus"],
    categoryName: json["categoryName"],
    secondCategoryName: json["secondCategoryName"],
    existLyric: json["existLyric"] == null ? null : json["existLyric"],
    djPlayRecordVo: json["djPlayRecordVo"],
    recommended: json["recommended"] == null ? null : json["recommended"],
    icon: json["icon"],
    adIconInfo: json["adIconInfo"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    titbitImages: json["titbitImages"],
    isPublish: json["isPublish"] == null ? null : json["isPublish"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    channels:  List<dynamic>.from(json["channels"].map((x) => x)),
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    createEventId: json["createEventId"] == null ? null : json["createEventId"],
    listenerCount: json["listenerCount"] == null ? null : json["listenerCount"],
    scheduledPublishTime: json["scheduledPublishTime"] == null ? null : json["scheduledPublishTime"],
    serialNum: json["serialNum"] == null ? null : json["serialNum"],
    coverId: json["coverId"] == null ? null : json["coverId"].toDouble(),
    coverUrl: json["coverUrl"] == null ? null : json["coverUrl"],
    smallLanguageAuditStatus: json["smallLanguageAuditStatus"] == null ? null : json["smallLanguageAuditStatus"],
    bdAuditStatus: json["bdAuditStatus"] == null ? null : json["bdAuditStatus"],
    secondCategoryId: json["secondCategoryId"] == null ? null : json["secondCategoryId"],
    pubStatus: json["pubStatus"] == null ? null : json["pubStatus"],
    subscribedCount: json["subscribedCount"] == null ? null : json["subscribedCount"],
    programFeeType: json["programFeeType"] == null ? null : json["programFeeType"],
    mainTrackId: json["mainTrackId"] == null ? null : json["mainTrackId"],
    titbits: json["titbits"],
    feeScope: json["feeScope"] == null ? null : json["feeScope"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    reward: json["reward"] == null ? null : json["reward"],
    description: json["description"] == null ? null : json["description"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    shareCount: json["shareCount"] == null ? null : json["shareCount"],
    subscribed: json["subscribed"] == null ? null : json["subscribed"],
    likedCount: json["likedCount"] == null ? null : json["likedCount"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
  );

  Map<String, dynamic> toJson() => {
    "mainSong": mainSong == null ? null : mainSong.toJson(),
    "songs": songs,
    "dj": dj == null ? null : dj.toJson(),
    "blurCoverUrl": blurCoverUrl == null ? null : blurCoverUrl,
    "radio": radio == null ? null : radio.toJson(),
    "duration": duration == null ? null : duration,
    "authDTO": authDto,
    "buyed": buyed == null ? null : buyed,
    "programDesc": programDesc,
    "h5Links": h5Links,
    "canReward": canReward == null ? null : canReward,
    "auditStatus": auditStatus == null ? null : auditStatus,
    "videoInfo": videoInfo,
    "score": score == null ? null : score,
    "liveInfo": liveInfo,
    "alg": alg,
    "disPlayStatus": disPlayStatus,
    "auditDisPlayStatus": auditDisPlayStatus == null ? null : auditDisPlayStatus,
    "categoryName": categoryName,
    "secondCategoryName": secondCategoryName,
    "existLyric": existLyric == null ? null : existLyric,
    "djPlayRecordVo": djPlayRecordVo,
    "recommended": recommended == null ? null : recommended,
    "icon": icon,
    "adIconInfo": adIconInfo,
    "trackCount": trackCount == null ? null : trackCount,
    "titbitImages": titbitImages,
    "isPublish": isPublish == null ? null : isPublish,
    "privacy": privacy == null ? null : privacy,
    "channels": channels == null ? null : List<dynamic>.from(channels.map((x) => x)),
    "categoryId": categoryId == null ? null : categoryId,
    "createEventId": createEventId == null ? null : createEventId,
    "listenerCount": listenerCount == null ? null : listenerCount,
    "scheduledPublishTime": scheduledPublishTime == null ? null : scheduledPublishTime,
    "serialNum": serialNum == null ? null : serialNum,
    "coverId": coverId == null ? null : coverId,
    "coverUrl": coverUrl == null ? null : coverUrl,
    "smallLanguageAuditStatus": smallLanguageAuditStatus == null ? null : smallLanguageAuditStatus,
    "bdAuditStatus": bdAuditStatus == null ? null : bdAuditStatus,
    "secondCategoryId": secondCategoryId == null ? null : secondCategoryId,
    "pubStatus": pubStatus == null ? null : pubStatus,
    "subscribedCount": subscribedCount == null ? null : subscribedCount,
    "programFeeType": programFeeType == null ? null : programFeeType,
    "mainTrackId": mainTrackId == null ? null : mainTrackId,
    "titbits": titbits,
    "feeScope": feeScope == null ? null : feeScope,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "reward": reward == null ? null : reward,
    "description": description == null ? null : description,
    "createTime": createTime == null ? null : createTime,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "shareCount": shareCount == null ? null : shareCount,
    "subscribed": subscribed == null ? null : subscribed,
    "likedCount": likedCount == null ? null : likedCount,
    "commentCount": commentCount == null ? null : commentCount,
  };
}



class MainSong {
  MainSong({
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
    required this.ringtone,
    required this.crbt,
    required this.audition,
    required this.copyFrom,
    required this.commentThreadId,
    required this.rtUrl,
    required this.ftype,
    required this.rtUrls,
    required this.copyright,
    required this.transName,
    required this.sign,
    required this.mark,
    required this.noCopyrightRcmd,
    required this.rtype,
    required this.rurl,
    required this.mvid,
    required this.bMusic,
    required this.mp3Url,
    required this.hMusic,
    required this.mMusic,
    required this.lMusic,
  });

  String name;
  int id;
  int position;
  List<dynamic> alias;
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
  dynamic ringtone;
  dynamic crbt;
  dynamic audition;
  String copyFrom;
  String commentThreadId;
  dynamic rtUrl;
  int ftype;
  List<dynamic> rtUrls;
  int copyright;
  dynamic transName;
  dynamic sign;
  int mark;
  dynamic noCopyrightRcmd;
  int rtype;
  dynamic rurl;
  int mvid;
  Music bMusic;
  dynamic mp3Url;
  dynamic hMusic;
  dynamic mMusic;
  Music lMusic;

  factory MainSong.fromJson(Map<String, dynamic> json) => MainSong(
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    position: json["position"] == null ? null : json["position"],
    alias:  List<dynamic>.from(json["alias"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    fee: json["fee"] == null ? null : json["fee"],
    copyrightId: json["copyrightId"] == null ? null : json["copyrightId"],
    disc: json["disc"] == null ? null : json["disc"],
    no: json["no"] == null ? null : json["no"],
    artists:  List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    album:  Album.fromJson(json["album"]),
    starred: json["starred"] == null ? null : json["starred"],
    popularity: json["popularity"] == null ? null : json["popularity"],
    score: json["score"] == null ? null : json["score"],
    starredNum: json["starredNum"] == null ? null : json["starredNum"],
    duration: json["duration"] == null ? null : json["duration"],
    playedNum: json["playedNum"] == null ? null : json["playedNum"],
    dayPlays: json["dayPlays"] == null ? null : json["dayPlays"],
    hearTime: json["hearTime"] == null ? null : json["hearTime"],
    ringtone: json["ringtone"],
    crbt: json["crbt"],
    audition: json["audition"],
    copyFrom: json["copyFrom"] == null ? null : json["copyFrom"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    rtUrl: json["rtUrl"],
    ftype: json["ftype"] == null ? null : json["ftype"],
    rtUrls: List<dynamic>.from(json["rtUrls"].map((x) => x)),
    copyright: json["copyright"] == null ? null : json["copyright"],
    transName: json["transName"],
    sign: json["sign"],
    mark: json["mark"] == null ? null : json["mark"],
    noCopyrightRcmd: json["noCopyrightRcmd"],
    rtype: json["rtype"] == null ? null : json["rtype"],
    rurl: json["rurl"],
    mvid: json["mvid"] == null ? null : json["mvid"],
    bMusic:  Music.fromJson(json["bMusic"]),
    mp3Url: json["mp3Url"],
    hMusic: json["hMusic"],
    mMusic: json["mMusic"],
    lMusic: Music.fromJson(json["lMusic"]),
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
    "ringtone": ringtone,
    "crbt": crbt,
    "audition": audition,
    "copyFrom": copyFrom == null ? null : copyFrom,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "rtUrl": rtUrl,
    "ftype": ftype == null ? null : ftype,
    "rtUrls": rtUrls == null ? null : List<dynamic>.from(rtUrls.map((x) => x)),
    "copyright": copyright == null ? null : copyright,
    "transName": transName,
    "sign": sign,
    "mark": mark == null ? null : mark,
    "noCopyrightRcmd": noCopyrightRcmd,
    "rtype": rtype == null ? null : rtype,
    "rurl": rurl,
    "mvid": mvid == null ? null : mvid,
    "bMusic": bMusic == null ? null : bMusic.toJson(),
    "mp3Url": mp3Url,
    "hMusic": hMusic,
    "mMusic": mMusic,
    "lMusic": lMusic == null ? null : lMusic.toJson(),
  };
}




class Music {
  Music({
    required this.name,
    required this.id,
    required this.size,
    required this.extension,
    required this.sr,
    required this.dfsId,
    required this.bitrate,
    required this.playTime,
    required this.volumeDelta,
  });

  String ? name;
  int id;
  int size;
  String ? extension;
  int sr;
  int dfsId;
  int bitrate;
  int playTime;
  int volumeDelta;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
    name: json["name"] == null ? null : json["name"],
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
    "name": name == null ? null : name,
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

class Radio {
  Radio({
    required this.dj,
    required this.category,
    required this.secondCategory,
    required this.buyed,
    required this.price,
    required this.originalPrice,
    required this.discountPrice,
    required this.purchaseCount,
    required this.lastProgramName,
    required this.videos,
    required this.finished,
    required this.underShelf,
    required this.liveInfo,
    required this.playCount,
    required this.privacy,
    required this.icon,
    required this.manualTagsDto,
    required this.descPicList,
    required this.radioDynamic,
    required this.picUrl,
    required this.shortName,
    required this.categoryId,
    required this.taskId,
    required this.programCount,
    required this.picId,
    required this.subCount,
    required this.lastProgramId,
    required this.feeScope,
    required this.lastProgramCreateTime,
    required this.radioFeeType,
    required this.intervenePicUrl,
    required this.intervenePicId,
    required this.desc,
    required this.createTime,
    required this.name,
    required this.id,
    required this.subed,
  });

  dynamic dj;
  String category;
  String secondCategory;
  bool buyed;
  int price;
  int originalPrice;
  dynamic discountPrice;
  int purchaseCount;
  dynamic lastProgramName;
  dynamic videos;
  bool finished;
  bool underShelf;
  dynamic liveInfo;
  int playCount;
  bool privacy;
  dynamic icon;
  dynamic manualTagsDto;
  dynamic descPicList;
  bool radioDynamic;
  String picUrl;
  String ? shortName;
  int categoryId;
  int taskId;
  int programCount;
  int picId;
  int subCount;
  int lastProgramId;
  int feeScope;
  int lastProgramCreateTime;
  int radioFeeType;
  String ? intervenePicUrl;
  int intervenePicId;
  String ? desc;
  int createTime;
  String name;
  int id;
  bool subed;

  factory Radio.fromJson(Map<String, dynamic> json) => Radio(
    dj: json["dj"],
    category: json["category"] == null ? null : json["category"],
    secondCategory: json["secondCategory"] == null ? null : json["secondCategory"],
    buyed: json["buyed"] == null ? null : json["buyed"],
    price: json["price"] == null ? null : json["price"],
    originalPrice: json["originalPrice"] == null ? null : json["originalPrice"],
    discountPrice: json["discountPrice"],
    purchaseCount: json["purchaseCount"] == null ? null : json["purchaseCount"],
    lastProgramName: json["lastProgramName"],
    videos: json["videos"],
    finished: json["finished"] == null ? null : json["finished"],
    underShelf: json["underShelf"] == null ? null : json["underShelf"],
    liveInfo: json["liveInfo"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    icon: json["icon"],
    manualTagsDto: json["manualTagsDTO"],
    descPicList: json["descPicList"],
    radioDynamic: json["dynamic"] == null ? null : json["dynamic"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    shortName: json["shortName"] == null ? null : json["shortName"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    taskId: json["taskId"] == null ? null : json["taskId"],
    programCount: json["programCount"] == null ? null : json["programCount"],
    picId: json["picId"] == null ? null : json["picId"],
    subCount: json["subCount"] == null ? null : json["subCount"],
    lastProgramId: json["lastProgramId"] == null ? null : json["lastProgramId"],
    feeScope: json["feeScope"] == null ? null : json["feeScope"],
    lastProgramCreateTime: json["lastProgramCreateTime"] == null ? null : json["lastProgramCreateTime"],
    radioFeeType: json["radioFeeType"] == null ? null : json["radioFeeType"],
    intervenePicUrl: json["intervenePicUrl"] == null ? null : json["intervenePicUrl"],
    intervenePicId: json["intervenePicId"] == null ? null : json["intervenePicId"],
    desc: json["desc"] == null ? null : json["desc"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    subed: json["subed"] == null ? null : json["subed"],
  );

  Map<String, dynamic> toJson() => {
    "dj": dj,
    "category": category == null ? null : category,
    "secondCategory": secondCategory == null ? null : secondCategory,
    "buyed": buyed == null ? null : buyed,
    "price": price == null ? null : price,
    "originalPrice": originalPrice == null ? null : originalPrice,
    "discountPrice": discountPrice,
    "purchaseCount": purchaseCount == null ? null : purchaseCount,
    "lastProgramName": lastProgramName,
    "videos": videos,
    "finished": finished == null ? null : finished,
    "underShelf": underShelf == null ? null : underShelf,
    "liveInfo": liveInfo,
    "playCount": playCount == null ? null : playCount,
    "privacy": privacy == null ? null : privacy,
    "icon": icon,
    "manualTagsDTO": manualTagsDto,
    "descPicList": descPicList,
    "dynamic": radioDynamic == null ? null : radioDynamic,
    "picUrl": picUrl == null ? null : picUrl,
    "shortName": shortName == null ? null : shortName,
    "categoryId": categoryId == null ? null : categoryId,
    "taskId": taskId == null ? null : taskId,
    "programCount": programCount == null ? null : programCount,
    "picId": picId == null ? null : picId,
    "subCount": subCount == null ? null : subCount,
    "lastProgramId": lastProgramId == null ? null : lastProgramId,
    "feeScope": feeScope == null ? null : feeScope,
    "lastProgramCreateTime": lastProgramCreateTime == null ? null : lastProgramCreateTime,
    "radioFeeType": radioFeeType == null ? null : radioFeeType,
    "intervenePicUrl": intervenePicUrl == null ? null : intervenePicUrl,
    "intervenePicId": intervenePicId == null ? null : intervenePicId,
    "desc": desc == null ? null : desc,
    "createTime": createTime == null ? null : createTime,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "subed": subed == null ? null : subed,
  };
}
