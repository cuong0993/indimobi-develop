import 'package:indimobi/models/entity/address_entity.dart';

class ValidateString {
  static String validateMail({required String email}) {
    RegExp regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (email.trim().isEmpty) {
      return 'Enter your email!';
    } else if (!regex.hasMatch(email)) {
      return 'Validate Email!';
    } else {
      return '';
    }
  }

  static String validatePass(
      {required String pass, required String confirmPass}) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])$';
    RegExp regExp = RegExp(pattern);
    if (pass.trim().isEmpty) {
      return 'Enter your pass!';
    } else if (pass.trim().length < 8) {
      return 'MK > 6 chu so';
    } else if (regExp.hasMatch(pass)) {
      return 'Validate pass co chu in hoa , in thuong va so';
    } else if (confirmPass != pass) {
      return 'Password must same confirm password';
    } else {
      return '';
    }
  }

  static String validateAddress({required AddressEntity addressEntity}) {
    if (addressEntity.name.isEmpty) {
      return 'Nhập tên của bạn!';
    } else if (addressEntity.phone.isEmpty) {
      return 'Nhập số điện thoại của bạn!';
    } else if (addressEntity.phone.length < 10) {
      return 'Bạn đã nhập sai số điện thoại!';
    } else if (addressEntity.address.isEmpty) {
      return 'Nhập địa chỉ của bạn!';
    } else if (addressEntity.city.isEmpty) {
      return 'Nhập tỉnh/thành phố của bạn!';
    } else if (addressEntity.district.isEmpty) {
      return 'Nhập quận/huyện của bạn!';
    } else if (addressEntity.commune.isEmpty) {
      return 'Nhập phường/xã của bạn!';
    } else {
      return '';
    }
  }
}
