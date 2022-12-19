
import 'dart:convert';
import 'dart:core';

import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/dj/dj_details.dart';
import 'package:qq_music/model/mv/mv_details.dart';
import 'package:qq_music/model/song/playing_song_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/model/song_play/song_play_details.dart';
import 'package:qq_music/model/user/song_user_model.dart';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    required this.result,
    required this.code,
  });

  ResultSearch result;
  int code;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
    code: json["code"],
    result: ResultSearch.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result":result.toJson()
  };
}

class ResultSearch{
  //歌曲
  List<Song> ? songs;
  int ? songCount;
  //专辑
  List<AlbumDetailsModel> ? albums;
  int ? albumCount;
  //歌手
  List<Artist> ? artists;
  int ? artistCount;
  //歌单
  List<SongPlayDetailsSearch> ? playlists;
  int ? playlistCount;
  //用户
  List<UserSearchModel> ? userprofiles;
  int ? userprofileCount;
  //MV
  List<MvDetailsModel> ? mvs;
  int ? mvCount;
  //电台
  List<DjDetailsModel> ? djRadios;
  int ? djRadiosCount;

  ResultSearch({
    this.songs,
    this.songCount,
    this.albums,
    this.albumCount,
    this.artists,
    this.artistCount,
    this.playlists,
    this.playlistCount,
    this.userprofiles,
    this.userprofileCount,
    this.mvs,
    this.mvCount,
    this.djRadios,
    this.djRadiosCount,
  });


  factory ResultSearch.fromJson(Map<String, dynamic> json) => ResultSearch(
    songs: json["songs"]==null?null:List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
    songCount: json["songCount"]==null?null:json['songCount'],
    albums: json["albums"]==null?null:List<AlbumDetailsModel>.from(json["albums"].map((x) => AlbumDetailsModel.fromJson(x))),
    albumCount: json["albumCount"]==null?null:json['albumCount'],
    artists: json["artists"]==null?null:List<Artist>.from(json["artists"].map((x) =>Artist.fromJson(x) )),
    artistCount: json["artistCount"]==null?null:json['artistCount'],
    playlists: json["playlists"]==null?null:List<SongPlayDetailsSearch>.from(json["playlists"].map((x) => SongPlayDetailsSearch.fromJson(x))),
    playlistCount: json["playlistCount"]==null?null:json['playlistCount'],
    userprofiles: json["userprofiles"]==null?null:List<UserSearchModel>.from(json["userprofiles"].map((x) =>UserSearchModel.fromJson(x) )),
    userprofileCount: json["userprofileCount"]==null?null:json['userprofileCount'],
    mvs: json["mvs"]==null?null:List<MvDetailsModel>.from(json["mvs"].map((x) =>MvDetailsModel.fromJson(x))),
    mvCount: json["mvCount"]==null?null:json['mvCount'],
    djRadios: json["djRadios"]==null?null:List<DjDetailsModel>.from(json["djRadios"].map((x) => DjDetailsModel.fromJson(x))),
    djRadiosCount: json["djRadiosCount"]==null?null:json['djRadiosCount'],
  );

  Map<String, dynamic> toJson() => {
    "songs": songs == null ? null : List<Song>.from(songs!.map((x) => x)),
    "songCount":songCount,
    "albums": albums == null ? null : List<AlbumDetailsModel>.from(albums!.map((x) => x)),
    "albumCount":albumCount,
    "artists": artists == null ? null : List<Artist>.from(artists!.map((x) => x)),
    "artistCount":artistCount,
    "playlists": playlists == null ? null : List<SongPlayDetailsSearch>.from(artists!.map((x) => x)),
    "playlistCount":playlistCount,
    "userprofiles": userprofiles == null ? null : List<UserSearchModel>.from(userprofiles!.map((x) => x)),
    "userprofileCount":userprofileCount,
    "mvs": mvs == null ? null : List<MvDetailsModel>.from(mvs!.map((x) => x)),
    "mvCount":mvCount,
    "djRadios": djRadios == null ? null : List<DjDetailsModel>.from(djRadios!.map((x) => x)),
    "djRadiosCount":djRadiosCount,
  };
}

///搜索的歌单集合
class SongPlayDetailsSearch {
  SongPlayDetailsSearch({
    required this.id,
    required this.name,
    required this.coverImgUrl,
    required this.creator,
    required this.subscribed,
    required this.trackCount,
    required this.userId,
    required this.playCount,
    required this.bookCount,
    required this.specialType,
    required this.officialTags,
    required this.action,
    required this.actionType,
    required this.recommendText,
    required this.score,
    required this.description,
    required this.highQuality,
  });

  int id;
  String name;
  String coverImgUrl;
  CreatorSearch creator;
  bool subscribed;
  int trackCount;
  int userId;
  int playCount;
  int bookCount;
  int specialType;
  dynamic officialTags;
  dynamic action;
  dynamic actionType;
  dynamic recommendText;
  dynamic score;
  String ? description;
  bool highQuality;

