import 'package:meuapp/compartilhar/services/supabase_database.dart';

abstract class AppDatabase {
  static final AppDatabase instance = SupabaseDatabase();
  void init();
  Future<bool> login({required String email, required String senha});
  Future<bool> criarConta(
      {required String email, required String senha, required String nome});
}
