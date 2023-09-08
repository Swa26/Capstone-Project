import 'package:capstoneproject/admin_login.dart';
import 'package:capstoneproject/admin_page.dart';
import 'package:capstoneproject/cakeHome_view.dart';
import 'package:capstoneproject/login_view.dart';
import 'package:capstoneproject/main.dart';
import 'package:capstoneproject/screenBefore_login.dart';
import 'package:capstoneproject/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginHandler extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    // TODO: implement build
    return _authState.when(
      data: (data) {
        if (data != null) {
          if (role == "user") {
            return CakeHomeView();
          } else if (role == "admin") {
            // return AdminOrdersView();
            return OrdersView();
          } else {
            return ScreenBeforeLogin();
          }
        } else {
          if (role == "user") {
            return LoginView();
          } else if (role == "admin") {
            return AdminLoginView();
          } else {
            return ScreenBeforeLogin();
          }
        }
      },
      error: (error, stackTrace) {
        return LoginView();
      },
      loading: () => CircularProgressIndicator(),
    );
  }
}
