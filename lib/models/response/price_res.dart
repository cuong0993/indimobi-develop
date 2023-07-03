class PriceRes {
  PriceRes({
      this.status, 
      this.data,});

  PriceRes.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? status;
  Data? data;
PriceRes copyWith({  num? status,
  Data? data,
}) => PriceRes(  status: status ?? this.status,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.price,});

  Data.fromJson(dynamic json) {
    price = json['price'];
  }
  num? price;
Data copyWith({  num? price,
}) => Data(  price: price ?? this.price,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = price;
    return map;
  }

}