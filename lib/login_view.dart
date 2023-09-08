import 'package:capstoneproject/components.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class LoginView extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    final viewModelProvide = ref.watch(viewModel);
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text('B.Tech CakeWala'),
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
                  SizedBox(
                    height: 20.0,
                  ),
                  SignInButton(
                    buttonType: ButtonType.google,
                    btnColor: Color(0XFFE39FF6),
                    btnTextColor: Colors.black,
                    buttonSize: ButtonSize.medium,
                    onPressed: () async {
                      viewModelProvide.signInWithGoogleWeb(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

TextEditingController _emailFieldUser = TextEditingController();
TextEditingController _passwordFieldUser = TextEditingController();

class EmailAndPassWordFields extends HookConsumerWidget {
  //final List _name = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvide = ref.watch(viewModel);
    return Column(
      children: [
        //Email
        SizedBox(
          width: 350.0,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            textAlign: TextAlign.center,
            controller: _emailFieldUser,
            onChanged: (value) {
              username = _emailFieldUser.text;
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
            controller: _passwordFieldUser,
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
              await viewModelProvide.createUserWithEmailAndPassword(
                  context, _emailFieldUser.text, _passwordFieldUser.text);
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
              viewModelProvide.signInWithEmailAndPassword(
                  context, _emailFieldUser.text, _passwordFieldUser.text);
            },
          ),
        ),
      ],
    );
  }
}
