class SettingPrice {
  SettingPrice({
    this.photobookmocong15x15,
    this.photobookmocong20x20,
    this.photobookmocong25x25,
    this.photobookmocong30x30,
    this.photobookmophang15x15,
    this.photobookmophang20x20,
    this.photobookmophang25x25,
    this.pHOTOBOOKMOPHANG30x30,
  });

  SettingPrice.fromJson(dynamic json) {
    photobookmocong15x15 = json['PHOTOBOOK_MOCONG_15X15'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOCONG_15X15'])
        : null;
    photobookmocong20x20 = json['PHOTOBOOK_MOCONG_20X20'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOCONG_20X20'])
        : null;
    photobookmocong25x25 = json['PHOTOBOOK_MOCONG_25X25'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOCONG_25X25'])
        : null;
    photobookmocong30x30 = json['PHOTOBOOK_MOCONG_30X30'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOCONG_30X30'])
        : null;
    photobookmophang15x15 = json['PHOTOBOOK_MOPHANG_15X15'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOPHANG_15X15'])
        : null;
    photobookmophang20x20 = json['PHOTOBOOK_MOPHANG_20X20'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOPHANG_20X20'])
        : null;
    photobookmophang25x25 = json['PHOTOBOOK_MOPHANG_25X25'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOPHANG_25X25'])
        : null;
    pHOTOBOOKMOPHANG30x30 = json['PHOTOBOOK_MOPHANG_30x30'] != null
        ? PhotoBook.fromJson(json['PHOTOBOOK_MOPHANG_30x30'])
        : null;
  }

  PhotoBook? photobookmocong15x15;
  PhotoBook? photobookmocong20x20;
  PhotoBook? photobookmocong25x25;
  PhotoBook? photobookmocong30x30;
  PhotoBook? photobookmophang15x15;
  PhotoBook? photobookmophang20x20;
  PhotoBook? photobookmophang25x25;
  PhotoBook? pHOTOBOOKMOPHANG30x30;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PHOTOBOOK_MOCONG_15X15'] = photobookmocong15x15;
    map['PHOTOBOOK_MOCONG_20X20'] = photobookmocong20x20;
    map['PHOTOBOOK_MOCONG_25X25'] = photobookmocong25x25;
    map['PHOTOBOOK_MOCONG_30X30'] = photobookmocong30x30;
    map['PHOTOBOOK_MOPHANG_15X15'] = photobookmophang15x15;
    map['PHOTOBOOK_MOPHANG_20X20'] = photobookmophang20x20;
    map['PHOTOBOOK_MOPHANG_25X25'] = photobookmophang25x25;
    if (pHOTOBOOKMOPHANG30x30 != null) {
      map['PHOTOBOOK_MOPHANG_30x30'] = pHOTOBOOKMOPHANG30x30?.toJson();
    }
    return map;
  }
}

class PhotoBook {
  PhotoBook({
    this.toiDa,
    this.themTrang,
    this.khoiTaoThemTrang,
    this.giaTrang,
    this.giaBan,
    this.indiIDTrang,
    this.indiID,
    this.soTrangMacDinh,
  });

  PhotoBook.fromJson(dynamic json) {
    toiDa = json['ToiDa'];
    themTrang = json['ThemTrang'];
    khoiTaoThemTrang = json['KhoiTaoThemTrang'];
    giaTrang = json['GiaTrang'];
    giaBan = json['GiaBan:'];
    indiIDTrang = json['Indi_ID_Trang:'];
    indiID = json['Indi_ID'];
    soTrangMacDinh = json['so_trang_mac_dinh'];
  }

  String? toiDa;
  String? themTrang;
  String? khoiTaoThemTrang;
  String? giaTrang;
  String? giaBan;
  String? indiIDTrang;
  String? indiID;
  String? soTrangMacDinh;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ToiDa'] = toiDa;
    map['ThemTrang'] = themTrang;
    map['KhoiTaoThemTrang'] = khoiTaoThemTrang;
    map['GiaTrang'] = giaTrang;
    map['GiaBan:'] = giaBan;
    map['Indi_ID_Trang:'] = indiIDTrang;
    map['Indi_ID'] = indiID;
    map['so_trang_mac_dinh'] = soTrangMacDinh;
    return map;
  }
}
