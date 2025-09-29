import 'dart:convert';

GetAllCarouselBannerModel getCarouselBannerModelFromJson(String str) =>
    GetAllCarouselBannerModel.fromJson(json.decode(str));
String getCarouselBannerModelToJson(GetAllCarouselBannerModel data) =>
    json.encode(data.toJson());

class GetAllCarouselBannerModel {
  GetAllCarouselBannerModel({
    List<GetAllCarouselBannerDataModel>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) {
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
  }

  GetAllCarouselBannerModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllCarouselBannerDataModel.fromJson(v));
      });
    }
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  List<GetAllCarouselBannerDataModel>? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
  GetAllCarouselBannerModel copyWith({
    List<GetAllCarouselBannerDataModel>? data,
    bool? success,
    String? message,
    dynamic errors,
  }) =>
      GetAllCarouselBannerModel(
        data: data ?? _data,
        success: success ?? _success,
        message: message ?? _message,
        errors: errors ?? _errors,
      );
  List<GetAllCarouselBannerDataModel>? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }
}

GetAllCarouselBannerDataModel dataFromJson(String str) =>
    GetAllCarouselBannerDataModel.fromJson(json.decode(str));
String dataToJson(GetAllCarouselBannerDataModel data) =>
    json.encode(data.toJson());

class GetAllCarouselBannerDataModel {
  GetAllCarouselBannerDataModel({
    num? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _description = description;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  GetAllCarouselBannerDataModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _description;
  String? _image;
  String? _createdAt;
  String? _updatedAt;
  GetAllCarouselBannerDataModel copyWith({
    num? id,
    String? name,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) =>
      GetAllCarouselBannerDataModel(
        id: id ?? _id,
        name: name ?? _name,
        description: description ?? _description,
        image: image ?? _image,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
      );
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
