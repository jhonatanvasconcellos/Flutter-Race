// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meuapp/modulos/login/paginas/criar_conta/criar_conta_controller.dart';
import 'package:validators/validators.dart';

import '../../../../compartilhar/tema/app_theme.dart';
import '../../../../compartilhar/widget/Button/button.dart';
import '../../../../compartilhar/widget/input_text/input_text.dart';

class CriarConta extends StatefulWidget {
  const CriarConta({Key? key}) : super(key: key);

  @override
  State<CriarConta> createState() => _CriarContaState();
}

class _CriarContaState extends State<CriarConta> {
  final controller = CriarContaController();
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.background,
          leading: BackButton(color: AppTheme.colors.BackButton),
          elevation: 0,
        ),
        backgroundColor: AppTheme.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Criando sua conta",
                  style: AppTheme.textStyles.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mantenha seus gastos em dia",
                  style: AppTheme.textStyles.subtitle,
                ),
                SizedBox(
                  height: 38,
                ),
                InputText(
                  label: "Nome",
                  hint: "Digite seu nome",
                  validator: (value) =>
                      value.isNotEmpty ? null : "Digite o seu nome",
                  onChanged: (value) => controller.onChanged(nome: value),
                ),
                InputText(
                  label: "E-mail",
                  hint: "Digite seu email",
                  validator: (value) =>
                      isEmail(value) ? null : "Digite um e-mail válido",
                  onChanged: (value) => controller.onChanged(email: value),
                ),
                SizedBox(height: 18),
                InputText(
                  label: "Senha",
                  obscure: true,
                  hint: "Digite sua senha",
                  validator: (value) =>
                      value.length >= 6 ? null : "Digite uma senha mais forte",
                  onChanged: (value) => controller.onChanged(senha: value),
                ),
                SizedBox(height: 14),
                AnimatedBuilder(
                    animation: controller,
                    builder: (_, __) => controller.state.when(
                          loading: () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              CircularProgressIndicator(),
                            ],
                          ),
                          orElse: () => Button(
                            label: "Criar Conta",
                            onTap: () {
                              controller.criar();
                            },
                          ),
                        ))
              ],
            ),
          ),
        ));
  }
}
