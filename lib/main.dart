import 'package:capstoneproject/firebase_options.dart';
import 'package:capstoneproject/screenBefore_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'admin_page.dart';

String role = "";
String username = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ProviderScope(
      child: (const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          backgroundColor: Colors.pinkAccent,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent,
            selectedIconTheme: IconThemeData(
              size: 35.0,
              color: Colors.black,
            ),
          ),
        ),
        title: "BTech CakeWala",
        home: ScreenBeforeLogin());
  }
}
