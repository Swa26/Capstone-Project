import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/login_handler.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScreenBeforeLogin extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final viewModelProvider = ref.watch(viewModel);
    useEffect(() {
      viewModelProvider.logout();
    });
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Center(
        child: Container(
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
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/1.png',
                    height: height / 1.5,
                    width: width / 2,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {
                      role = "user";
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoginHandler(),
                      ));
                    },
                    child: OpenSans(
                      text: "User",
                      color: Colors.black,
                      size: 30.0,
                      fontweight: FontWeight.bold,
                    ),
                    color: Color(0xffcceeed),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.all(15.0),
                    onPressed: () {
                      role = "admin";
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LoginHandler(),
                        ),
                      );
                    },
                    child: OpenSans(
                      text: "Admin",
                      color: Colors.black,
                      size: 30.0,
                      fontweight: FontWeight.bold,
                    ),
                    color: Color(0xffedccee),
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
