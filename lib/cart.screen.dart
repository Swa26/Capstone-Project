import 'package:capstoneproject/cart_provider.dart';
import 'package:capstoneproject/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends ConsumerStatefulWidget {
  CartScreen({
    super.key,
  });
  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
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
        title: Text("Cart"),
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
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              itemCount: provider.cartList.length,
              itemBuilder: (context, index) {
                final cartProduct = provider.cartList[index];
                final price = int.parse(cartProduct['cakePrice']);
                provider.totalPrice = provider.totalPrice + price;
                //print(totalPrice);
                //print(price);
                if (provider.cartList.isNotEmpty) {
                  return Dismissible(
                    key: Key(cartProduct['cakeName']),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (direction) {
                      provider.removeproduct(cartProduct);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Color(0xffE39FF6),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: Image.network(cartProduct['cakeImage']),
                        title: Text(cartProduct['cakeName']),
                        subtitle: Text(cartProduct['cakeSize']),
                        trailing: Text(cartProduct['cakePrice']),
                        tileColor: Color(0xffE39FF6),
                      ),
                    ),
                  );
                } else if (provider.cartList.isEmpty) {
                  return OpenSans(
                    text: "Your Cart Is Empty",
                    color: Colors.black,
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ShowDialog(context, ref);
          provider.orderedCakes.addAll(provider.cartList);
          print(provider.orderedCakes);
          provider.empty(provider.cartList);
          print(provider.orderedCakes);
        },
        child: OpenSans(
          text: "Place Order",
          color: Colors.black,
        ),
      ),
    );
  }
}
