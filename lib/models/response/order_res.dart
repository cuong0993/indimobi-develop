class OrderRes {
  OrderRes({
    this.orders,
  });

  OrderRes.fromJson(dynamic json) {
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders?.add(Orders.fromJson(v));
      });
    }
  }

  List<Orders>? orders;

  OrderRes copyWith({
    List<Orders>? orders,
  }) =>
      OrderRes(
        orders: orders ?? this.orders,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (orders != null) {
      map['orders'] = orders?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Orders {
  Orders({
    this.user,
    this.refUser,
    this.haravanOrder,
    this.refPhone,
    this.phone,
    this.productId,
    this.status,
    this.isUploaded,
    this.modifiedBy,
    this.createdOn,
    this.updatedOn,
    this.completedOn,
    this.referal,
    this.referalLv2,
    this.referalLv3,
    this.pageNumber,
    this.havavanTrackingStatus,
    this.isCreatedFile,
    this.urlResultFile,
    this.filePath,
    this.deliveringMethod,
    this.productName,
    this.discountPrice,
    this.shippingPrice,
    this.paymentMethod,
    this.shippingAddress,
    this.logStatus,
    this.affiliateCode,
    this.coupon,
    this.odooOrderStatus,
    this.id,
    this.orderPrice,
    this.totalPrice,
  });

  Orders.fromJson(dynamic json) {
    user = json['user'];
    refUser = json['ref_user'];
    haravanOrder = json['haravan_order'];
    refPhone = json['ref_phone'];
    phone = json['phone'];
    productId = json['product_id'];
    status = json['status'];
    isUploaded = json['is_uploaded'];
    modifiedBy = json['modified_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    completedOn = json['completed_on'];
    referal = json['referal'];
    referalLv2 = json['referal_lv2'];
    referalLv3 = json['referal_lv3'];
    pageNumber = json['page_number'];
    havavanTrackingStatus = json['havavan_tracking_status'];
    isCreatedFile = json['is_created_file'];
    urlResultFile = json['url_result_file'];
    filePath = json['file_path'];
    deliveringMethod = json['delivering_method'];
    productName = json['product_name'];
    discountPrice = json['discount_price'];
    shippingPrice = json['shipping_price'];
    paymentMethod = json['payment_method'];
    shippingAddress = json['shipping_address'] != null
        ? ShippingAddress.fromJson(json['shipping_address'])
        : null;
    logStatus = json['log_status'];
    affiliateCode = json['affiliate_code'];
    coupon = json['coupon'];
    odooOrderStatus = json['odoo_order_status'];
    id = json['id'];
    orderPrice = json['order_price'];
    totalPrice = json['total_price'];
  }

  int? user;
  String? refUser;
  String? haravanOrder;
  String? refPhone;
  String? phone;
  String? productId;
  int? status;
  bool? isUploaded;
  String? modifiedBy;
  String? createdOn;
  String? updatedOn;
  String? completedOn;
  String? referal;
  String? referalLv2;
  String? referalLv3;
  int? pageNumber;
  int? havavanTrackingStatus;
  bool? isCreatedFile;
  String? urlResultFile;
  String? filePath;
  String? deliveringMethod;
  String? productName;
  int? discountPrice;
  int? shippingPrice;
  String? paymentMethod;
  ShippingAddress? shippingAddress;
  String? logStatus;
  String? affiliateCode;
  String? coupon;
  String? odooOrderStatus;
  int? id;
  int? orderPrice;
  int? totalPrice;

  Orders copyWith({
    int? user,
    String? refUser,
    String? haravanOrder,
    String? refPhone,
    String? phone,
    String? productId,
    int? status,
    bool? isUploaded,
    String? modifiedBy,
    String? createdOn,
    String? updatedOn,
    String? completedOn,
    String? referal,
    String? referalLv2,
    String? referalLv3,
    int? pageNumber,
    int? havavanTrackingStatus,
    bool? isCreatedFile,
    String? urlResultFile,
    String? filePath,
    String? deliveringMethod,
    String? productName,
    int? discountPrice,
    int? shippingPrice,
    String? paymentMethod,
    ShippingAddress? shippingAddress,
    String? logStatus,
    String? affiliateCode,
    String? coupon,
    String? odooOrderStatus,
    int? id,
    int? orderPrice,
    int? totalPrice,
  }) =>
      Orders(
        user: user ?? this.user,
        refUser: refUser ?? this.refUser,
        haravanOrder: haravanOrder ?? this.haravanOrder,
        refPhone: refPhone ?? this.refPhone,
        phone: phone ?? this.phone,
        productId: productId ?? this.productId,
        status: status ?? this.status,
        isUploaded: isUploaded ?? this.isUploaded,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        createdOn: createdOn ?? this.createdOn,
        updatedOn: updatedOn ?? this.updatedOn,
        completedOn: completedOn ?? this.completedOn,
        referal: referal ?? this.referal,
        referalLv2: referalLv2 ?? this.referalLv2,
        referalLv3: referalLv3 ?? this.referalLv3,
        pageNumber: pageNumber ?? this.pageNumber,
        havavanTrackingStatus:
            havavanTrackingStatus ?? this.havavanTrackingStatus,
        isCreatedFile: isCreatedFile ?? this.isCreatedFile,
        urlResultFile: urlResultFile ?? this.urlResultFile,
        filePath: filePath ?? this.filePath,
        deliveringMethod: deliveringMethod ?? this.deliveringMethod,
        productName: productName ?? this.productName,
        discountPrice: discountPrice ?? this.discountPrice,
        shippingPrice: shippingPrice ?? this.shippingPrice,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        shippingAddress: shippingAddress ?? this.shippingAddress,
        logStatus: logStatus ?? this.logStatus,
        affiliateCode: affiliateCode ?? this.affiliateCode,
        coupon: coupon ?? this.coupon,
        odooOrderStatus: odooOrderStatus ?? this.odooOrderStatus,
        id: id ?? this.id,
        orderPrice: orderPrice ?? this.orderPrice,
        totalPrice: totalPrice ?? this.totalPrice,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['ref_user'] = refUser;
    map['haravan_order'] = haravanOrder;
    map['ref_phone'] = refPhone;
    map['phone'] = phone;
    map['product_id'] = productId;
    map['status'] = status;
    map['is_uploaded'] = isUploaded;
    map['modified_by'] = modifiedBy;
    map['created_on'] = createdOn;
    map['updated_on'] = updatedOn;
    map['completed_on'] = completedOn;
    map['referal'] = referal;
    map['referal_lv2'] = referalLv2;
    map['referal_lv3'] = referalLv3;
    map['page_number'] = pageNumber;
    map['havavan_tracking_status'] = havavanTrackingStatus;
    map['is_created_file'] = isCreatedFile;
    map['url_result_file'] = urlResultFile;
    map['file_path'] = filePath;
    map['delivering_method'] = deliveringMethod;
    map['product_name'] = productName;
    map['discount_price'] = discountPrice;
    map['shipping_price'] = shippingPrice;
    map['payment_method'] = paymentMethod;
    if (shippingAddress != null) {
      map['shipping_address'] = shippingAddress?.toJson();
    }
    map['log_status'] = logStatus;
    map['affiliate_code'] = affiliateCode;
    map['coupon'] = coupon;
    map['odoo_order_status'] = odooOrderStatus;
    map['id'] = id;
    map['order_price'] = orderPrice;
    map['total_price'] = totalPrice;
    return map;
  }
}

class ShippingAddress {
  ShippingAddress({
    this.address1,
    this.address2,
    this.city,
    this.company,
    this.country,
    this.firstName,
    this.lastName,
    this.phone,
    this.province,
    this.zip,
    this.name,
    this.provinceCode,
    this.countryCode,
    this.districtCode,
    this.district,
    this.wardCode,
    this.ward,
    this.device,
  });

  ShippingAddress.fromJson(dynamic json) {
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    company = json['company'];
    country = json['country'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    province = json['province'];
    zip = json['zip'];
    name = json['name'];
    provinceCode = json['province_code'];
    countryCode = json['country_code'];
    districtCode = json['district_code'];
    district = json['district'];
    wardCode = json['ward_code'];
    ward = json['ward'];
    device = json['device'];
  }

  String? address1;
  String? address2;
  String? city;
  String? company;
  String? country;
  String? firstName;
  String? lastName;
  String? phone;
  String? province;
  String? zip;
  String? name;
  String? provinceCode;
  String? countryCode;
  String? districtCode;
  String? district;
  String? wardCode;
  String? ward;
  int? device;

  ShippingAddress copyWith({
    String? address1,
    String? address2,
    String? city,
    String? company,
    String? country,
    String? firstName,
    String? lastName,
    String? phone,
    String? province,
    String? zip,
    String? name,
    String? provinceCode,
    String? countryCode,
    String? districtCode,
    String? district,
    String? wardCode,
    String? ward,
    int? device,
  }) =>
      ShippingAddress(
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        city: city ?? this.city,
        company: company ?? this.company,
        country: country ?? this.country,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        province: province ?? this.province,
        zip: zip ?? this.zip,
        name: name ?? this.name,
        provinceCode: provinceCode ?? this.provinceCode,
        countryCode: countryCode ?? this.countryCode,
        districtCode: districtCode ?? this.districtCode,
        district: district ?? this.district,
        wardCode: wardCode ?? this.wardCode,
        ward: ward ?? this.ward,
        device: device ?? this.device,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address1'] = address1;
    map['address2'] = address2;
    map['city'] = city;
    map['company'] = company;
    map['country'] = country;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['province'] = province;
    map['zip'] = zip;
    map['name'] = name;
    map['province_code'] = provinceCode;
    map['country_code'] = countryCode;
    map['district_code'] = districtCode;
    map['district'] = district;
    map['ward_code'] = wardCode;
    map['ward'] = ward;
    map['device'] = device;
    return map;
  }
}
