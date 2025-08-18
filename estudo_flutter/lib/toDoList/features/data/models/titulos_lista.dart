// ignore: file_names
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';

class NomeListas {
  static Map<String, List<Tarefas>> nomeListas = {
    'Tarefas Pessoal': [],
    'Lista de Compras': [],
    'Estudo': [],
    'lista de desejos': [],
    'Projetos': [],
    'Trabalho': [],
    'Afazeres domesticos': [],
    'eventos e compromissos': [],
  };

  static void addTaskInLista(String nomeLista, Tarefas tarefa) {
    if (nomeListas.containsKey(nomeLista)) {
      nomeListas[nomeLista]?.add(tarefa);
    }
  }
}