  factory SongPlayDetailsSearch.fromJson(Map<String, dynamic> json) => SongPlayDetailsSearch(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    coverImgUrl: json["coverImgUrl"] == null ? null : json["coverImgUrl"],
    creator:  CreatorSearch.fromJson(json["creator"]),
    subscribed: json["subscribed"] == null ? null : json["subscribed"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    userId: json["userId"] == null ? null : json["userId"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    bookCount: json["bookCount"] == null ? null : json["bookCount"],
    specialType: json["specialType"] == null ? null : json["specialType"],
    officialTags: json["officialTags"],
    action: json["action"],
    actionType: json["actionType"],
    recommendText: json["recommendText"],
    score: json["score"],
    description: json["description"] == null ? null : json["description"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "coverImgUrl": coverImgUrl == null ? null : coverImgUrl,
    "creator": creator == null ? null : creator.toJson(),
    "subscribed": subscribed == null ? null : subscribed,
    "trackCount": trackCount == null ? null : trackCount,
    "userId": userId == null ? null : userId,
    "playCount": playCount == null ? null : playCount,
    "bookCount": bookCount == null ? null : bookCount,
    "specialType": specialType == null ? null : specialType,
    "officialTags": officialTags,
    "action": action,
    "actionType": actionType,
    "recommendText": recommendText,
    "score": score,
    "description": description == null ? null : description,
    "highQuality": highQuality == null ? null : highQuality,
  };
}

class CreatorSearch {
  CreatorSearch({
    required this.nickname,
    required this.userId,
    required this.userType,
    required this.avatarUrl,
    required this.authStatus,
    required this.expertTags,
    required this.experts,
  });

  String nickname;
  int userId;
  int userType;
  dynamic avatarUrl;
  int authStatus;
  dynamic expertTags;
  dynamic experts;

  factory CreatorSearch.fromJson(Map<String, dynamic> json) => CreatorSearch(
    nickname: json["nickname"] == null ? null : json["nickname"],
    userId: json["userId"] == null ? null : json["userId"],
    userType: json["userType"] == null ? null : json["userType"],
    avatarUrl: json["avatarUrl"],
    authStatus: json["authStatus"] == null ? null : json["authStatus"],
    expertTags: json["expertTags"],
    experts: json["experts"],
  );

  Map<String, dynamic> toJson() => {
    "nickname": nickname == null ? null : nickname,
    "userId": userId == null ? null : userId,
    "userType": userType == null ? null : userType,
    "avatarUrl": avatarUrl,
    "authStatus": authStatus == null ? null : authStatus,
    "expertTags": expertTags,
    "experts": experts,
  };
}




///搜索的用户结果实体
class UserSearchModel {
  UserSearchModel({
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
    required this.authenticationTypes,
    required this.avatarDetail,
    required this.backgroundImgIdStr,
    required this.avatarImgIdStr,
    required this.anchor,
    required this.welcomeAvatarImgIdStr,
    required this.followeds,
    required this.follows,
    required this.alg,
    required this.playlistCount,
    required this.playlistBeSubscribedCount,
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
  String ? signature;
  String ? description;
  String ? detailDescription;
  double avatarImgId;
  double backgroundImgId;
  String  ? backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  int authenticationTypes;
  AvatarDetail ? avatarDetail;
  String ? backgroundImgIdStr;
  String ? avatarImgIdStr;
  bool anchor;
  String ? welcomeAvatarImgIdStr;
  int followeds;
  int follows;
  String ? alg;
  int playlistCount;
  int playlistBeSubscribedCount;

  factory UserSearchModel.fromJson(Map<String, dynamic> json) => UserSearchModel(
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
    avatarDetail: json["avatarDetail"] == null ? null : AvatarDetail.fromJson(json["avatarDetail"]),
    backgroundImgIdStr: json["backgroundImgIdStr"] == null ? null : json["backgroundImgIdStr"],
    avatarImgIdStr: json["avatarImgIdStr"] == null ? null : json["avatarImgIdStr"],
    anchor: json["anchor"] == null ? null : json["anchor"],
    welcomeAvatarImgIdStr: json["avatarImgId_str"] == null ? null : json["avatarImgId_str"],
    followeds: json["followeds"] == null ? null : json["followeds"],
    follows: json["follows"] == null ? null : json["follows"],
    alg: json["alg"] == null ? null : json["alg"],
    playlistCount: json["playlistCount"] == null ? null : json["playlistCount"],
    playlistBeSubscribedCount: json["playlistBeSubscribedCount"] == null ? null : json["playlistBeSubscribedCount"],
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
    "avatarDetail": avatarDetail == null ? null : avatarDetail!.toJson(),
    "backgroundImgIdStr": backgroundImgIdStr == null ? null : backgroundImgIdStr,
    "avatarImgIdStr": avatarImgIdStr == null ? null : avatarImgIdStr,
    "anchor": anchor == null ? null : anchor,
    "avatarImgId_str": welcomeAvatarImgIdStr == null ? null : welcomeAvatarImgIdStr,
    "followeds": followeds == null ? null : followeds,
    "follows": follows == null ? null : follows,
    "alg": alg == null ? null : alg,
    "playlistCount": playlistCount == null ? null : playlistCount,
    "playlistBeSubscribedCount": playlistBeSubscribedCount == null ? null : playlistBeSubscribedCount,
  };
}

class AvatarDetail {
  AvatarDetail({
    required this.userType,
    required this.identityLevel,
    required this.identityIconUrl,
  });

  int userType;
  int identityLevel;
  String identityIconUrl;

  factory AvatarDetail.fromJson(Map<String, dynamic> json) => AvatarDetail(
    userType: json["userType"] == null ? null : json["userType"],
    identityLevel: json["identityLevel"] == null ? null : json["identityLevel"],
    identityIconUrl: json["identityIconUrl"] == null ? null : json["identityIconUrl"],
  );

  Map<String, dynamic> toJson() => {
    "userType": userType == null ? null : userType,
    "identityLevel": identityLevel == null ? null : identityLevel,
    "identityIconUrl": identityIconUrl == null ? null : identityIconUrl,
  };
}
