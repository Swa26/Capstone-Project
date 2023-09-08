import 'package:capstoneproject/cart_provider.dart';
import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/productsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Vanilacakes extends ConsumerStatefulWidget {
  Vanilacakes({
    super.key,
  });
  @override
  ConsumerState<Vanilacakes> createState() => _VanilacakesState();
}

class _VanilacakesState extends ConsumerState<Vanilacakes> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(stateProvider);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Vanila Cakes'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
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
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('VanilaCakes').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: snapshot.data!.docs.length,
                // Total number of items
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Color(0xffffb20a),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OpenSans(
                                      text: "Cake Name",
                                      color: Colors.black,
                                      fontweight: FontWeight.bold,
                                      alignment: TextAlign.left,
                                    ),
                                    OpenSans(
                                      text: documentSnapshot['title'],
                                      color: Colors.black,
                                      fontweight: FontWeight.bold,
                                      alignment: TextAlign.right,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OpenSans(
                                      text: "Choose Size",
                                      color: Colors.black,
                                      fontweight: FontWeight.bold,
                                      alignment: TextAlign.left,
                                    ),
                                    ToggleSwitch(
                                      activeBgColor: [
                                        Color(0xff12AD2B),
                                      ],
                                      activeFgColor: Colors.black,
                                      inactiveBgColor: Colors.white,
                                      inactiveFgColor: Colors.black,
                                      initialLabelIndex: 0,
                                      totalSwitches: 3,
                                      labels: list,
                                      onToggle: (index) {
                                        cakename = list[index!];
                                        print(cakename);
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OpenSans(
                                      text: "Cake Price",
                                      color: Colors.black,
                                      fontweight: FontWeight.bold,
                                      alignment: TextAlign.left,
                                    ),
                                    OpenSans(
                                      text: documentSnapshot['price'],
                                      color: Colors.black,
                                      fontweight: FontWeight.bold,
                                      alignment: TextAlign.right,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    cakeDData = {
                                      "cakeName": documentSnapshot['title'],
                                      "cakeImage": documentSnapshot['image'],
                                      "cakePrice": documentSnapshot['price'],
                                      "cakeSize": cakename
                                    };
                                    provider.addProduct(cakeDData);
                                    print(provider.cartList);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                        content: OpenSans(
                                          text: "Item Added To Cart",
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Color(0xffffb20a),
                                      ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff12AD2B),
                                  ),
                                  child: Text(
                                    'Add to cart',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      color: Color(0xffE39FF6),
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              documentSnapshot['image'],
                              height: 150.0,
                              width: 150.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          OpenSans(
                            text: documentSnapshot['title'],
                            color: Colors.black,
                            fontweight: FontWeight.bold,
                            size: 12.0,
                          ),
                          SizedBox(height: 5.0),
                          OpenSans(
                            text: documentSnapshot['price'],
                            color: Colors.black,
                            fontweight: FontWeight.bold,
                            size: 12.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
