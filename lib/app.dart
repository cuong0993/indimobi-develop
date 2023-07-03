import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:indimobi/app_ctrl.dart';
import 'package:indimobi/commons/app_themes.dart';
import 'package:indimobi/database/hive_db.dart';
import 'package:indimobi/database/shared_pref.dart';
import 'package:indimobi/generated/l10n.dart';
import 'package:indimobi/models/entity/address_entity.dart';
import 'package:indimobi/models/entity/hive_entity/album_entity.dart';
import 'package:indimobi/models/entity/hive_entity/pages_entity.dart';
import 'package:indimobi/models/entity/hive_entity/photos_entity.dart';
import 'package:indimobi/models/entity/hive_entity/size_entity.dart';
import 'package:indimobi/models/entity/hive_entity/stickers_entity.dart';
import 'package:indimobi/models/entity/hive_entity/texts_entity.dart';
import 'package:indimobi/network/network_config.dart';
import 'package:indimobi/screens/splash_page/splash_page.dart';
import 'package:indimobi/services/auth_service.dart';
import 'package:indimobi/services/home_service.dart';

Future initService() async {
  await Get.putAsync(() => HiveData().init());
  Hive.registerAdapter(AlbumEntityAdapter());
  Hive.registerAdapter(AddressEntityAdapter());
  Hive.registerAdapter(PagesEntityAdapter());
  Hive.registerAdapter(PhotosEntityAdapter());
  Hive.registerAdapter(SizeEntityAdapter());
  Hive.registerAdapter(StickersEntityAdapter());
  Hive.registerAdapter(TextsEntityAdapter());

  await Get.putAsync(() => AppClient().init());
  await Get.putAsync(() => SharedPref().init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => HomeService().init());
  Get.put<AppCtrl>(AppCtrl());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  AppCtrl appCtrl = Get.find<AppCtrl>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      theme: AppThemes(isDarkMode: false).theme,
      darkTheme: AppThemes(isDarkMode: true).theme,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.rightToLeftWithFade,
      opaqueRoute: Get.isOpaqueRouteDefault,
      popGesture: Get.isPopGestureEnable,
      transitionDuration: const Duration(milliseconds: 100),
      home: const SplashPage(),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', ''),
      ],
      locale: const Locale('vi', ''),
      debugShowCheckedModeBanner: false,
    );
  }
}
