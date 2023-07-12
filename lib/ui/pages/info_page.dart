import 'package:batikku/ui/pages/info_detail_page.dart';
import 'package:batikku/ui/pages/info_add_data_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Future<QuerySnapshot<Map<String, dynamic>>> getDataFromFirebase() async {
    return await FirebaseFirestore.instance.collection("data").get();
  }

  bool isAdmin = false;
  getDataUserFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser!;
    final uid = user.uid;
    print("path $uid");
    final data =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    final adminStatus = (data.data() as Map<String, dynamic>)['is_admin'];
    isAdmin = adminStatus;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFirebase();
    getDataUserFromFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: !isAdmin
          ? Container()
          : FloatingActionButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InfoAddDataPage(),
              ));
            }),
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
            final datas = snapshot.data?.docs;
            // print(data);
            return ListView.builder(
                itemCount: (datas ?? []).length,
                itemBuilder: (context, i) {
                  final data = datas![i].data();
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            InfoDetailPage(result: int.parse(data?['id'])),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data?['name'] ?? ""),
                                  Text(data?['desc'].toString() ?? ""),
                                  // Text(data?['price'] ?? ""),
                                  // Text(data?['last_name'] ?? ""),
                                  // Text("Masuk Sebagai : " + user.email!),
                                  // SizedBox(height: 20),
                                  // MaterialButton(
                                  //   onPressed: () {
                                  //     FirebaseAuth.instance.signOut();
                                  //     Navigator.pushAndRemoveUntil(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => LoginPage(
                                  //           showRegisterPage: () {
                                  //             Navigator.pushNamed(context, '/registerpage');
                                  //           },
                                  //         ),
                                  //       ),
                                  //       (route) => false,
                                  //     );
                                  //   },
                                  //   color: Colors.redAccent,
                                  //   child: Text('Sign Out'),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
