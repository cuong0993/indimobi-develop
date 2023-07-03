class CreateOderRes {
  CreateOderRes({
    this.order,
    this.status,
    this.detail,
    this.s3Info,
    this.dropboxInfo,
  });

  CreateOderRes.fromJson(dynamic json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    status = json['status'];
    detail = json['detail'];
    s3Info = json['s3_info'] != null ? S3Info.fromJson(json['s3_info']) : null;
    dropboxInfo = json['dropbox_info'];
  }
  Order? order;
  bool? status;
  String? detail;
  S3Info? s3Info;
  String? dropboxInfo;
  CreateOderRes copyWith({
    Order? order,
    bool? status,
    String? detail,
    S3Info? s3Info,
    String? dropboxInfo,
  }) =>
      CreateOderRes(
        order: order ?? this.order,
        status: status ?? this.status,
        detail: detail ?? this.detail,
        s3Info: s3Info ?? this.s3Info,
        dropboxInfo: dropboxInfo ?? this.dropboxInfo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (order != null) {
      map['order'] = order?.toJson();
    }
    map['status'] = status;
    map['detail'] = detail;
    if (s3Info != null) {
      map['s3_info'] = s3Info?.toJson();
    }
    map['dropbox_info'] = dropboxInfo;
    return map;
  }
}

class S3Info {
  S3Info({
    this.policy,
    this.signature,
    this.key,
    this.acl,
    this.contentType,
    this.aWSAccessKeyId,
  });

  S3Info.fromJson(dynamic json) {
    policy = json['Policy'];
    signature = json['Signature'];
    key = json['key'];
    acl = json['acl'];
    contentType = json['Content-Type'];
    aWSAccessKeyId = json['AWSAccessKeyId'];
  }
  String? policy;
  String? signature;
  String? key;
  String? acl;
  String? contentType;
  String? aWSAccessKeyId;
  S3Info copyWith({
    String? policy,
    String? signature,
    String? key,
    String? acl,
    String? contentType,
    String? aWSAccessKeyId,
  }) =>
      S3Info(
        policy: policy ?? this.policy,
        signature: signature ?? this.signature,
        key: key ?? this.key,
        acl: acl ?? this.acl,
        contentType: contentType ?? this.contentType,
        aWSAccessKeyId: aWSAccessKeyId ?? this.aWSAccessKeyId,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Policy'] = policy;
    map['Signature'] = signature;
    map['key'] = key;
    map['acl'] = acl;
    map['Content-Type'] = contentType;
    map['AWSAccessKeyId'] = aWSAccessKeyId;
    return map;
  }
}

class Order {
  Order({
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
  });

  Order.fromJson(dynamic json) {
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
    shippingAddress = json['shipping_address'];
    logStatus = json['log_status'];
    affiliateCode = json['affiliate_code'];
    coupon = json['coupon'];
    odooOrderStatus = json['odoo_order_status'];
  }
  int? user;
  String? refUser;
  int? haravanOrder;
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
  String? shippingAddress;
  String? logStatus;
  String? affiliateCode;
  String? coupon;
  String? odooOrderStatus;
  Order copyWith({
    int? user,
    String? refUser,
    int? haravanOrder,
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
    String? shippingAddress,
    String? logStatus,
    String? affiliateCode,
    String? coupon,
    String? odooOrderStatus,
  }) =>
      Order(
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
    map['shipping_address'] = shippingAddress;
    map['log_status'] = logStatus;
    map['affiliate_code'] = affiliateCode;
    map['coupon'] = coupon;
    map['odoo_order_status'] = odooOrderStatus;
    return map;
  }
}
