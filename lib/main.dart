import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:crudqr/providers/ui_provider.dart';
import 'package:crudqr/providers/scan_list_provider.dart';

import 'package:crudqr/routes/app_routes.dart';
import 'package:crudqr/themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => UiProvider())),
        ChangeNotifierProvider(create: ((context) => ScanListProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        theme: AppTheme.ligthTheme,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
      ),
    );
  }
}
