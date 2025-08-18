// ignore: file_names
import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';
import 'package:estudo_flutter/toDoList/features/data/repositories/tarefa_controller.dart';
import 'package:estudo_flutter/toDoList/features/domain/services/ordenar_lista.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';

import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/presentation/graphic/grafico.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/list_builder.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/task_con_pen.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/btn_add_task.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class TarefasPessoais extends StatefulWidget {
  const TarefasPessoais({super.key});

  @override
  State<TarefasPessoais> createState() => _TarefasPessoaisState();
}

class _TarefasPessoaisState extends State<TarefasPessoais> {
  // Controlador para gerenciar o armazenamento de tarefas

  final TarefaController _controlerStorage = TarefaController(TarefasStorage());
  bool ordemCrescente = true;
  List<Tarefas> _listaPessoal = List.from(
    NomeListas.nomeListas['Tarefas Pessoal'] ?? [],
  );

  void ordenarLista() {
    setState(() {
      ordemCrescente = !ordemCrescente;
      _listaPessoal = OrdenarLista.ordenarLista(_listaPessoal, ordemCrescente);
    });
  } //ordena a lista de tarefas com base na prioridade

  void _limparLista() {
    setState(() {
      _listaPessoal.clear();
    });
    _salvarLista(); // agora o storage é atualizado
  }

  void _removerTarefa(int index) {
    setState(() {
      _listaPessoal.removeAt(index);
    });
    _salvarLista();
  }

  void _salvarLista() {
    _controlerStorage.salvar('Tarefas Pessoal', _listaPessoal);
  }

  void _carregarLista() async {
    try {
      final tarefa = await _controlerStorage.carregar('Tarefas Pessoal');
      setState(() {
        _listaPessoal = [...tarefa];
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao carregar tarefas: $e')));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarLista();

    // Carrega a lista de tarefas ao iniciar o widget
    // Isso garante que as tarefas salvas anteriormente sejam exibidas quando o app for aberto
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Pessoais', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: ordenarLista,
            icon: Icon(
              ordemCrescente
                  ? (Icons.arrow_upward_sharp)
                  : (Icons.arrow_downward_sharp),
            ),
            tooltip: 'Ordernar Tarefas',
            color: Colors.white,
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: TaksGraphic(
                      totalTask: _listaPessoal.length,
                      completeTask: _listaPessoal.where((t) => t.done).length,
                      pendingTask: _listaPessoal.where((t) => !t.done).length,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: _limparLista,
                          child: Text('deletar toda a lista'),
                        ),
                        TextButton(
                          onPressed: _salvarLista,
                          child: Text('Salvar Lista'),
                        ),
                        TaskConPen(titleList: _listaPessoal),
                      ],
                    ),
                  ),
                ],
              ),

              ListaConstrutor(
                titleLista: 'Tarefas Pessoal',
                tarefas: _listaPessoal,
                salvarLista: _salvarLista,
                onListaModificada: () {
                  setState(() {
                    _listaPessoal = [..._listaPessoal];
                  });
                  _salvarLista();
                },
                onRemoverTarefa: _removerTarefa,
              ),

              BtnAddTask(listaTarefas: _listaPessoal),
            ],
          ),
        ),
      ),
    );
  }
}
