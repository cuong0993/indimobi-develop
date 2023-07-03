/// define các đầu api tại đây
class Apis {
  static const String apiToken = '/apis/token/';
  static const String apiRefreshToken = '/apis/token/refresh/';
  static const String apiDeviceCreate = '/apis/devices/create/';
  static const String apiDeviceDetail = '/apis/devices/detail';
  static const String apiSendOtp = '/apis/devices/sendotp/';
  static const String apiValidateOtp = '/apis/devices/validateotp/';
  static const String apiCreateOder = '/apis/indi/order/';
  static const String apiGetByPhone = '/indi/orders/';
  static const String apiOderDetail = '/indi/';
  static const String apiStatusLog = '/indi/statuslog/';
  static const String apiPrice =
      'https://indi.mobi/apis/price/?indi_id_value=1033988793&page_number=12';
  static const String apiSetting =
      '/apis/settings/?setting=DANH%20MUC%20SAN%20PHAM';
  static const String apiUploadFileS3 =
      'https://indi-backend.s3-ap-southeast-1.amazonaws.com/';
}
