import 'package:flutter/material.dart';

import 'package:crudqr/screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'home': (BuildContext context) => const HomeScreen(),
    'map': (BuildContext context) => const MapScreen(),
    'maps': (BuildContext context) => const MapsScreen(),
  };
}
