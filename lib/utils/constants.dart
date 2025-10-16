import 'package:flutter/material.dart';

///Here you can save all the "global" variables you might use in your app

///Global navigator key
final navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();


class AppConstants {
  static const String appName = 'Mailofly';
  static const String apiBaseUrl = 'https://www.mailofly.com/api';
}