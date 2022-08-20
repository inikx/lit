import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lit/constants/strings.dart';
import 'package:lit/data/providers/filters_provider.dart';
import 'package:lit/data/providers/location_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:lit/constants/locator.dart';
import 'package:lit/route.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  await setupLocator();
  runApp(LitApp(router: AppRouter()));
}

class LitApp extends StatelessWidget {
  final AppRouter router;
  const LitApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FiltersProvider>(
            create: (context) => FiltersProvider(),
          ),
          ChangeNotifierProvider<LocationProvider>(
            create: (context) => LocationProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('ru'),
            ],
            onGenerateRoute: router.generateRoute,
            initialRoute: AUTH,
            title: "Lit",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
          );
        });
  }
}
