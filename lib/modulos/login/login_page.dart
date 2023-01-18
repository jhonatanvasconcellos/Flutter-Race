// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meuapp/compartilhar/tema/app_theme.dart';
import 'package:meuapp/modulos/login/login_controller.dart';
import 'package:meuapp/modulos/login/paginas/criar_conta/criar_conta_page.dart';
import 'package:validators/validators.dart';
import '../../compartilhar/widget/Button/button.dart';
import '../../compartilhar/widget/input_text/input_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller.addListener(() {
      controller.state.when(
          success: (value) => Navigator.popAndPushNamed(context, "/home"),
          error: (message, _) => scaffoldKey.currentState!
              .showBottomSheet((context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => Container(
                        child: Text(message),
                      ))),
          orElse: () {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/imagens/logo.png",
                  width: 200,
                ),
                InputText(
                  label: "Email",
                  hint: "Digite seu email",
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  onChanged: (value) => controller.onChanged(email: value),
                ),
                SizedBox(
                  height: 18,
                ),
                InputText(
                  label: "Senha",
                  obscure: true,
                  hint: "Digite sua senha",
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha válida",
                  onChanged: (value) => controller.onChanged(senha: value),
                ),
                SizedBox(height: 14),
                AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) => controller.state.when(
                          loading: () => CircularProgressIndicator(),
                          orElse: () => Button(
                            label: "Entrar",
                            onTap: () {
                              controller.login();
                            },
                          ),
                        )),
                SizedBox(height: 50),
                Button(
                  label: "Criar conta",
                  type: ButtonType.outline,
                  onTap: () {
                    Navigator.pushNamed(context, "/login/criar_conta");
                  },
                )
              ],
            ),
          ),
        ));
  }
}
