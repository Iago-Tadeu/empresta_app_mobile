import 'package:empresta_app_mobile/main_module.dart';
import 'package:empresta_app_mobile/src/app_module.dart';
import 'package:empresta_app_mobile/src/core/services/loan_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoanService.init();
  runApp(ModularApp(module: MainModule(), child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(routeAppLoading);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Empresta app",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      locale: const Locale("pt", "BR"),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
