import 'package:flutter/material.dart';
import 'package:meuapp/modulos/login/login_page.dart';
import 'package:meuapp/modulos/login/paginas/criar_conta/criar_conta_page.dart';
import 'package:meuapp/modulos/splash/splashpage.dart';

import 'modulos/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Race 1",
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashPage(),
        "/login": (context) => const LoginPage(),
        "/login/criar_conta": (context) => const CriarConta(),
        "/home": (context) => const HomePage()
      },
    );
  }
}
