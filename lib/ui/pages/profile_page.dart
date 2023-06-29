import 'package:batikku/ui/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Ganti dengan path yang sesuai ke halaman LoginPage

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Masuk Sebagai : " + user.email!),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(
                      showRegisterPage: () {},
                    ),
                  ),
                  (route) => false,
                );
              },
              color: Colors.redAccent,
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
