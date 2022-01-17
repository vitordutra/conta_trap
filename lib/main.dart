import 'package:conta_trap/src/conta_trap_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // removida a cor cinza de overlay da status bar do Android
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ),);
  runApp(const ContaTrapApp(),);
}
