import 'package:capstoneproject/cart_provider.dart';
import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/productsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AllCakes extends ConsumerStatefulWidget {
  AllCakes({
    super.key,
  });
  @override
  ConsumerState<AllCakes> createState() => _AllCakesState();
}

class _AllCakesState extends ConsumerState<AllCakes> {
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
          title: Text('All Cakes'),
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
                FirebaseFirestore.instance.collection('AllCakes').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //mainAxisSpacing: 10,
                    //crossAxisSpacing: 10,
                    // Number of items in each row
                  ),
                  itemCount: snapshot.data!.docs.length,
                  // Total number of items
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    // final color = documentSnapshot['color'];
                    // Color _color = ColorUtils.stringToColor(color.toString());

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
                        decoration: BoxDecoration(
                            color: Color(0xffE39FF6),
                            borderRadius: BorderRadius.circular(10.0)),
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  documentSnapshot['image'],
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.fill,
                                ),
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
                              text: 'Rs: ${documentSnapshot['price']}/-',
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
        ));
  }
}
