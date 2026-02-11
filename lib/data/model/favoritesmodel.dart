import 'dart:core';

class FavoritesModel {
  int? id;
  int? userId;
  int? itemId;
  int? categoryId;
  String? name;
  String? nameAr;
  String? desc;
  String? descAr;
  int? price;
  int? count;
  int? discount;
  bool? isActive;
  String? image;
  String? date;
  // int? isFavorite;
  FavoritesModel({this.id, this.userId,this.itemId, this.categoryId,
    // this.isFavorite,
    this.name,
    this.nameAr,
    this.desc,
    this.descAr,
    this.count,
    this.discount,
    this.isActive,
    this.image,
    this.date,});
  FavoritesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['pivot']['user_id'];
    itemId = json['pivot']['item_id'];
    categoryId = json['category_id'];
    name = json['name'];
    nameAr = json['name_ar'];
    desc = json['desc'];
    descAr = json['desc_ar'];
    price = json['price'];
    count = json['count'];
    isActive = json['isActive'];
    image = json['image'];
    date = json['date_created'];
    // isFavorite= json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['item_id'] =itemId;
     data['category_id'] = this.categoryId;
    data['name_ar'] = this.name;
    data['nameAr'] = this.nameAr;
    data['desc'] = this.desc;
    data['desc_ar'] = this.descAr;
    data['price'] = this.price;
    data['count'] = this.count;
    data['is_active'] = this.isActive;
    data['image'] = this.image;
    data['date_created'] = this.date;
    return data;
  }
}
