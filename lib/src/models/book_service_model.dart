import 'dart:convert';
BookServiceModel bookServiceModelFromJson(String str) => BookServiceModel.fromJson(json.decode(str));
String bookServiceModelToJson(BookServiceModel data) => json.encode(data.toJson());
class BookServiceModel {
  BookServiceModel({
      Data? data, 
      bool? success, 
      String? message, 
      dynamic errors,}){
    _data = data;
    _success = success;
    _message = message;
    _errors = errors;
}

  BookServiceModel.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _success = json['success'];
    _message = json['message'];
    _errors = json['errors'];
  }
  Data? _data;
  bool? _success;
  String? _message;
  dynamic _errors;
BookServiceModel copyWith({  Data? data,
  bool? success,
  String? message,
  dynamic errors,
}) => BookServiceModel(  data: data ?? _data,
  success: success ?? _success,
  message: message ?? _message,
  errors: errors ?? _errors,
);
  Data? get data => _data;
  bool? get success => _success;
  String? get message => _message;
  dynamic get errors => _errors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['success'] = _success;
    map['message'] = _message;
    map['errors'] = _errors;
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? question, 
      String? date, 
      String? serviceId, 
      num? price, 
      num? customerId, 
      num? serviceStatusCode, 
      num? fundId, 
      num? isPaid, 
      String? updatedAt, 
      String? createdAt, 
      num? id, 
      String? fundTransaction,}){
    _question = question;
    _date = date;
    _serviceId = serviceId;
    _price = price;
    _customerId = customerId;
    _serviceStatusCode = serviceStatusCode;
    _fundId = fundId;
    _isPaid = isPaid;
    _updatedAt = updatedAt;
    _createdAt = createdAt;
    _id = id;
    _fundTransaction = fundTransaction;
}

  Data.fromJson(dynamic json) {
    _question = json['question'];
    _date = json['date'];
    _serviceId = json['service_id'];
    _price = json['price'];
    _customerId = json['customer_id'];
    _serviceStatusCode = json['service_status_code'];
    _fundId = json['fund_id'];
    _isPaid = json['is_paid'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
    _fundTransaction = json['fund_transaction'];
  }
  String? _question;
  String? _date;
  String? _serviceId;
  num? _price;
  num? _customerId;
  num? _serviceStatusCode;
  num? _fundId;
  num? _isPaid;
  String? _updatedAt;
  String? _createdAt;
  num? _id;
  String? _fundTransaction;
Data copyWith({  String? question,
  String? date,
  String? serviceId,
  num? price,
  num? customerId,
  num? serviceStatusCode,
  num? fundId,
  num? isPaid,
  String? updatedAt,
  String? createdAt,
  num? id,
  String? fundTransaction,
}) => Data(  question: question ?? _question,
  date: date ?? _date,
  serviceId: serviceId ?? _serviceId,
  price: price ?? _price,
  customerId: customerId ?? _customerId,
  serviceStatusCode: serviceStatusCode ?? _serviceStatusCode,
  fundId: fundId ?? _fundId,
  isPaid: isPaid ?? _isPaid,
  updatedAt: updatedAt ?? _updatedAt,
  createdAt: createdAt ?? _createdAt,
  id: id ?? _id,
  fundTransaction: fundTransaction ?? _fundTransaction,
);
  String? get question => _question;
  String? get date => _date;
  String? get serviceId => _serviceId;
  num? get price => _price;
  num? get customerId => _customerId;
  num? get serviceStatusCode => _serviceStatusCode;
  num? get fundId => _fundId;
  num? get isPaid => _isPaid;
  String? get updatedAt => _updatedAt;
  String? get createdAt => _createdAt;
  num? get id => _id;
  String? get fundTransaction => _fundTransaction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['question'] = _question;
    map['date'] = _date;
    map['service_id'] = _serviceId;
    map['price'] = _price;
    map['customer_id'] = _customerId;
    map['service_status_code'] = _serviceStatusCode;
    map['fund_id'] = _fundId;
    map['is_paid'] = _isPaid;
    map['updated_at'] = _updatedAt;
    map['created_at'] = _createdAt;
    map['id'] = _id;
    map['fund_transaction'] = _fundTransaction;
    return map;
  }

}