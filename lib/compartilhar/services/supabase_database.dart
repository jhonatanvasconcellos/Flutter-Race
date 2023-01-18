
import 'package:flutter/foundation.dart';
import 'package:meuapp/compartilhar/services/app_database.dart';
import 'package:supabase/supabase.dart';

class SupabaseDatabase implements AppDatabase {
  late final SupabaseClient client;

  SupabaseDatabase(){
    init();
  }

  @override
  void init() {
    client = SupabaseClient(
      const String.fromEnvironment("SUPABASEURL"),
      const String.fromEnvironment("SUPABASEKEY"),
    );

    if (!kReleaseMode) {
      print("Database Inicializado");
      print("URL: ${client.supabaseUrl}, KEY: ${client.supabaseKey}");
      }
  }

  @override
  Future<bool> criarConta(
      {required String email, required String senha, required String nome}) async {
    final response = await 
    
  }

  @override
  Future<bool> login({required String email, required String senha}) {
    throw UnimplementedError();
  }
}
