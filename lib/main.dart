import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:taxi/components/app.dart';

void _initLogger() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      log('${record.level.name}: ${record.message}: ${record.stackTrace}');
    });
  }
}

void main() {
  _initLogger();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}