import 'package:flutter/cupertino.dart';

class NavigationController {
  static final NavigationController _controller =
      NavigationController._internal();

  factory NavigationController() => _controller;

  NavigationController._internal();

  final GlobalKey<NavigatorState> _key = GlobalKey();

  GlobalKey<NavigatorState> get key => _key;

  Future? pushNamed(String page, {Object? arguments}) =>
      _key.currentState?.pushNamed(page, arguments: arguments);

  Future? pushWithReplaceNamed(String page, {Object? arguments}) =>
      _key.currentState?.pushReplacementNamed(page, arguments: arguments);

  void pop([Object? result]) {
    _key.currentState?.pop(result);
  }
}
