import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi/navigation/navigation_controller.dart';
import 'package:taxi/screens/authorization_screen.dart';
import 'package:taxi/navigation/routes.dart';
import 'package:taxi/screens/customer_screen.dart';
import 'package:taxi/screens/moderator_screen.dart';
import 'package:taxi/screens/registration_screen.dart';
import 'package:taxi/screens/volunteer_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
    ProviderScope(
      child: MaterialApp(
        locale: const Locale('ru'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // supportedLocales: const [
        //   Locale('ru'),
        // ],
        navigatorKey: NavigationController().key,
        //key: NavigationController().key,
        routes: {
          Routes.auth: (_) => const AuthorizationScreen(),
          Routes.reg: (_) => const RegistrationScreen(),
          Routes.mainVolunteer: (_) => const VolunteerScreen(),
          Routes.mainCustomer: (_) => const CustomerScreen(),
          Routes.mainModerator: (_) => const ModeratorScreen(),
        },
        // onGenerateRoute: (context, settings){
        //   return MaterialPageRoute(builder: (context)=>)
        // },
        initialRoute: Routes.auth,
      ),
    ),
  );
}