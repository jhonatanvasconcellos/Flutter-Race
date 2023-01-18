// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meuapp/compartilhar/utilidade/state.dart';

import '../../../../compartilhar/services/app_database.dart';

class CriarContaController extends ChangeNotifier {
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = "";
  String _senha = "";
  String _nome = "";

  void onChanged({String? email, String? senha, String? nome}) {
    _email = email ?? _email;
    _senha = senha ?? _senha;
    _nome = nome ?? _nome;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> criar() async {
    if (validate()) {
      try {
        update(AppState.loading());
        await AppDatabase.instance
            .criarConta(nome: _nome, email: _email, senha: _senha);
        update(AppState.success<String>("Deu certo"));
      } catch (e) {
        update(AppState.error("Não foi possível criar conta"));
      }
    }
  }
}
