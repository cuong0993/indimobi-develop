class ObjectRes {
  ObjectRes({
    this.detail,
    this.code,
    this.messages,
  });

  ObjectRes.fromJson(dynamic json) {
    detail = json['detail'];
    code = json['code'];
    if (json['messages'] != null) {
      messages = [];
      json['messages'].forEach((v) {
        messages?.add(Messages.fromJson(v));
      });
    }
  }

  String? detail;
  String? code;
  List<Messages>? messages;

  ObjectRes copyWith({
    String? detail,
    String? code,
    List<Messages>? messages,
  }) =>
      ObjectRes(
        detail: detail ?? this.detail,
        code: code ?? this.code,
        messages: messages ?? this.messages,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = detail;
    map['code'] = code;
    if (messages != null) {
      map['messages'] = messages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Messages {
  Messages({
    this.tokenClass,
    this.tokenType,
    this.message,
  });

  Messages.fromJson(dynamic json) {
    tokenClass = json['token_class'];
    tokenType = json['token_type'];
    message = json['message'];
  }

  String? tokenClass;
  String? tokenType;
  String? message;

  Messages copyWith({
    String? tokenClass,
    String? tokenType,
    String? message,
  }) =>
      Messages(
        tokenClass: tokenClass ?? this.tokenClass,
        tokenType: tokenType ?? this.tokenType,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token_class'] = tokenClass;
    map['token_type'] = tokenType;
    map['message'] = message;
    return map;
  }
}
