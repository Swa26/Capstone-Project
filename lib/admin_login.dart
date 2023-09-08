import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/screenBefore_login.dart';
import 'package:capstoneproject/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminLoginView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('B.Tech CakeWala(Admin)'),
          titleTextStyle: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20.0,
          ),
          centerTitle: true,
        ),
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: deviceHeight / 5.5,
                  ),
                  Center(
                    child: Image.network(
                      'https://img.freepik.com/free-photo/delicious-cake-with-fruits_23-2150727719.jpg?size=626&ext=jpg&ga=GA1.1.1021034273.1693909009&semt=ais',
                      width: 300.0,
                      height: 200.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  EmailAndPassWordFields(),
                  SizedBox(
                    height: 30.0,
                  ),
                  RegisterAndLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController _emailField = TextEditingController();
TextEditingController _passwordField = TextEditingController();
final formkey = GlobalKey<FormState>();

class EmailAndPassWordFields extends HookConsumerWidget {
  //final List _name = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Form(
      key: formkey,
      child: Column(
        children: [
          //Email
          SizedBox(
            width: 350.0,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: _emailField,
              validator: (value) {
                if (!value.toString().contains('@btechadmin.com')) {
                  return DialogBoxtutor(context,
                      "Please Follow The Tutor's Instructions Given By Organization");
                }
              },
              onChanged: (value) {
                username = _emailField.text;
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: "Email",
                hintStyle: GoogleFonts.openSans(),
              ),
            ),
          ),

          SizedBox(
            height: 20.0,
          ),

          //Password
          SizedBox(
            width: 350.0,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: _passwordField,
              obscureText: viewModelProvide.isObscure,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    viewModelProvide.toggleObscure();
                  },
                  icon: Icon(
                    viewModelProvide.isObscure
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black,
                  ),
                ),
                hintText: "Password",
                hintStyle: GoogleFonts.openSans(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RegisterAndLogin extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Row(
      children: [
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "Register",
              size: 20.0,
              color: Colors.black,
            ),
            splashColor: Colors.lightBlueAccent,
            color: Color(0xffcceeed),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                await viewModelProvide.createUserWithEmailAndPassword(
                    context, _emailField.text, _passwordField.text);
              }
            },
          ),
        ),
        SizedBox(
          width: 7.0,
        ),
        Text(
          "OR",
          style: GoogleFonts.pacifico(fontSize: 14.0),
        ),
        SizedBox(
          width: 7.0,
        ),
        SizedBox(
          height: 50.0,
          width: 150.0,
          child: MaterialButton(
            child: OpenSans(
              text: "LOGIN",
              size: 20.0,
              color: Colors.black,
            ),
            splashColor: Colors.pinkAccent,
            color: Color(0xffedccee),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () async {
              if (formkey.currentState!.validate()) {
                viewModelProvide.signInWithEmailAndPassword(
                    context, _emailField.text, _passwordField.text);

                _emailField.clear();
                _passwordField.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}

DialogBoxtutor(BuildContext context, String title) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2.0),
      ),
      title: OpenSans(
        text: title,
        size: 20.0,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenBeforeLogin(),
            ));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: OpenSans(
            text: "Ok",
            size: 20.0,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}
