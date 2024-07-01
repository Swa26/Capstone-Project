import 'package:capstoneproject/view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components.dart';
import 'orders.dart';

class OrdersView extends ConsumerStatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> {
  final _firebaseStream =
      FirebaseFirestore.instance.collection('Orders').snapshots();

  @override
  Widget build(BuildContext context) {
    final viewModelProvider = ref.watch(viewModel);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xffcceeed),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset('assets/images/bolo.svg'),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              MaterialButton(
                elevation: 20.0,
                height: 50.0,
                minWidth: 200.0,
                color: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () async {
                  await viewModelProvider.logout();
                },
                child: OpenSans(
                  text: "Logout",
                  color: Colors.black,
                  size: 20.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://www.instagram.com/swanand_joshi_/'),
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icons8-instagram.svg',
                      width: 50.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse('www.linkedin.com/in/swanand-joshi26'),
                      );
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icons8-linkedin.svg',
                      width: 50.0,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Home"),
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

              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () => DialogBox(context, docs, index, snapshot),
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
                            )
                          ]),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  DialogBox(BuildContext context, List<QueryDocumentSnapshot<Object?>> docs,
      int index, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    bool orderAcceptedCheckBox = docs[index]['status']['orderAccepted']!;
    bool preparedCheckBox = docs[index]['status']['prepared']!;
    bool outForDeliveryCheckBox = docs[index]['status']['outForDelivery']!;
    bool deliveredCheckBox = docs[index]['status']['delivered']!;
    var docId = snapshot.data!.docs[index].id;

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: EdgeInsets.all(32.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(width: 2.0, color: Colors.black)),
        title: Text(docId),
        actions: [
          Column(children: [
            Row(
              children: [
                Text(
                  'Order Accepted',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: orderAcceptedCheckBox,
                    onChanged: (bool? val) {
                      setState(() {
                        orderAcceptedCheckBox = val!;
                        print(orderAcceptedCheckBox);
                      });
                    },
                  );
                })
              ],
            ),
            Row(
              children: [
                Text(
                  'Prepared',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: preparedCheckBox,
                    onChanged: (bool? val) {
                      setState(() {
                        preparedCheckBox = val!;
                      });
                    },
                  );
                })
              ],
            ),
            Row(
              children: [
                Text(
                  'Out for delivery',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: outForDeliveryCheckBox,
                    onChanged: (bool? val) {
                      setState(() {
                        outForDeliveryCheckBox = val!;
                      });
                    },
                  );
                })
              ],
            ),
            Row(
              children: [
                Text(
                  'Delivered',
                  style: TextStyle(fontSize: 17.0),
                ), //Tex
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                StatefulBuilder(builder: (context, setState) {
                  return Checkbox(
                    value: deliveredCheckBox,
                    onChanged: (val) {
                      setState(() {
                        deliveredCheckBox = val!;
                      });
                    },
                  );
                }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Name: "),
                Text(docs[index]['Name']),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Size: "),
                Text(docs[index]['orderSize']),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Price: "),
                Text(docs[index]['totalPrice']),
              ],
            ),
          ]),
          MaterialButton(
            onPressed: () async {
              setState(() {
                saveDetails(
                    docId,
                    docs,
                    index,
                    orderAcceptedCheckBox,
                    preparedCheckBox,
                    outForDeliveryCheckBox,
                    deliveredCheckBox);
                Navigator.pop(context);
              });
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            color: Colors.grey,
            child: Column(
              children: [
                Text("Save"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

void saveDetails(
    String docId,
    List<QueryDocumentSnapshot<Object?>> docs,
    int index,
    bool orderAcceptedCheckBox,
    bool preparedCheckBox,
    bool outForDeliveryCheckBox,
    bool deliveredCheckBox) async {
  CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('Orders');

  var currentStatus = "";
  if (orderAcceptedCheckBox) {
    currentStatus = "Order Accepted";
    if (preparedCheckBox) {
      currentStatus = "Order Prepared";
      if (outForDeliveryCheckBox) {
        currentStatus = "Out for delivery";
        if (deliveredCheckBox) {
          currentStatus = "Delivered";
        }
      }
    }
  }

  print(docs[index]['status']['outForDelivery']);
  ordersCollection.doc(docId).update({
    "currentStatus": currentStatus,
    "status": {
      "orderAccepted": orderAcceptedCheckBox,
      "prepared": preparedCheckBox,
      "outForDelivery": outForDeliveryCheckBox,
      "delivered": deliveredCheckBox,
    },
  }).then((value) => {
        print("Updated"),
      });
  print("Completed");
}
