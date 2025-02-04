import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppStatusLoadingView extends StatefulWidget {
  const AppStatusLoadingView({super.key});

  @override
  State<AppStatusLoadingView> createState() => _AppStatusLoadingViewState();
}

class _AppStatusLoadingViewState extends State<AppStatusLoadingView> {
  @override
  void initState() {
    super.initState();
    redirectToHome();
  }

  Future<void> redirectToHome() async {
    await Future.delayed(Duration(seconds: 2));
    Modular.to.pushReplacementNamed("/app/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Spacer(),
        Expanded(
          child: Image.asset("assets/images/like.png"),
        ),
        Spacer(),
      ]),
    );
  }
}
