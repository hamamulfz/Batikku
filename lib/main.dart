import 'package:batikku/ui/pages/detail_page.dart';
import 'package:batikku/ui/pages/home_page.dart';
import 'package:batikku/ui/pages/onboarding_page.dart';
import 'package:batikku/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      initialRoute: '/splashpage',
      routes: {
        '/splashpage': (context) => const SplashPage(),
        '/onboardingpage': (context) => const OnboardingPage(),
        '/homepage': (context) => const HomePage(),
        '/detailpage': (context) => DetailPage(result: 0),
      },
    );
  }
}
