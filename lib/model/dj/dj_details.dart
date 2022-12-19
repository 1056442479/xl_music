// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DjDetailsModel djDetailsModelFromJson(String str) => DjDetailsModel.fromJson(json.decode(str));

String djDetailsModelToJson(DjDetailsModel data) => json.encode(data.toJson());

class DjDetailsModel {
  DjDetailsModel({
    required this.id,
    required this.name,
    required this.dj,
     this.picId,
    required this.picUrl,
     this.desc,
    required this.subCount,
    this.shareCount,
    this.likedCount,
    this.programCount,
    this.commentCount,
    required this.createTime,
    required this.categoryId,
    required  this.category,
    this.secondCategoryId,
    this.secondCategory,
    required this.radioFeeType,
    this.feeScope,
    this.lastProgramCreateTime,
    this.lastProgramId,
    this.rcmdText,
     this.subed,
    this.commentDatas,
    this.feeInfo,
    this.unlockInfo,
    this.original,
  required  this.playCount,
    this.privacy,
    this.disableShare,
    this.score,
    this.icon,
    this.activityInfo,
    this.toplistInfo,
    this.welcomeDynamic,
    this.labelDto,
    this.labels,
    this.rank,
    this.copywriter,
  });

  int id;
  String name;
  Dj dj;
  int ? picId;
  String picUrl;
  String ? desc;
  int subCount;
  int ?shareCount;
  int ?likedCount;
  int? programCount;
  int ?commentCount;
  int createTime;
  int categoryId;
  String category;
  int ?secondCategoryId;
  String ?secondCategory;
  int radioFeeType;
  int ?feeScope;
  int ?lastProgramCreateTime;
  int ?lastProgramId;
  String? rcmdText;
  String? copywriter;
  bool ? subed;
  List<CommentData> ?commentDatas;
  dynamic feeInfo;
  dynamic unlockInfo;
  bool ?original;
  int playCount;
  int ? score;
  int ? rank;
  bool? privacy;
  bool ?disableShare;
  dynamic icon;
  dynamic activityInfo;
  dynamic toplistInfo;
  bool ? welcomeDynamic;
  dynamic labelDto;
  dynamic labels;

