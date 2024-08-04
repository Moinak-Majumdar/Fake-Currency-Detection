import 'package:flutter_app/screens/landing.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// import 'package:flutter_app/widgets/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    return GetMaterialApp(
      title: 'Fake currency detection',
      theme: FlexThemeData.light(
        scheme: FlexScheme.brandBlue,
        useMaterial3: true,
        textTheme: GoogleFonts.montserratTextTheme().copyWith().apply(
              displayColor: Colors.black,
              bodyColor: Colors.grey.shade900,
            ),
      ).copyWith(
        appBarTheme: const AppBarTheme().copyWith(
          centerTitle: true,
          elevation: 2,
          shadowColor: Colors.grey.shade100,
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
          backgroundColor: Colors.grey.shade200,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LandingPage(),
    );
  }
}
