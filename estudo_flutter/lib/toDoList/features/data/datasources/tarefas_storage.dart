import 'dart:convert';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefasStorage {
  
  // Salva a lista com o nome personalizado como chave
  Future<void> salvarlista(String nomeLista, List<Tarefas> lista) async {
    final prefs = await SharedPreferences.getInstance();
    final listaConvertida = lista
        .map((t) => t.task().cast<String, dynamic>())
        .toList();

    prefs.setString(nomeLista, jsonEncode(listaConvertida));
  }

  // Carrega apenas a lista com o nome específico
  Future<List<Tarefas>> carregarLista(String nomeLista) async {
    final prefs = await SharedPreferences.getInstance();
    final String? dados = prefs.getString(nomeLista);

    if (dados == null) return [];
    final List listaDecodificada = jsonDecode(dados);

    return listaDecodificada
        .map((item) => Tarefas.fromMap(item.cast<String, dynamic>()))
        .toList();
  }
}
