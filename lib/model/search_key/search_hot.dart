
import 'dart:convert';

SearchHotModel searchHotModelFromJson(String str) => SearchHotModel.fromJson(json.decode(str));

String searchHotModelToJson(SearchHotModel data) => json.encode(data.toJson());

class SearchHotModel {
  SearchHotModel({
    required this.searchWord,
    required this.score,
    required this.content,
    required this.source,
    required this.iconType,
    required this.iconUrl,
    required this.url,
    required this.alg,
  });

  String searchWord;
  int score;
  String ? content;
  int source;
  int iconType;
  dynamic iconUrl;
  String ? url;
  String ? alg;

  factory SearchHotModel.fromJson(Map<String, dynamic> json) => SearchHotModel(
    searchWord: json["searchWord"] == null ? null : json["searchWord"],
    score: json["score"] == null ? null : json["score"],
    content: json["content"] == null ? null : json["content"],
    source: json["source"] == null ? null : json["source"],
    iconType: json["iconType"] == null ? null : json["iconType"],
    iconUrl: json["iconUrl"],
    url: json["url"] == null ? null : json["url"],
    alg: json["alg"] == null ? null : json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "searchWord": searchWord == null ? null : searchWord,
    "score": score == null ? null : score,
    "content": content == null ? null : content,
    "source": source == null ? null : source,
    "iconType": iconType == null ? null : iconType,
    "iconUrl": iconUrl,
    "url": url == null ? null : url,
    "alg": alg == null ? null : alg,
  };
}
