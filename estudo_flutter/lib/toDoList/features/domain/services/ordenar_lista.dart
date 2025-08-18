import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';

class OrdenarLista {
  static List<Tarefas> ordenarLista(
    List<Tarefas> lista,
    bool ordemCrescente,
  ) {
    final prioridade = {'Baixa': 0, 'Média': 1, 'Alta': 2};

    lista.sort((a, b) {
      int prioridadeA = prioridade[a.prioridade] ?? 0;
      int prioridadeB = prioridade[b.prioridade] ?? 0;
      
      return ordemCrescente
          ? prioridadeB.compareTo(prioridadeA)
          : prioridadeA.compareTo(prioridadeB);
    });

    return lista;
  }
}
