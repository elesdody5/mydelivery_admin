import 'package:authentication/signup/signup_provider.dart';
import 'package:authentication/widgets/singup_form.dart';
import 'package:core/base_provider.dart';
import 'package:core/domain/user_type.dart';
import 'package:core/screens.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:cool_alert/cool_alert.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool init = true;
  late SignUpProvider provider;

  @override
  void didChangeDependencies() {
    if (init) {
      provider = Provider.of<SignUpProvider>(context, listen: false);
      UserType? userType = Get.arguments;
      provider.signUpModel.userType = userType;
      _setupListener();
      init = false;
    }
    super.didChangeDependencies();
  }

  void _setupListener() {
    setupLoadingListener(provider.isLoading);
    setupNavigationListener(provider.navigation);
    setupErrorMessageListener(provider.errorMessage);
    _setupSuccessMessageListener(provider.successMessage);
  }

  void _setupSuccessMessageListener(RxnString successMessage) {
    ever(successMessage, (String? message) {
      if (message != null) {
        CoolAlert.show(
            context: Get.context!,
            type: CoolAlertType.success,
            text: message.tr,
            onConfirmBtnTap: () => Get.offAndToNamed(homeScreen));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<SignUpProvider>(builder: (context, provider, child) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(
                  "My Delivery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "ماى ديليفرى",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SignupForm(
                  signUpModel: provider.signUpModel,
                  signup: provider.signUp,
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
