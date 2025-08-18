import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';

class TarefaController {
  final TarefasStorage storage;

  TarefaController(this.storage);
// Carrega a lista de tarefas armazenada
  Future<List<Tarefas>> carregar(String nomeLista) =>
      storage.carregarLista(nomeLista);
 // Salva a lista de tarefas
  Future<void> salvar(String nomeLista, List<Tarefas> tarefas) =>
      storage.salvarlista(nomeLista, tarefas);

  
}
