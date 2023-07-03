class PriceBody {
  PriceBody({
    this.indiIdValue,
    this.pageNumber,
  });

  PriceBody.fromJson(dynamic json) {
    indiIdValue = json['indi_id_value'];
    pageNumber = json['page_number'];
  }

  String? indiIdValue;
  int? pageNumber;

  PriceBody copyWith({
    String? indiIdValue,
    int? pageNumber,
  }) =>
      PriceBody(
        indiIdValue: indiIdValue ?? this.indiIdValue,
        pageNumber: pageNumber ?? this.pageNumber,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['indi_id_value'] = indiIdValue;
    map['page_number'] = pageNumber;
    return map;
  }
}
