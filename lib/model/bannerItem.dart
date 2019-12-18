import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)

class BannerItem {
  String id;
  String imageUrl;

  BannerItem({this.id, this.imageUrl});

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    if (json == null)
      return null;

    return BannerItem(
      imageUrl: json['imageUrl'],
        id: json['id'],
    );
  }

  static List<BannerItem> fromJsonArray(List<dynamic> json) {
    List<BannerItem> bannerItem = json.map<BannerItem>((json) => BannerItem.fromJson(json))
        .toList();
    return bannerItem;
  }
}