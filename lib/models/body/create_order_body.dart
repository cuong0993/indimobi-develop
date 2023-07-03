class CreateOrderBody {
  CreateOrderBody({
    this.phone,
    this.pageNumber,
    this.address,
    this.paymentMethod,
    this.productId,
  });

  CreateOrderBody.fromJson(dynamic json) {
    phone = json['phone'];
    pageNumber = json['page_number'];
    address = json['address'];
    paymentMethod = json['payment_method'];
    productId = json['product_id'];
  }

  String? phone;
  int? pageNumber;
  String? address;
  String? paymentMethod;
  String? productId;

  CreateOrderBody copyWith({
    String? phone,
    int? pageNumber,
    String? address,
    String? paymentMethod,
    String? productId,
  }) =>
      CreateOrderBody(
        phone: phone ?? this.phone,
        pageNumber: pageNumber ?? this.pageNumber,
        address: address ?? this.address,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        productId: productId ?? this.productId,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['page_number'] = pageNumber;
    map['address'] = address;
    map['payment_method'] = paymentMethod;
    map['product_id'] = productId;
    return map;
  }
}
