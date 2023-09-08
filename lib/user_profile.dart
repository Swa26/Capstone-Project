import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/main.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final Provider = ref.watch(stateProvider);
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  _HomeState createState() => _HomeState();
}

final ss = username.split('@')[0];
String uname = ss.toString().capitalizeS();

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print(ss);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              OpenSans(
                text: 'Hello $uname',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
              SizedBox(
                height: 10.0,
              ),
              Image.network(
                'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?size=626&ext=jpg&ga=GA1.1.1437964836.1692623103&semt=sph',
                height: 300.0,
                width: 300.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              OpenSans(
                text: 'Email: $username',
                color: Colors.black,
                size: 18.0,
                fontweight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension StringExtensions on String {
  String capitalizeS() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
