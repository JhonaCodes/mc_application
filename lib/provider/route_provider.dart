import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Simple and poor route provider implementation.
class RouteProvider extends ChangeNotifier {
  int _route = 0;

  int get route => _route;

  void setRoute(int route) {
    _route = route;
    notifyListeners();
  }
}

final routeProvider = ChangeNotifierProvider<RouteProvider>((ref) => RouteProvider());