  factory DjDetailsModel.fromJson(Map<String, dynamic> json) => DjDetailsModel(
    id: json["id"] == null ? null : json["id"],
    score: json["score"] == null ? null : json["score"],
    rank: json["rank"] == null ? null : json["rank"],
    name: json["name"] == null ? null : json["name"],
    copywriter: json["copywriter"] == null ? null : json["copywriter"],
    dj:  Dj.fromJson(json["dj"]),
    picId: json["picId"] == null ? null : json["picId"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    desc: json["desc"] == null ? null : json["desc"],
    subCount: json["subCount"] == null ? null : json["subCount"],
    shareCount: json["shareCount"] == null ? null : json["shareCount"],
    likedCount: json["likedCount"] == null ? null : json["likedCount"],
    programCount: json["programCount"] == null ? null : json["programCount"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    category: json["category"] == null ? null : json["category"],
    secondCategoryId: json["secondCategoryId"] == null ? null : json["secondCategoryId"],
    secondCategory: json["secondCategory"] == null ? null : json["secondCategory"],
    radioFeeType: json["radioFeeType"] == null ? null : json["radioFeeType"],
    feeScope: json["feeScope"] == null ? null : json["feeScope"],
    lastProgramCreateTime: json["lastProgramCreateTime"] == null ? null : json["lastProgramCreateTime"],
    lastProgramId: json["lastProgramId"] == null ? null : json["lastProgramId"],
    rcmdText: json["rcmdText"] == null ? null : json["rcmdText"],
    subed: json["subed"] == null ? null : json["subed"],
    commentDatas: json["commentDatas"] == null ? null : List<CommentData>.from(json["commentDatas"].map((x) => CommentData.fromJson(x))),
    feeInfo: json["feeInfo"],
    unlockInfo: json["unlockInfo"],
    original: json["original"] == null ? null : json["original"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    disableShare: json["disableShare"] == null ? null : json["disableShare"],
    icon: json["icon"],
    activityInfo: json["activityInfo"],
    toplistInfo: json["toplistInfo"],
    welcomeDynamic: json["dynamic"] == null ? null : json["dynamic"],
    labelDto: json["labelDto"],
    labels: json["labels"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "score": score == null ? null : score,
    "rank": rank == null ? null : rank,
    "copywriter": copywriter == null ? null : copywriter,
    "name": name == null ? null : name,
    "dj": dj == null ? null : dj.toJson(),
    "picId": picId == null ? null : picId,
    "picUrl": picUrl == null ? null : picUrl,
    "desc": desc == null ? null : desc,
    "subCount": subCount == null ? null : subCount,
    "shareCount": shareCount == null ? null : shareCount,
    "likedCount": likedCount == null ? null : likedCount,
    "programCount": programCount == null ? null : programCount,
    "commentCount": commentCount == null ? null : commentCount,
    "createTime": createTime == null ? null : createTime,
    "categoryId": categoryId == null ? null : categoryId,
    "category": category == null ? null : category,
    "secondCategoryId": secondCategoryId == null ? null : secondCategoryId,
    "secondCategory": secondCategory == null ? null : secondCategory,
    "radioFeeType": radioFeeType == null ? null : radioFeeType,
    "feeScope": feeScope == null ? null : feeScope,
    "lastProgramCreateTime": lastProgramCreateTime == null ? null : lastProgramCreateTime,
    "lastProgramId": lastProgramId == null ? null : lastProgramId,
    "rcmdText": rcmdText == null ? null : rcmdText,
    "subed": subed == null ? null : subed,
    "commentDatas": commentDatas == null ? null : List<dynamic>.from(commentDatas!.map((x) => x.toJson())),
    "feeInfo": feeInfo,
    "unlockInfo": unlockInfo,
    "original": original == null ? null : original,
    "playCount": playCount == null ? null : playCount,
    "privacy": privacy == null ? null : privacy,
    "disableShare": disableShare == null ? null : disableShare,
    "icon": icon,
    "activityInfo": activityInfo,
    "toplistInfo": toplistInfo,
    "dynamic": welcomeDynamic == null ? null : welcomeDynamic,
    "labelDto": labelDto,
    "labels": labels,
  };
}

class CommentData {
  CommentData({
    required this.userProfile,
    required this.content,
    required  this.programName,
    required  this.programId,
    required  this.commentId,
  });

  Dj  userProfile;
  String content;
  String programName;
  int programId;
  int commentId;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
    userProfile:  Dj.fromJson(json["userProfile"]),
    content: json["content"] == null ? null : json["content"],
    programName: json["programName"] == null ? null : json["programName"],
    programId: json["programId"] == null ? null : json["programId"],
    commentId: json["commentId"] == null ? null : json["commentId"],
  );

  Map<String, dynamic> toJson() => {
    "userProfile": userProfile == null ? null : userProfile.toJson(),
    "content": content == null ? null : content,
    "programName": programName == null ? null : programName,
    "programId": programId == null ? null : programId,
    "commentId": commentId == null ? null : commentId,
  };
}

class Dj {
  Dj({
    required this.defaultAvatar,
    required this.province,
    required this.authStatus,
    required  this.followed,
    required  this.avatarUrl,
    required  this.accountStatus,
    required  this.gender,
    required  this.city,
    required  this.birthday,
    required  this.userId,
    required  this.userType,
    required this.nickname,
    required this.signature,
    required this.description,
    required   this.detailDescription,
    required   this.avatarImgId,
    required   this.backgroundImgId,
      this.backgroundUrl,
    required    this.authority,
    required   this.mutual,
    this.expertTags,
    this.experts,
    required this.djStatus,
    required   this.vipType,
    this.remarkName,
    required  this.authenticationTypes,
    this.avatarDetail,
    required  this.avatarImgIdStr,
    required  this.backgroundImgIdStr,
    required  this.anchor,
     this.djAvatarImgIdStr,
     this.rewardCount,
      this.canReward,
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
  String ? backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  int authenticationTypes;
  dynamic avatarDetail;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool anchor;
  String ? djAvatarImgIdStr;
  int ? rewardCount;
  bool ?canReward;

  factory Dj.fromJson(Map<String, dynamic> json) => Dj(
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
    authenticationTypes: json["authenticationTypes"] == null ? null : json["authenticationTypes"],
    avatarDetail: json["avatarDetail"],
    avatarImgIdStr: json["avatarImgIdStr"] == null ? null : json["avatarImgIdStr"],
    backgroundImgIdStr: json["backgroundImgIdStr"] == null ? null : json["backgroundImgIdStr"],
    anchor: json["anchor"] == null ? null : json["anchor"],
    djAvatarImgIdStr: json["avatarImgId_str"] == null ? null : json["avatarImgId_str"],
    rewardCount: json["rewardCount"] == null ? null : json["rewardCount"],
    canReward: json["canReward"] == null ? null : json["canReward"],
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
    "authenticationTypes": authenticationTypes == null ? null : authenticationTypes,
    "avatarDetail": avatarDetail,
    "avatarImgIdStr": avatarImgIdStr == null ? null : avatarImgIdStr,
    "backgroundImgIdStr": backgroundImgIdStr == null ? null : backgroundImgIdStr,
    "anchor": anchor == null ? null : anchor,
    "avatarImgId_str": djAvatarImgIdStr == null ? null : djAvatarImgIdStr,
    "rewardCount": rewardCount == null ? null : rewardCount,
    "canReward": canReward == null ? null : canReward,
  };
}
