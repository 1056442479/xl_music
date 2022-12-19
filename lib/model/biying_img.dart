// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

BingImageModel bingImageModelFromJson(String str) => BingImageModel.fromJson(json.decode(str));

String bingImageModelToJson(BingImageModel data) => json.encode(data.toJson());

class BingImageModel {
  BingImageModel({
    required this.images,
    required this.tooltips,
  });

  List<Image> images;
  Tooltips tooltips;

  factory BingImageModel.fromJson(Map<String, dynamic> json) => BingImageModel(
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    tooltips: Tooltips.fromJson(json["tooltips"]),
  );

  Map<String, dynamic> toJson() => {
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "tooltips": tooltips.toJson(),
  };
}

class Image {
  Image({
    required this.startdate,
    required this.fullstartdate,
    required this.enddate,
    required this.url,
    required this.urlbase,
    required this.copyright,
    required this.copyrightlink,
    required this.title,
    required  this.quiz,
    required this.wp,
    required this.hsh,
    required this.drk,
    required this.top,
    required this.bot,
    required this.hs,
  });

  String startdate;
  String fullstartdate;
  String enddate;
  String url;
  String urlbase;
  String copyright;
  String copyrightlink;
  String title;
  String quiz;
  bool wp;
  String hsh;
  int drk;
  int top;
  int bot;
  List<dynamic> hs;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    startdate: json["startdate"],
    fullstartdate: json["fullstartdate"],
    enddate: json["enddate"],
    url: json["url"],
    urlbase: json["urlbase"],
    copyright: json["copyright"],
    copyrightlink: json["copyrightlink"],
    title: json["title"],
    quiz: json["quiz"],
    wp: json["wp"],
    hsh: json["hsh"],
    drk: json["drk"],
    top: json["top"],
    bot: json["bot"],
    hs: List<dynamic>.from(json["hs"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "startdate": startdate,
    "fullstartdate": fullstartdate,
    "enddate": enddate,
    "url": url,
    "urlbase": urlbase,
    "copyright": copyright,
    "copyrightlink": copyrightlink,
    "title": title,
    "quiz": quiz,
    "wp": wp,
    "hsh": hsh,
    "drk": drk,
    "top": top,
    "bot": bot,
    "hs": List<dynamic>.from(hs.map((x) => x)),
  };
}

class Tooltips {
  Tooltips({
   required this.loading,
    required this.previous,
    required this.next,
    required this.walle,
    required  this.walls,
  });

  String loading;
  String previous;
  String next;
  String walle;
  String walls;

  factory Tooltips.fromJson(Map<String, dynamic> json) => Tooltips(
    loading: json["loading"],
    previous: json["previous"],
    next: json["next"],
    walle: json["walle"],
    walls: json["walls"],
  );

  Map<String, dynamic> toJson() => {
    "loading": loading,
    "previous": previous,
    "next": next,
    "walle": walle,
    "walls": walls,
  };
}
