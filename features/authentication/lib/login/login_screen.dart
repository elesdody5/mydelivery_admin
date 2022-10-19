import 'package:authentication/widgets/login_form.dart';
import 'package:core/base_provider.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:widgets/logo.dart';

import 'login_provider.dart';

class LoginScreen extends StatelessWidget {
  late LoginProvider provider;

  void _setupListener() {
    _setupErrorMessageListener(provider.errorMessage);
    setupLoadingListener(provider.isLoading);
    setupNavigationListener(provider.navigation);
  }

  void _setupErrorMessageListener(RxnString errorMessage) {
    ever(errorMessage, (String? message) {
      if (message != null) {
        showErrorDialog(message);
        errorMessage.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<LoginProvider>(context, listen: false);
    _setupListener();
    return Scaffold(
        body: Consumer<LoginProvider>(builder: (context, provider, child) {
      return SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const Logo(),
                LoginForm(
                  login: provider.login,
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
