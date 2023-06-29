import 'package:batikku/auth/main_page.dart';
import 'package:batikku/ui/pages/detail_page.dart';
import 'package:batikku/ui/pages/home_page.dart';
import 'package:batikku/ui/pages/login_page.dart';
import 'package:batikku/ui/pages/onboarding_page.dart';
import 'package:batikku/ui/pages/register_page.dart';
import 'package:batikku/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await Firebase.initializeApp();
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
        '/mainpage': (context) => const MainPage(),
        '/loginpage': (context) => LoginPage(showRegisterPage: () {
              Navigator.pushNamed(context, '/registerpage');
            }),
        '/registerpage': (context) => RegisterPage(showLoginPage: () {
              Navigator.pushNamed(context, '/loginpage');
            }),
        '/onboardingpage': (context) => const OnboardingPage(),
        '/homepage': (context) => const HomePage(),
        '/detailpage': (context) => DetailPage(result: 0),
      },
    );
  }
}
