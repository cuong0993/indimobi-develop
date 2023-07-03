class ConvertNumber {
  static String textLike(int like) {
    if (like > 999) {
      double count = like / 1000;
      return '${count.toDouble().toStringAsFixed(1)}K';
    } else {
      return like.toString();
    }
  }
}
