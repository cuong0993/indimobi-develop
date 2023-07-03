import 'package:logger/logger.dart';

MyLogger logger = MyLogger();

class MyLogger {
  Logger logger = Logger();

  void v(dynamic message) {
    logger.v("🤍 VERBOSE: $message");
  }

  void d(dynamic message) {
    logger.d("💙 DEBUG: $message");
  }

  void i(dynamic message) {
    logger.i("💚️ INFO: $message");
  }

  void w(dynamic message) {
    logger.w("💛 WARNING: $message");
  }

  void e(dynamic message) {
    logger.e("❤️ ERROR: $message");
  }
}
