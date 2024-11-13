import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tca/routes.dart';
import 'package:tca/screen/not_found_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.manropeTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      title: 'CatFinder',
      routes: appRoutes,
      initialRoute: '/home',
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const NotFoundScreen(),
        );
      },
    );
  }
}
