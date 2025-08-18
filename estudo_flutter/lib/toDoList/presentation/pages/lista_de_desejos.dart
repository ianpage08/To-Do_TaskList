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

class ListaDeDesejos extends StatefulWidget {
  const ListaDeDesejos({super.key});

  @override
  State<ListaDeDesejos> createState() => _ListaDeDesejosState();
}

class _ListaDeDesejosState extends State<ListaDeDesejos> {
  final TarefaController _tarefaController = TarefaController(TarefasStorage());
  bool ordemCrescente = true;
  List<Tarefas> _listaDesejos = List.from(
    NomeListas.nomeListas['Lista de Desejos'] ?? [],
  );

  void _ordenarLista() {
    ordemCrescente = !ordemCrescente;
    _listaDesejos = OrdenarLista.ordenarLista(_listaDesejos, ordemCrescente);
    setState(() {
      _listaDesejos = [..._listaDesejos];
    });
  }

  void salvarLista() {
    _tarefaController.salvar('Lista de Desejos', _listaDesejos);
  }

  void _carregarLista() async {
    try {
      final tarefas = await _tarefaController.carregar('Lista de Desejos');
      setState(() {
        _listaDesejos = [...tarefas];
      });
    } catch (e) {
      Text('Erro de execução $e');
    }
  }

  void _removerTarefa(int index) {
    setState(() {
      _listaDesejos.removeAt(index);
    });
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
        title: Text('Tarefas Pessoais', style: TextStyle(color: Colors.white)),
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
                    totalTask: _listaDesejos.length,
                    completeTask: _listaDesejos.where((c) => c.done).length,
                    pendingTask: _listaDesejos.where((c) => !c.done).length,
                  ),
                  TaskConPen(titleList: _listaDesejos),
                ],
              ),
            ),
            ListaConstrutor(
              titleLista: 'Lista de Desejos',
              tarefas: _listaDesejos,
              salvarLista: salvarLista,
              onListaModificada: () => {
                setState(() {
                  _listaDesejos = [..._listaDesejos];
                  salvarLista();
                }),
              },
              onRemoverTarefa: _removerTarefa,
            ),

            BtnAddTask(listaTarefas: _listaDesejos),
          ],
        ),
      ),
    );
  }
}
