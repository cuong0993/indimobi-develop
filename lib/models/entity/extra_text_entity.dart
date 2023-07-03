import 'package:flutter/material.dart';

class ExtraTextEntity {
  String content;
  double fontSize;
  TextAlign alignment;

  ExtraTextEntity({
    this.alignment = TextAlign.center,
    this.content = '',
    this.fontSize = 6,
  });
}
