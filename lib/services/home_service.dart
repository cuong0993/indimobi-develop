import 'package:dio/dio.dart' as form;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:indimobi/models/body/create_order_body.dart';
import 'package:indimobi/models/body/price_body.dart';
import 'package:indimobi/models/entity/set_price.dart';
import 'package:indimobi/models/response/create_order_res.dart';
import 'package:indimobi/models/response/order_detail_res.dart';
import 'package:indimobi/models/response/order_res.dart';
import 'package:indimobi/models/response/price_res.dart';
import 'package:indimobi/network/network_config.dart';
import 'package:indimobi/services/api.dart';
import 'package:indimobi/utils/logger.dart';

class HomeService extends GetxService {
  Future<HomeService> init() async {
    return this;
  }

  Dio appClient = Get.find<AppClient>().dio;

  Future<List<Orders>?> getListOrder({required String phone}) async {
    try {
      final res = await appClient.get(Apis.apiGetByPhone + phone);
      OrderRes response = OrderRes.fromJson(res.data);
      return response.orders;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<OrderDetailRes?> getDetailOder({required String id}) async {
    try {
      final res = await appClient.get(Apis.apiOderDetail + id);
      OrderDetailRes response = OrderDetailRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<PriceRes?> getPrice({required PriceBody body}) async {
    try {
      final res =
          await appClient.get(Apis.apiPrice, queryParameters: body.toJson());
      PriceRes? response = PriceRes.fromJson(res.data);

      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<CreateOderRes?> createOrder({required CreateOrderBody body}) async {
    try {
      final res = await appClient.post(
        Apis.apiCreateOder,
        data: body.toJson(),
      );
      CreateOderRes? response = CreateOderRes.fromJson(res.data);
      return response;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  Future<String?> createImage({required form.FormData formData}) async {
    try {
      final res = await appClient.post(Apis.apiUploadFileS3, data: formData);
      String? response = res.data;
      return response;
    } catch (e) {
      logger.i(e);
      return null;
    }
  }

  Future<SettingPrice?> getSetting() async {
    try {
      final res = await appClient.get(Apis.apiSetting);
      SettingPrice price = SettingPrice.fromJson(res.data);
      return price;
    } catch (e) {
      logger.e(e);
      return null;
    }
  }
}
