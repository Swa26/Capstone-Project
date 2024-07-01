import 'package:capstoneproject/AllCakes.dart';
import 'package:capstoneproject/ChocolateCakes.dart';
import 'package:capstoneproject/VanilaCakes.dart';
import 'package:capstoneproject/best_Sellers.dart';

import 'package:capstoneproject/cart_provider.dart';
import 'package:capstoneproject/new_thisWeek.dart';
import 'package:capstoneproject/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math' as math;
import 'package:toggle_switch/toggle_switch.dart';

String cakename = '';
Map<String, dynamic> cakeDData = {};

class ProductsWidget extends ConsumerStatefulWidget {
  const ProductsWidget({super.key});
  @override
  ConsumerState<ProductsWidget> createState() => _ProductsWidgetState();
  //_ProductsWidgetState createState() => _ProductsWidgetState();
}

List<String> list = ['S', 'M', 'L'];

class _ProductsWidgetState extends ConsumerState<ProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(stateProvider);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
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
      child: Padding(
        padding: EdgeInsets.only(top: 0.0),
        child: ListView(children: [
          Column(
            children: [
              OpenSans(
                text: 'What Would You Like To Eat??',
                fontweight: FontWeight.bold,
                size: 20.0,
                color: Colors.black,
              ),
              SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      height: 330.0,
                      width: 80.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60.0,
                          ),
                          Transform.rotate(
                            angle: -math.pi / 2,
                            child: MaterialButton(
                              minWidth: 0.0,
                              height: 0.0,
                              padding: EdgeInsets.only(
                                  top: 0.0, bottom: 0.0, left: 0.0, right: 0.0),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyGridView(),
                                ));
                              },
                              child: OpenSans(
                                  text: "Chocolate",
                                  size: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Transform.rotate(
                            angle: -math.pi / 2,
                            child: MaterialButton(
                              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                              minWidth: 0.0,
                              height: 0.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Vanilacakes(),
                                ));
                              },
                              child: OpenSans(
                                  text: "Vanila",
                                  size: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 60.0,
                          ),
                          Transform.rotate(
                            angle: -math.pi / 2,
                            child: MaterialButton(
                              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                              minWidth: 0.0,
                              height: 0.0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AllCakes(),
                                ));
                              },
                              child: OpenSans(
                                  text: "All Falvours",
                                  size: 16.0,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 0.0),
                        margin: EdgeInsets.only(left: 0.0),
                        height: 350.0,
                        width: width,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Cakes')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, index) {
                                  DocumentSnapshot documentSnapshot =
                                      snapshot.data!.docs[index];
                                  //cakename = documentSnapshot['title'];
                                  return GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                        backgroundColor: Color(0xffffb20a),
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OpenSans(
                                                      text: "Cake Name",
                                                      color: Colors.black,
                                                      fontweight:
                                                          FontWeight.bold,
                                                      alignment: TextAlign.left,
                                                    ),
                                                    OpenSans(
                                                      text: documentSnapshot[
                                                          'title'],
                                                      color: Colors.black,
                                                      fontweight:
                                                          FontWeight.bold,
                                                      alignment:
                                                          TextAlign.right,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OpenSans(
                                                      text: "Choose Size",
                                                      color: Colors.black,
                                                      fontweight:
                                                          FontWeight.bold,
                                                      alignment: TextAlign.left,
                                                    ),
                                                    ToggleSwitch(
                                                      activeBgColor: [
                                                        Color(0xff12AD2B),
                                                      ],
                                                      activeFgColor:
                                                          Colors.black,
                                                      inactiveBgColor:
                                                          Colors.white,
                                                      inactiveFgColor:
                                                          Colors.black,
                                                      initialLabelIndex: 0,
                                                      totalSwitches: 3,
                                                      labels: list,
                                                      onToggle: (index) {
                                                        cakename = list[index!];
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    OpenSans(
                                                      text: "Cake Price",
                                                      color: Colors.black,
                                                      fontweight:
                                                          FontWeight.bold,
                                                      alignment: TextAlign.left,
                                                    ),
                                                    OpenSans(
                                                      text: documentSnapshot[
                                                          'price'],
                                                      color: Colors.black,
                                                      fontweight:
                                                          FontWeight.bold,
                                                      alignment:
                                                          TextAlign.right,
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
                                                      "cakeName":
                                                          documentSnapshot[
                                                              'title'],
                                                      "cakeImage":
                                                          documentSnapshot[
                                                              'image'],
                                                      "cakePrice":
                                                          documentSnapshot[
                                                              'price'],
                                                      "cakeSize": cakename
                                                    };
                                                    provider
                                                        .addProduct(cakeDData);

                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                        context)
                                                      ..hideCurrentSnackBar()
                                                      ..showSnackBar(SnackBar(
                                                        content: OpenSans(
                                                          text:
                                                              "Item Added To Cart",
                                                          color: Colors.black,
                                                        ),
                                                        backgroundColor:
                                                            Color(0xffffb20a),
                                                      ));
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xff12AD2B),
                                                  ),
                                                  child: Text(
                                                    'Add to cart',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        SlideTransitionExample(
                                          url: documentSnapshot['image'],
                                          title: documentSnapshot['title'],
                                          ratings: documentSnapshot['rating'],
                                          price: documentSnapshot['price'],
                                        ),
                                      ],
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
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 0.0),
                    margin: EdgeInsets.only(left: 0.0),
                    height: 500.0,
                    width: width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Trending')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  if (documentSnapshot['title'].toString() ==
                                      'Best Seller') {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => BestSellers(),
                                    ));
                                  } else {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => NewThisWeek(),
                                    ));
                                  }
                                },
                                child: Column(
                                  children: [
                                    Trending(
                                      url: documentSnapshot['image'],
                                      title: documentSnapshot['title'],
                                    ),
                                  ],
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
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class SlideTransitionExample extends StatefulWidget {
  final url;

  final title;

  final price;

  final ratings;
  final color;

  const SlideTransitionExample(
      {super.key, this.url, this.title, this.price, this.ratings, this.color});

  @override
  State<SlideTransitionExample> createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //Color _color = ColorUtils.stringToColor(widget.color.toString());
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Color(0xffE39FF6),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.tealAccent,
        ),
      ),
      shadowColor: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.url,
                height: 200.0,
                width: 200.0,
                fit: BoxFit.fill,
              ),
            ),
            OpenSans(
              text: widget.title,
              color: Colors.black,
              fontweight: FontWeight.bold,
              size: 20.0,
            ),
            SizedBox(
              height: 5.0,
            ),
            OpenSans(
              text: widget.ratings,
              color: Colors.black,
              fontweight: FontWeight.normal,
              alignment: TextAlign.left,
            ),
            SizedBox(
              height: 5.0,
            ),
            OpenSans(
              text: widget.price,
              color: Colors.black,
              fontweight: FontWeight.bold,
              alignment: TextAlign.left,
            ),
            SizedBox(
              height: 10.0,
            ),
            OpenSans(
              text: "Click To Buy",
              color: Colors.black,
              fontweight: FontWeight.bold,
              alignment: TextAlign.left,
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}

class Trending extends StatefulWidget {
  final url;

  final title;

  const Trending({super.key, this.url, this.title});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffffb20a),
      margin: EdgeInsets.all(5.0),
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(
          color: Colors.tealAccent,
        ),
      ),
      shadowColor: Colors.tealAccent,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.url,
                height: 150.0,
                width: 180.0,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            OpenSans(
              text: widget.title,
              color: Colors.black,
              fontweight: FontWeight.bold,
              size: 20.0,
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
