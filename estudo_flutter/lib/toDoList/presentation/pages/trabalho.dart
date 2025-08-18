import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/features/data/repositories/tarefa_controller.dart';
import 'package:estudo_flutter/toDoList/features/domain/services/ordenar_lista.dart';
import 'package:estudo_flutter/toDoList/presentation/graphic/grafico.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/list_builder.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/task_con_pen.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/btn_add_task.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class Trabalho extends StatefulWidget {
  const Trabalho({super.key});

  @override
  State<Trabalho> createState() => _TrabalhoState();
}

class _TrabalhoState extends State<Trabalho> {
  final TarefaController _tarefaController = TarefaController(TarefasStorage());
  bool ordemCrescente = true;
  List<Tarefas> _listaTrabalho = List.from(
    NomeListas.nomeListas['Trabalho'] ?? [],
  );

  void _ordenarLista() {
    ordemCrescente = !ordemCrescente;
    _listaTrabalho = OrdenarLista.ordenarLista(_listaTrabalho, ordemCrescente);
    setState(() {
      _listaTrabalho = [..._listaTrabalho];
    });
  }

  void salvarLista() {
    _tarefaController.salvar('Trabalho', _listaTrabalho);
  }

  void _deletarLista() {
    setState(() {
      _listaTrabalho.clear();
      salvarLista();
    });
  }

  void _carregarLista() async {
    try {
      final tarefas = await _tarefaController.carregar('Trabalho');
      setState(() {
        _listaTrabalho.addAll(tarefas);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao carregar tarefas: $e')));
      }
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _listaTrabalho.removeAt(index);
      salvarLista();
    });
    _tarefaController.salvar('Trabalho', _listaTrabalho);
  }

  @override
  void initState() {
    super.initState();
    _carregarLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas Trabalho', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _ordenarLista,
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TaksGraphic(
                    totalTask: _listaTrabalho.length,
                    completeTask: _listaTrabalho.where((c) => c.done).length,
                    pendingTask: _listaTrabalho.where((c) => !c.done).length,
                  ),
                  TaskConPen(titleList: _listaTrabalho),
                  TextButton(
                    onPressed: _deletarLista,
                    child: Text('deletar lista de trabalho'),
                  ),
                ],
              ),
            ),

            ListaConstrutor(
              titleLista: 'Trabalho',
              tarefas: _listaTrabalho,
              salvarLista: salvarLista,
              onListaModificada: () => {
                setState(() {
                  _listaTrabalho = [..._listaTrabalho];
                }),
                salvarLista(),
              },
              onRemoverTarefa: _removerTarefa,
            ),

            BtnAddTask(listaTarefas: _listaTrabalho),
          ],
        ),
      ),
    );
  }
}
