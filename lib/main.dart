import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meditator/router/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Meditate Application",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.lato().fontFamily),
      routerConfig: AppRouter().appRoutes,
    );
  }
}
