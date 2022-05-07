import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wallpaperapp/binding/controller_binding.dart';
import 'package:wallpaperapp/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Stunning Wallpapers',
      theme: ThemeData(
        fontFamily: GoogleFonts.merriweather().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.white,
      ),
      home: HomeScreen(),
    );
  }
}
