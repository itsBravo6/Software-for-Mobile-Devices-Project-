import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class home extends StatefulWidget {
  static String id = 'home_screen';

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  List<String> users = [];
  late String userName;

  Future messageStream() async {
    await for (var snapshots in _firestore.collection('AppUsers').snapshots()) {
      for (var items in snapshots.docs) {
        users.add(items.toString());
      }
    }
  }

  void getUserData() {
    var snapShot = FirebaseFirestore.instance
        .collection("AppUsers")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
  }

  @override
  void initState() {
    super.initState();
    // messageStream();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("REGISTERED USERS")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('AppUsers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.all(10)),
                                Row(
                                  children: [
                                    Text(
                                      "USERNAME : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      document['userName'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          // /      fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Email : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      document['email'],
                                      style: TextStyle(
                                          fontSize: 18,
                                          //   fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Bio : ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      document['bio'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          //    fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
            }).toList(),
          );
        },
      ),
    );
  }
}
