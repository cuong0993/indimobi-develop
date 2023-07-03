import 'dart:io';

class CreateFileS3 {
  CreateFileS3({
    this.policy,
    this.key,
    this.signature,
    this.filename,
    this.acl,
    this.contentType,
    this.aWSAccessKeyId,
    this.file,
  });

  CreateFileS3.fromJson(dynamic json) {
    policy = json['Policy'];
    key = json['key'];
    signature = json['Signature'];
    filename = json['filename'];
    acl = json['acl'];
    contentType = json['Content-Type'];
    aWSAccessKeyId = json['AWSAccessKeyId'];
    file = json['file'];
  }
  String? policy;
  String? key;
  String? signature;
  String? filename;
  String? acl;
  String? contentType;
  String? aWSAccessKeyId;
  File? file;

  CreateFileS3 copyWith({
    String? policy,
    String? key,
    String? signature,
    String? filename,
    String? acl,
    String? contentType,
    String? aWSAccessKeyId,
    File? file,
  }) =>
      CreateFileS3(
        policy: policy ?? this.policy,
        key: key ?? this.key,
        signature: signature ?? this.signature,
        filename: filename ?? this.filename,
        acl: acl ?? this.acl,
        contentType: contentType ?? this.contentType,
        aWSAccessKeyId: aWSAccessKeyId ?? this.aWSAccessKeyId,
        file: file ?? this.file,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Policy'] = policy;
    map['key'] = key;
    map['Signature'] = signature;
    map['filename'] = filename;
    map['acl'] = acl;
    map['Content-Type'] = contentType;
    map['AWSAccessKeyId'] = aWSAccessKeyId;
    map['file'] = file;
    return map;
  }
}
