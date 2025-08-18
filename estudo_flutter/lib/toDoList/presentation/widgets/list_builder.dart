import 'package:estudo_flutter/toDoList/features/domain/usecases/delconfirm.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';

import 'package:flutter/material.dart';

class ListaConstrutor extends StatefulWidget {
  final String titleLista;
  final List<Tarefas> tarefas;
  final Function salvarLista;
  final void Function(int index) onRemoverTarefa;

  final void Function() onListaModificada;

  const ListaConstrutor({
    super.key,
    required this.titleLista,
    required this.tarefas,
    required this.salvarLista,
    required this.onListaModificada,
    required this.onRemoverTarefa,
  });

  @override
  State<ListaConstrutor> createState() => _ListaConstrutorState();
}

class _ListaConstrutorState extends State<ListaConstrutor> {
  List<Tarefas> get _tarefasDaLista => widget.tarefas;

  void _chamarRemocaoComConfirmacao(int index) {
    final item = widget.tarefas[index];
    Delconfirm.showMostrardiaLog(
      context: context,
      title: item.title,
      onDeleteConfirmed: () {
        widget.onRemoverTarefa(index); // <- chama o pai
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tarefa "${item.title}" removida com sucesso!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: _tarefasDaLista.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nenhuma tarefa adicionada',
                    style: TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _tarefasDaLista.length,
              itemBuilder: (context, index) {
                final item = _tarefasDaLista[index];
                return ListTile(
                  key: ValueKey(
                    item.title,
                  ), // Garante que cada ListTile é único
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _chamarRemocaoComConfirmacao(index);
                      });
                    },
                  ),

                  leading: Checkbox(
                    value: item.done,
                    onChanged: (value) {
                      // dentro do onChanged do Checkbox
                      setState(() {
                        item.done = value ?? false;
                      });
                      widget.onListaModificada();

                      
                    },
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      decoration: item.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text('Tarefa #${index + 1}'),
                      if (item.prioridade != null &&
                          item.prioridade!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.flag,
                          color: _getColor(item.prioridade!),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.prioridade!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getColor(item.prioridade!),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }
}

Color _getColor(String prioridade) {
  switch (prioridade) {
    case 'Baixa':
      return Colors.green;
    case 'Média':
      return const Color.fromARGB(255, 250, 154, 29);
    case 'Alta':
      return Colors.red;
    default:
      return Colors.grey; // Cor padrão se a prioridade não for reconhecida
  }
}
