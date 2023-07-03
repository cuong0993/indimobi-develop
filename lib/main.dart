import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:indimobi/app.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await initService();
  runApp(const App());
}
