import 'package:capstoneproject/cart_provider.dart';
import 'package:capstoneproject/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

class Orders extends ConsumerStatefulWidget {
  Orders({
    super.key,
  });
  @override
  ConsumerState<Orders> createState() => _OrdersState();
}

class _OrdersState extends ConsumerState<Orders> {
  Map<String, dynamic>? userMapC;
  bool isLoading = false;
  Logger logger = Logger();
  @override
  void initState() {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    _fireStore
        .collection('Orders')
        .where('Email', isEqualTo: username.toString())
        .get()
        .then((value) {
      setState(() {
        userMapC = value.docs[0].data();
        isLoading = false;
      });
      print(userMapC);
      //print(courseName);
    });

    //fetchdocument();
    super.initState();
  }

  final _firebaseStream =
      FirebaseFirestore.instance.collection('Orders').snapshots();
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(stateProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Orders"),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontSize: 20.0,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffedccee),
              Color(0xffcceeed),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Container(
              child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Connection error");
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading...");
                    }

                    var docs = snapshot.data!.docs;
                    return ListTile(
                      onTap: () => null,
                      title: Text('Order id: ${userMapC!['order_id']}'),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status: ${userMapC!['currentStatus']}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: userMapC!['status']['orderAccepted']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: userMapC!['status']['prepared']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: userMapC!['status']['outForDelivery']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: userMapC!['status']['delivered']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ]),
                    );
                  })),
        ),
      ),
    );
  }
}

/*StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _firebaseStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Connection error");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }

                var docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => null,
                      title: Text('Order id: ${docs[index]['order_id']}'),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Status: ${docs[index]['currentStatus']}'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: docs[index]['status']['orderAccepted']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: docs[index]['status']['prepared']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: docs[index]['status']
                                          ['outForDelivery']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 10,
                                  height: 10,
                                  color: docs[index]['status']['delivered']!
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ]),
                    );
                  },
                );
              },
            ), */
