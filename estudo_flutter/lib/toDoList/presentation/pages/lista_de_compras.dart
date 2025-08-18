import 'package:estudo_flutter/toDoList/features/data/datasources/tarefas_storage.dart';
import 'package:estudo_flutter/toDoList/features/data/models/tarefas.dart';
import 'package:estudo_flutter/toDoList/features/data/models/titulos_lista.dart';
import 'package:estudo_flutter/toDoList/features/data/repositories/tarefa_controller.dart';
import 'package:estudo_flutter/toDoList/presentation/graphic/grafico.dart';

import 'package:estudo_flutter/toDoList/presentation/pages/add_task.dart';

import 'package:estudo_flutter/toDoList/presentation/widgets/list_builder.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/task_con_pen.dart';
import 'package:estudo_flutter/toDoList/presentation/widgets/menu.dart';
import 'package:flutter/material.dart';

class ListaDeCompras extends StatefulWidget {
  const ListaDeCompras({super.key});

  @override
  State<ListaDeCompras> createState() => _ListaDeComprasState();
}

class _ListaDeComprasState extends State<ListaDeCompras> {
  bool ordemCrescente = true;
  List<Tarefas> _listaDeCompras = List.from(
    NomeListas.nomeListas['Lista de Compras'] ?? [],
  );
  final TarefaController _controllerStorage = TarefaController(
    TarefasStorage(),
  );

  void _removerTarefa(int index) {
    setState(() {
      _listaDeCompras.removeAt(index);
    });
  }

  void _carregarLista() async {
    try {
      final tarefa = await _controllerStorage.carregar('Lista de compras');
      setState(() {
        _listaDeCompras.addAll(tarefa);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao carregar tarefas: $e')));
      }
    }
  }

  void _salvarLista() {
    _controllerStorage.salvar('Lista de Compras', _listaDeCompras);
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
        title: Text('Lista de Compras'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              ordemCrescente
                  ? Icons.arrow_upward_sharp
                  : Icons.arrow_downward_sharp,
            ),
          ),
        ],
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.115,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () async {
                        final novaTarefa = await Navigator.push<Tarefas>(
                          context,
                          MaterialPageRoute(builder: (context) => Addtask()),
                        );

                        if (novaTarefa != null) {
                          setState(() {
                            _listaDeCompras.add(novaTarefa);
                          });
                          _salvarLista(); // salva se quiser persistir imediatamente
                        }
                      },
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(vertical: 10),
                    child: TaksGraphic(
                      totalTask: _listaDeCompras.length,
                      completeTask: _listaDeCompras.where((t) => t.done).length,
                      pendingTask: _listaDeCompras.where((t) => !t.done).length,
                    ),
                  ),

                  TaskConPen(titleList: _listaDeCompras),
                ],
              ),

              ListaConstrutor(
                titleLista: 'Lista de Compras',
                tarefas: _listaDeCompras,
                salvarLista: _salvarLista,
                onListaModificada: () => {
                  setState(() {
                    _listaDeCompras = [..._listaDeCompras];
                    _salvarLista();
                  }),
                },
                onRemoverTarefa: _removerTarefa,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
