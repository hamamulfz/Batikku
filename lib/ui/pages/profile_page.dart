import 'package:batikku/ui/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFirebase() async {
    final uid = user.uid;
    print("path $uid");
    return await FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: FutureBuilder(
          future: getDataFromFirebase(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error");
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final data = snapshot.data?.data();
            print(data);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data?['email'] ?? ""),
                Text(data?['age'].toString() ?? ""),
                Text(data?['first_name'] ?? ""),
                Text(data?['last_name'] ?? ""),
                Text("Masuk Sebagai : " + user.email!),
                SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          showRegisterPage: () {
                            Navigator.pushNamed(context, '/registerpage');
                          },
                        ),
                      ),
                      (route) => false,
                    );
                  },
                  color: Colors.redAccent,
                  child: Text('Sign Out'),
                ),
              ],
            );
          }),
    );
  }
}
