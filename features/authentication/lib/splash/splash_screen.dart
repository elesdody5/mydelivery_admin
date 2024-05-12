import 'package:authentication/splash/splash_provider.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double logoSize = 50;

  Future<void> autoLogin(BuildContext context) async {
    final provider = Provider.of<SplashProvider>(context, listen: false);
    setupNavigationListener(provider.navigation);
    provider.autoLogin();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
  }

  Future<void> setData() async {
    _controller.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      logoSize = 210;
    });
  }

  @override
  void didChangeDependencies() {
    setData();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    autoLogin(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
          height: logoSize,
          constraints: BoxConstraints(minHeight: logoSize),
          child: Image.asset(
            "assets/images/mydelivery_logo.png",
          ),
        ),
      ),
    );
  }
}
