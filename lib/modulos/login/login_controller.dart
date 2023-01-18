import 'package:flutter/material.dart';
import 'package:meuapp/compartilhar/services/app_database.dart';
import 'package:meuapp/compartilhar/utilidade/state.dart';

class LoginController extends ChangeNotifier {
  AppState state = AppState.empty();
  final formKey = GlobalKey<FormState>();
  String _email = "";
  String _senha = "";

  void onChanged({String? email, String? senha}) {
    _email = email ?? _email;
    _senha = senha ?? _senha;
  }

  bool validate() {
    final form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  Future<void> login() async {
    if (validate()) {
      try {
        update(AppState.loading());
        await AppDatabase.instance.login(email: _email, senha: _senha);
        //Chamada do backend
        // ignore: prefer_const_constructors
        update(AppState.success<String>("Usuario logado"));
      } catch (e) {
        update(AppState.error("Não foi possível realizar login"));
      }
    }
  }
}
