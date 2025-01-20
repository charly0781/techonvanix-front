import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:techonvanix/src/app.dart';
import 'package:techonvanix/src/process/dto/GlobalData.dart';
import 'package:techonvanix/src/service/ApiService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Necesario para operaciones asíncronas antes de runApp

  const baseUrl = 'http://back.techonvanix.com';
  final apiServicio = ApiServicio(baseUrl: baseUrl);

  try {
    // Inicializar datos globales
    await GlobalData.initializeData(apiServicio);
  } catch (e) {
      print('Error durante la inicialización: $e');
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}
