import 'dart:async';
import 'package:batikku/shared/theme.dart';
import 'package:batikku/ui/pages/home_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Membuat Animasi di splash Screen
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutCirc);

    _animationController.forward();

    Timer(
      // Mengatur durasi berapa lama animasi di splash screen berjalan
      const Duration(seconds: 3),
      () {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          print("replace");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeBottomNavigationBar(),
          ));
        } else {
          Navigator.of(context).pushReplacementNamed('/onboardingpage');
        }
      },
    );
  }

  @override
  void dispose() {
    // Menghentikan animasi dan membebaskan sumber daya
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightBackgroundColor,
              blueColor,
              greenColor,
              purpleColor,
              blackColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ScaleTransition(
            scale: _animation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/img_logo.png'),
                    ),
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        spreadRadius: 8,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Selamat Datang',
                  style: GoogleFonts.poppins(
                    color: whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Di Aplikasi Batikku',
                  style: GoogleFonts.poppins(
                    color: whiteColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 320),
                Text(
                  '@Support for Griya Batik Ilham',
                  style: GoogleFonts.poppins(
                    color: whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
